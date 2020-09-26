:: This script will allow you to easily run the "xml_validate" tool on ALL
:: QIF INSTANCE FILES in the specified directory. The results of the schema
:: validation will be outputted to a unique file corresponding to the 
:: instance file. 
:: This script allow you to set up variables which specify: 
:: 
:: xml_validate - the path to the xml_validate EXE file
:: xsd - the path to the QIF schemas
:: qif_folder - the path to the folder containing the instance files to check


:: ----------------------------------------------------------------------------
:: SET THESE 3 VALUES HERE
set xml_validate=..\xml_validate\bin\Release\netcoreapp3.1\xml_validate.exe
set xsd=..\qif3\QIFApplications\QIFDocument.xsd
set qif_folder=..\qif3\sampleCheckInstanceFiles3
:: ----------------------------------------------------------------------------

@for %%i in ("%qif_folder%\*.qif") do @(
    @echo "%%~nxi"
    "%xml_validate%" "%%~i" "%xsd%" > %%~ni.~.xml
)

pause