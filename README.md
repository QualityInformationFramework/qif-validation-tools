# TODO

* The QIFDocument.xsd file in the main download has a signature which slows down the validation and then eventually makes it fail. This needs to be understood and then documented.
* Create a release with EXE for the validator; add to README
* Create a release with EXE for the checker; add to README

# qif3-validation-tools

Additional validation tools for QIF3, including additional XSLT checks, an XSLT checking app, and a QIF schema checking app

## Copyright

Copyright 2018-2020, Capvidia, Metrosage, and project contributors

https://www.capvidia.com/

## License

See [License](LICENSE.md)


.\xml_validate.exe "C:\dev\src\qif3-validation-tools\qif3\sampleCheckInstanceFiles3\WIDGET_QIF_PLAN_W_QPIDS.QIF" "C:\dev\src\qif3-validation-tools\qif3\QIFApplications\QIFDocument.xsd"
