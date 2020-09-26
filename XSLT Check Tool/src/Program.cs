﻿///////////////////////////////////////////////////////////////////////////////
///
/// Copyright 2018-2020, Capvidia, Metrosage, and project contributors
/// https://www.capvidia.com/
/// 
/// This software is provided for free use to the QIF Community under the 
/// following license:
/// 
/// Boost Software License - Version 1.0 - August 17th, 2003
/// https://www.boost.org/LICENSE_1_0.txt
/// 
/// Permission is hereby granted, free of charge, to any person or organization
/// obtaining a copy of the software and accompanying documentation covered by
/// this license (the "Software") to use, reproduce, display, distribute,
/// execute, and transmit the Software, and to prepare derivative works of the
/// Software, and to permit third-parties to whom the Software is furnished to
/// do so, all subject to the following:
/// 
/// The copyright notices in the Software and this entire statement, including
/// the above license grant, this restriction and the following disclaimer,
/// must be included in all copies of the Software, in whole or in part, and
/// all derivative works of the Software, unless such copies or derivative
/// works are solely in the form of machine-executable object code generated by
/// a source language processor.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
/// SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
/// FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
/// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
/// DEALINGS IN THE SOFTWARE.

using System;
using System.Xml;
using System.Xml.Xsl;

namespace XSLTransformation
{
    public static class XslTransformer
    {
        public static void Main(string[] args)
        {
            System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo("en-us");

            // In .net core resolver turned off by default ("Resolving of external URIs was prohibited")
            // Enable resolver...
            AppContext.SetSwitch("Switch.System.Xml.AllowDefaultResolver", true);

            if (args.Length != 3 && args.Length != 4)
            {
                Console.WriteLine("xsl_transform <xml_file> <xsl_file> <destination> [-qif_ext]");
                return;
            }

            bool bUseExtension = false;
            if (args.Length == 4)
            {
                if (args[3] != "-qif_ext")
                {
                    Console.WriteLine("xsl_transform <xml_file> <xsl_file> <destination> [-qif_ext]");
                    Console.WriteLine("Error: unexpected key '" + args[3] + "'");
                    return;
                }
                bUseExtension = true;
            }

            try
            {
                XsltSettings settings = new XsltSettings(enableDocumentFunction: true, enableScript: true);
                XslCompiledTransform xslt = new XslCompiledTransform(/*enableDebug: true*/);
                xslt.Load(args[1], settings, new XmlUrlResolver());

                XsltArgumentList xslArg = null;
                if (bUseExtension)
                {
                    xslArg = new XsltArgumentList();
                    UserExtension ext = new UserExtension();
                    xslArg.AddExtensionObject("urn:my-scripts", ext);
                }

                XmlWriterSettings xws = xslt.OutputSettings.Clone();
                xws.Encoding = System.Text.Encoding.UTF8;

                using (XmlWriter xw = XmlWriter.Create(args[2], xws))
                    xslt.Transform(args[0], xslArg, xw);
            }

            catch (XsltException ex)
            {
                Console.WriteLine("Error: " + ex.Message);
                if (ex.InnerException != null)
                    Console.WriteLine("Inner exception: " + ex.InnerException.Message);
            }
        }
    }
    public class UserExtension
    {
        public int LengthArrayDouble(string s)
        {
            try
            {
                var a = Array.ConvertAll(s.Split(new char[] { ' ', '\n', '\r', '\t' }, StringSplitOptions.RemoveEmptyEntries), Double.Parse);
                return a.Length;
            }
            catch
            {
                return -1;
            }
        }

        public int LengthArrayInt(string s)
        {
            try
            {
                var a = Array.ConvertAll(s.Split(new char[] { ' ', '\n', '\r', '\t' }, StringSplitOptions.RemoveEmptyEntries), Int64.Parse);
                return a.Length;
            }
            catch
            {
                return -1;
            }
        }
    }
}