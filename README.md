# :warning: TODO :warning:

* The QIFDocument.xsd file in the main download has a signature which slows down the validation and then eventually makes it fail. This needs to be understood and then documented.
* Create a release with EXE for the validator; add to README
* Create a release with EXE for the checker; add to README

# qif-validation-tools

Are you a QIF software developer, but are having a hard time validating your QIF instance files to the schema? Then you have come to the right place. 

This repository contains additional validation tools for QIF, including additional XSLT checks, an XSLT checking app, and a QIF schema checking app. 

## What's Here

* [**Check QIF3plus Preview**](https://github.com/capvidia-usa/qif-validation-tools/tree/master/Check%20QIF3plus%20Preview) - a preview of some of the enhancements to the XLST checks in the "Check" directory of the QIF standard. This contains all the checks from QIF 3.0, plus many more checks. If you are looking for a detailed list of all the XSLT checks new and old, [click here](https://github.com/capvidia-usa/qif-validation-tools/blob/master/Check%20QIF3plus%20Preview/CheckDescriptions.md). 
* [**Schema Validation Tool**](https://github.com/capvidia-usa/qif-validation-tools/tree/master/Schema%20Validation%20Tool) - a simple tool to help you quickly validate your QIF instance files. 
* [**XSLT Check Tool**](https://github.com/capvidia-usa/qif-validation-tools/tree/master/XSLT%20Check%20Tool) - a simple tool to help you run the QIF XSLT checks on your instance files. 

## Copyright

**Existing XSLT checks in QIF 3.0 are:**

Copyright © 2018 by Digital Metrology Standards Consortium, Inc. (DMSC)

**The Checking tool, Validation tool, and new Checks are:**

Copyright 2018-2020, [Capvidia](https://www.capvidia.com/), Metrosage, and project contributors

## License

See [License](LICENSE.md)

## Other Useful Tools

**Free XSLT Transformation Tools**

* [msxsl](https://www.microsoft.com/en-us/download/details.aspx?id=21714)
* [nxslt](https://github.com/shanselman/nxslt2)
* XmlNotepad
    * [GitHub Project](https://github.com/microsoft/XmlNotepad)
    * [Microsoft Site](https://www.microsoft.com/en-us/download/details.aspx?id=7973)
* [xsltproc](http://xmlsoft.org/XSLT/xsltproc2.html)

**Free XML Schema Validation Tools**

* [Visual Studio Community 2019](https://visualstudio.microsoft.com/vs/community/)
* XmlNotepad
    * [GitHub Project](https://github.com/microsoft/XmlNotepad)
    * [Microsoft Site](https://www.microsoft.com/en-us/download/details.aspx?id=7973)