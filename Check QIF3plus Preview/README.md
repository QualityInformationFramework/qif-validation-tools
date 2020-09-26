# XSLT Checks: QIF 3+ Preview

Here you will find a preview of the checks that are being progressed towards future releases of QIF. The check files here include all the checks in QIF 3, plus a bunch more. 

## XSLT Checks: Overview

The XML implementation of the QIF data model provides a number of benefits to QIF users. 
First, the QIF data model is implemented in XML Schema Definition Language which allows for automatic syntax and consistency checking of the standard itself, using widely available free or low-cost software tools.

Second, software implementations of the standard can take advantage of free or low-cost automatic source code generation tools. These tools provide computer language code which automatically consumes and produces QIF document instance files in XML format consistent with the syntax of the standard. [If you want to see the auto-generated source code bindings for QIF, look here.](https://github.com/QualityInformationFramework/qif-community/tree/master/bindings)

Third, QIF document instance files in XML format can be checked against the standard schemas with free or low-cost automatic tools. These tools will check that the structure of an instance file conforms to the QIF model. They will also check the validity of internal references in a file using keys and keyrefs as described in subclause 5.12. (Note: there is a free and easy to use tool that you can use in this very repository!)

Fourth, checks of the quality of information in QIF document instance files are available through the use of XSLT (Extensible Stylesheet Language Transformations) language checks. The XSLT checks are a normative part of the QIF specification. The XSLT checks can be performed by a number of widely available free tools (and by low-cost tools). The XSLT checks address both the integrity and semantics of individual instance files and the validity of references between linked instance files. Moreover, when there is tree of linked instance files, applying the XSLT checks to the file at the root of the tree results in the checks being applied to all files in the tree. Applying the XSLT checks results in an error report being generated as an XML file. (Note: there is a free and easy to use tool that you can use in this very repository!)

In QIF 3.0, the files that contain the XSLT checks are arranged in a small tree of six files with Check.xsl at the root. Check.xsl imports CheckDocuments.xsd, CheckFormat.xsl, CheckQuality.xsl, and CheckSemantic.xsl. Each of those four imported files imports CheckLibrary.xsl. The Check.xsl file triggers the use of the CheckDocuments.xsd file, which triggers the use of the other three. In this directory, you will find 2 additional XSL check files added to the tree.

The XSLT checks are parameterized. For example, the tolerance on the number of segments in a polyline is given by the MaxNumSegments parameter. Values of the parameters are set in the CheckParameters.xml file, which is accessed by the CheckLibrary.xsl file. A user may reset the parameters by editing CheckParameters.xml. Processing of linked instance files may be activated by the parameter CheckLinkedDocuments in CheckParamaters.xml, where MaxRecursionLevel defines the maximum recursion level. Format, quality and semantic checks may be activated by parameters CheckFormat, CheckQuality and CheckSemantic.

The XSLT checks are performed via four .xsl files, namely, CheckDocument.xsl, CheckFormat.xsl, CheckQuality.xsl, and CheckSemantic.xsl. The checks performed by each of these files are described in detail in the section below. 

## [Documentation of XSLT Checks - 3.0 and New Checks](CheckDescriptions.md)

[Here, you will find a detailed list and explanation of each the existing and new XSLT checks.](CheckDescriptions.md)

## List of XSLT Checks

In QIF 3.0, there are currently 22 checks that can be executed on an instance file. 

This package proposes **30 new checks**, which would bring that total to 52 total checks -- **an increase of almost 2.5X**.

The list of all XSLT checks are listed in the table below.


| XSLT   Check                                 | Category | Purpose                                                                                                            | New Check for Future QIF Versions? |
|----------------------------------------------|----------|--------------------------------------------------------------------------------------------------------------------|:------------------------------------:|
| Maximum   recursion level                    | General  | The recursion level of linked   documents must not exceed the specified level.                                     |                                      |
| Number   of elements                         | Format   | The number of elements in sets/arrays must be equal to the value specified in the   attribute 'n'.                 |                                      |
| Maximal   id of model objects                | Format   | The object ids must be less than or equal to idMax.                                                                |                                      |
| Link to   an external QIF document           | Format   | The specified external QIF   document must be found and its QPId must match the one given.                         |                                      |
| Link to   an external object                 | Format   | The specified entity must be   found in an external document.                                                      |                                      |
| Link to   a specific type of external object | Format   | The specified entity in an   external document must be the right type of entity (over 300 cases).                  |                                      |
| NURBS   curve                                | Format   | The number of control points   must be equal to the number of knots minus the curve order.                         |                                      |
| NURBS   surface                              | Format   | The number of control points   must be equal to ('nKtU' - 'ordU')*('nKtV' - 'ordV').                               |                                      |
| NURBS   curve                                | Format   | The number of weights (if   present) must be equal to the number of control points.                                |                   X                  |
| NURBS   surface                              | Format   | The number of weights (if   present) must be equal to the number of control points.                                |                   X                  |
| MeshTriangle                                 | Format   | The number of neighbors (if   present) must be equal to the number of triangles.                                   |                   X                  |
| MeshTriangle                                 | Format   | The number of normals (if   present) must be equal to the number of vertices.                                      |                   X                  |
| FaceMesh                                     | Format   | The number of visible triangles   (if present) must be less or equal to then number of triangles.                  |                   X                  |
| FaceMesh                                     | Format   | The number of hidden triangles   (if present) must be less or equal to then number of triangles.                   |                   X                  |
| FaceMesh                                     | Format   | The number of colors (if   present) must be equal to then number of triangles.                                     |                   X                  |
| Array of   doubles<br>(ArrayDoubleType)      | Format   | The number of double values in array must be   equal to the ‘@count’.                                              |                   X                  |
| Array of   2D points<br>(ArrayPoint2dType)   | Format   | The number of 2D points in array must be equal   to the ‘@count’.                                                  |                   X                  |
| Array of   3D points<br>(ArrayPointType)     | Format   | The number of 3D points in array must be equal   to the ‘@count’.                                                  |                   X                  |
| Array of   integer pairs<br>(ArrayI2Type)       | Format   | The number of integer pairs in array must be   equal to the ‘@count’.                                              |                   X                  |
| Feature   nominal                            | Semantic | Feature nominals must be   connected to topology entities.                                                         |                                      |
| Position   characteristic definition         | Semantic | If the ToleranceValue in a   Position characteristic definition is 0 then the MaterialCondition must be   MAXIMUM. |                                      |
| Shell                                        | Semantic | Shell must refer to faces from   the body that contains this shell.                                                |                   X                  |
| Face                                         | Semantic | Face must refer to loops from   the body that contains this face.                                                  |                   X                  |
| Loop                                         | Semantic | Loop must refer to edges from   the body that contains this loop.                                                  |                   X                  |
| Edge                                         | Semantic | Edge must refer to vertices from   the body that contains this edge.                                               |                   X                  |
| Shell                                        | Semantic | Faces from shell can be sewed   with faces only from this shell.                                                   |                   X                  |
| Body                                         | Semantic | Check body form.<br>SOLID:   body must refer to at least one shell, body must refer to at least one face<br>WIRE:   body must not refer to shell, body must not refer to face<br>TRIMMED_SURFACE:   body must refer to at least one face<br>|                   X                  |
| Body                                         | Semantic | Do not share topology entities   between different bodies.                                                         |                   X                  |
| High   degree curve                          | Quality  | Excessively high-degree curves   (G-CU-HD) must not be used.                                                       |                                      |
| Free   edge                                  | Quality  | Free edges (G-SH-FR) must not   be  used.                                                                          |                                      |
| Over-used   edge                             | Quality  | Over-used edges (G-SH-NM) must   not be  used.                                                                     |                                      |
| Fragmented   curve                           | Quality  | Fragmented curves (G-CU-FG) must   not be  used.                                                                   |                                      |
| Unit   vector length                         | Quality  | The length of a unit vector must   be close to 1.                                                                  |                                      |
| Unused   parametric patches                  | Quality  | (G-SU-UN) Surface entity   contains patches that are not used in any face of a solid.                              |                   X                  |
| Unused   mesh patches                        | Quality  | (G-SU-UN) Surface entity   contains patches that are not used in any face of a solid.                              |                   X                  |
| Inconsistent   face on surface               | Quality  | (G-FA-IT) The direction of the   face normal vectors is inconsistent with its underlying surface.                  |                   X                  |
| Multi-region   parametric surface            | Quality  | (G-FA-MU) More than one face   associated with a single base surface.                                              |                   X                  |
| Multi-region   mesh surface                  | Quality  | (G-FA-MU) More than one face   associated with a single base surface.                                              |                   X                  |
| Over-used   vertex                           | Quality  | (G-SH-OU) A vertex is shared by   too many edges.                                                                  |                   X                  |
| Solid   void                                 | Quality  | (G-SO-VO) Body has internal   void.                                                                                |                   X                  |
| Over-Used   Face                             | Quality  | (G-FA-OU) A face which is used in more than one shell.                                                             |                   X                  |
| Unviewed   Annotation                        | Quality  | (A-AN-UV) An annotation is not   included in a saved view.                                                         |                   X                  |
| Non-Graphical   Annotation                   | Quality  | (A-AN-NG) The semantic   representation of an annotation has no corresponding graphics.                            |                   X                  |
| Multi-volume   solid                         | Quality  | (G-SO-MU) A model contains   multiple solid bodies.                                                                |                   X                  |
| Inconsistent   face in shell                 | Quality  | (G-SH-IT) Faces with normal   vectors pointing in opposite directions share a common boundary.                     |                   X                  |

## List of XSLT Check Parameters

| Parameter              | Type             | Purpose                                          | New Parameter for Future QIF Versions? |
|------------------------|------------------|--------------------------------------------------|:------------------------------------:|
| CheckFormat            | boolean          | Enable/disable the format   checks.              |                                      |
| CheckQuality           | boolean          | Enable/disable the quality   checks.             |                                      |
| CheckSemantic          | boolean          | Enable/disable the semantic   checks.            |                                      |
| CheckLinkedDocuments   | boolean          | Enable/disable processing of   linked documents. |                                      |
| MaxRecursionLevel      | unsigned integer | Maximum recursion level of   linked documents.   |                                      |
| G-CU-HD/MaxDegree      | unsigned integer | Maximum NURBS curve/surface   degree.            |                                      |
| G-CU-FG/MaxNumSegments | unsigned integer | Maximum number of curve   fragments.             |                                      |
| G-SH-OU/MaxLinks       | unsigned integer | Maximum number of edges shared   by vertex.      |                   X                  |
| unitVectorLength       | two doubles      | Maximum and Minimum unit vector   length.        |                                      |

**Example**:

```xml
<?xml version="1.0" encoding="utf-8"?>
<CheckParameters>
  <Parameter name="CheckFormat">true</Parameter>
  <Parameter name="CheckQuality">true</Parameter>
  <Parameter name="CheckSemantic">true</Parameter>
  <Parameter name="CheckLinkedDocuments">true</Parameter>
  <Parameter name="MaxRecursionLevel">1</Parameter>
  <CheckFormatParameters>
    <Check name="unitVectorLength">
      <Parameter name="MinLength">0.99999999</Parameter>
      <Parameter name="MaxLength">1.00000001</Parameter>
    </Check>
  </CheckFormatParameters>
  <CheckQualityParameters>
    <Check name="G-SH-OU">
      <Parameter name="MaxLinks">4</Parameter>
    </Check>
    <Check name="G-SU-HD">
      <Parameter name="MaxDegree">8</Parameter>
    </Check>
    <Check name="G-CU-FG">
      <Parameter name="MaxNumSegments">200</Parameter>
    </Check>
  </CheckQualityParameters>
  <CheckSemanticParameters>
    <Check name="FeatureNominalTopologyLink" active="false">
    </Check>
  </CheckSemanticParameters>
</CheckParameters>
```

## XSLT Extensions

Some of the new proposed checks for future QIF versions take advantage of advanced XSLT functionality. 

The following checks use the XSLT extensions:

* Array of doubles (ArrayDoubleType)
* Array of 2D point (ArrayPoint2dType)
* Array of 3D points (ArrayPointType)
* Array of integer pairs (ArrayI2Type)

These checks analyze the textual content of elements stored in the arrays. They check that the text is a set of numbers with a given number of elements. The user-defined functions LengthArrayDouble and LengthArrayInt are used to parse the text strings. The functions take a string as input and return the number of elements of type “double” and “integer”.

To connect these functions, the XSLT extension in the MSXML .NET/.NET Core library is used. At the moment, the following options are available to activate verifications with these extensions:

|     Settings                                                                  |              Platform             |       Library      |     Checks                 |
|-------------------------------------------------------------------------------|:---------------------------------:|:------------------:|----------------------------|
|     Variable `use_msxml = true()`<br>Register extended functions in runtime    |     Windows,    Linux,   MacOS    |     .net   core    |     Use extended checks    |
|     Variable `use_msxml = true()`<br>Import CheckLibraryMSXML.xsl              |               Windows             |         .net       |     Use extended checks    |
|     Variable `use_msxml = false()`<br>Do not import CheckLibraryMSXML.xsl      |                  -                |          -         |     No extended checks     |

When using the MSXML processor on the Windows platform, you can connect the extensions directly from the xsl file - this is the 2nd option. The check in this mode is available, for example, in Visual Studio or other utilities/applications that are based on MSXML. Checkformat.xsl should start with the following lines:

```xml
  <xsl:import href="CheckLibrary.xsl"/>
  <xsl:import href="CheckLibraryMSXML.xsl"/>
  <xsl:output method="xml" indent="yes" />
  <xsl:variable name="use_msxml" select="true()"/>
```

The `.NET Core` library is available on different platforms and there you can also connect advanced XSLT functions, but only at runtime, i.e. passing a class with the implementation of the necessary functions in the XSLT processor initialization code. The following example contains the console utility code for .NET Core 3.1 that can be executed on Windows / Linux / MacOS. Checkformat.xsl should start with the following lines:

```xml
  <xsl:import href="CheckLibrary.xsl"/>
  <!--<xsl:import href="CheckLibraryMSXML.xsl"/>-->
  <xsl:output method="xml" indent="yes" />
  <xsl:variable name="use_msxml" select="true()"/>
```

In case of using other XSLT processors, you need to disable the use of these extensions. Checkformat.xsl should start with the following lines:

```xml
  <xsl:import href="CheckLibrary.xsl"/>
  <!--<xsl:import href="CheckLibraryMSXML.xsl"/>-->
  <xsl:output method="xml" indent="yes" />
  <xsl:variable name="use_msxml" select="false()"/>
```

> 👍![#c5f015](https://via.placeholder.com/15/c5f015/000000?text=+) **Tip** ![#c5f015](https://via.placeholder.com/15/c5f015/000000?text=+)👍
> 
> This method for creating XSLT checks with embedded C# code is a great way to easily create your own powerful custom checks!!


## Output Report File

Report file format:

```xml
<?xml version="1.0" encoding="utf-8"?>
<CheckReport>
  <CheckFormat>
    <!-- errors -->
  </CheckFormat>
  <CheckQuality>
    <!-- errors -->
  </CheckQuality>
  <CheckSemantic>
    <!-- errors -->
  </CheckSemantic>
  <CheckLinkedDocument uri="linked_document_name_1.qif">
    <!-- errors -->
  </CheckSemantic>
  ...
</CheckReport>
```

The CheckLinkedDocument appears for every linked document and also contains the CheckFormat, CheckQuality, and CheckSemantic sections.

Error format:

```xml
<Error>
  <Report>...</Report>
  <Node>...</Node>
</Error>
```

Where Report is a message, Node is an xpath path to the element with the reported error. The xpath also contains element identifiers (in `{}`), if the element has the `id` attribute. Example:

```xml
<Error>
  <Report>Inconsistent face on surface (G-FA-IT): id=42</Report>
  <Node>/QIFDocument/Product/TopologySet/FaceSet/Face[6]{42}</Node>
</Error>
```