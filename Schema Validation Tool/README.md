# QIF Instance File Validation Helper

This tool will help you to easily validate QIF instance files with a batch script. The results of the validation will be printed to a text file which will show the validation results. 

## How to use it

### Step 1: Build or Download `xml_validate.exe`

**Option 1: Build `xml_validate.exe`**

If you want to access and build the source code yourself, just open the file `xml_validate.sln` in Visual Studio 2019 or later and build the solution. This will create `xml_validate.exe`. 

**Option 2: Download `xml_validate.exe`**

[Navigate here and download the xml_validate.exe command line tool (for x64-windows)](https://github.com/capvidia-usa/qif-validation-tools/releases/tag/v1.0)

### Step 2: Run `easy_validate.bat`

This batch file will allow you to easily run the "xml_validate" tool on **ALL QIF INSTANCE FILES** in the specified directory. The results of the schema validation will be outputted to a unique file corresponding to the instance file. 

Inside the batch file, you need to specify a few values of your own. You can do this by opening the file in a text editor. Here's what you need to specify: 

* `xml_validate` - the path to the xml_validate EXE file (from Step 1, above)
* `xsd` - the path to the QIF schemas. [You need to download these yourself from the QIF Standards website](https://www.qifstandards.org/). 
* `qif_folder` - the path to the folder containing the instance files to validate

Once you have all these variables set, just run the batch file.

#### _Important Note about the QIF Schemas_

> **TLDR**: To use this validation tool, <a href="QIFDocument.xsd" download>replace the standard QIFDocument.xsd file with this one</a>. 

The `QIFDocument.xsd` schema file which is part of the QIF 3.0 download contains a remote reference to the [digital signature schema from the w3c](https://www.w3.org/TR/2002/REC-xmldsig-core-20020212/). You can find this on line 17-18: 

```
<xs:import namespace="http://www.w3.org/2000/09/xmldsig#"
    schemaLocation="http://www.w3.org/TR/2002/REC-xmldsig-core-20020212/xmldsig-core-schema.xsd"/>
```

This remote reference can cause a significant speed degradation, and eventually a failure, when code is trying to access this schema real-time for validation or other purposes. *If you keep this line as it is, then this Schema Validation tool will fail.* 

In order to avoid this issue, the above schema file has also been included as part of the QIF 3 download package. You need to replace the remote reference to `xmldsig-core-schema.xsd` with a local reference to `xmldsig-core-schema.xsd`. See the comment on line 20 of `QIFDocument.xsd` for instructions on how to do this. 

**Or, to make things even easier, just [download the schema file with the changes here,](https://github.com/capvidia-usa/qif-validation-tools/blob/master/Schema%20Validation%20Tool/QIFDocument.xsd) and replace your existing `QIFDocument.xsd` with this one.** 