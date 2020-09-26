<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://qifstandards.org/xsd/qif3"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:user="urn:my-scripts"
                >
  
  <xsl:output method="xml" indent="yes" />

  <msxsl:script language="CSharp" implements-prefix="user">
    <![CDATA[
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
]]>
  </msxsl:script>

</xsl:stylesheet>
