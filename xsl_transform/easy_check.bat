:: This script will allow you to easily run the "xsl_transform" tool on ALL
:: QIF INSTANCE FILES in the specified directory. The results of the XSLT
:: check will be outputted to a unique file corresponding to the 
:: instance file. 
::
:: This script allow you to set up variables which specify: 
:: 
:: xsl_transform - the path to the xsl_transform EXE file
:: xsd - the path to the QIF schemas
:: qif_folder - the path to the folder containing the instance files to check

:: ----------------------------------------------------------------------------
:: SET THESE 3 VALUES HERE
set xsl_transform=src\bin\Release\netcoreapp3.1\xsl_transform.exe
set xsl=..\qif3\check\check.xsl
set qif_folder=..\qif3\sampleCheckInstanceFiles3
:: ----------------------------------------------------------------------------

@for %%i in ("%qif_folder%\*.qif") do @(
    @echo "%%~nxi"
    "%xsl_transform%" "%%~i" "%xsl%" %%~ni.~.xml -qif_ext
)

pause