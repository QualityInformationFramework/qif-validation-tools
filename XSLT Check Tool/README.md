# QIF Instance File XLST Check Helper

This tool will help you to easily check QIF instance files with the QIF XSLT checks, using a batch script. The results of the checks will be printed to a text file which will show the results. 

## How to use it

### Step 1: Build or Download `xsl_transform.exe`

**Option 1: Build `xsl_transform.exe`**

If you want to access and build the source code yourself, just open the file `xsl_transform.sln` in Visual Studio 2019 or later and build the solution. This will create `xsl_transform.exe`. 

**Option 2: Download `xsl_transform.exe`**

[Navigate here and download the xsl_transform.exe command line tool (for x64-windows)](https://github.com/capvidia-usa/qif-validation-tools/releases/tag/v1.0)

TODO

### Step 2: Run `easy_check.bat`

This batch file will allow you to easily run the "xsl_transform" tool on **ALL QIF INSTANCE FILES** in the specified directory. The results of the XSLT check will be outputted to a unique file corresponding to the instance file. 

Inside the batch file, you need to specify a few values of your own. You can do this by opening the file in a text editor. Here's what you need to specify: 

* `xsl_transform` - the path to the xsl_transform EXE file (from Step 1, above)
* `xsd` - the path to the QIF schemas. [You need to download these yourself from the QIF Standards website](https://www.qifstandards.org/). 
* `qif_folder` - the path to the folder containing the instance files to check

Once you have all these variables set, just run the batch file.