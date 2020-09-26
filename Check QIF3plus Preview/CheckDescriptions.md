# XSLT Check Descriptions - Detail

## 1 CheckDocument.xsl

The Check Document.xsl file is used to trigger the use of CheckFormat.xsl, CheckQuality.xsl, and CheckSemantic.xsl.

In addition, it contains over 300 checks between linked files that a reference from one aspect of a feature or characteristic to another aspect of the same type of feature or characteristic does indeed do that. For example, if a circle feature measurement in a QIF results file intends to reference a circle feature item in an external QIF plan file, there is a check that the referenced object is a circle feature item and not anything else (such as a flatness definition or a torus feature item). The same set of checks is made within single instance files by key/keyref pairs, but key and keyref apply only within a single file and cannot be used with linked files.

Finally, CheckDocument.xsl checks that the recursion depth of checking does not exceed the MaxRecursionLevel parameter.

## 2 CheckFormat.xsl

The CheckFormat.xsl file is used to make the following checks

### 2.1 Number of elements in list

Several dozen types of lists of elements are defined in QIF, for example, the `PartSet` in a `Product` is a list of `Parts`. Each of these lists has an `n` attribute giving the number of elements in the list. It is checked that the actual count of elements in the list is equal to `n`. This check is performed on every list of elements containing an `n` attribute. 

Example:

```xml
<Error>
  <Report>The number of array elements doesn't correspond to the specified "n" attribute: n(3) != nElem(2)</Report>
  <Node>/QIFDocument/DatumReferenceFrames/DatumReferenceFrame{691}/Datums</Node>
</Error>
```

### 2.2 Maximum id of model objects

The object ids must be less than or equal to `idMax`.

Example:

```xml
<Error>
  <Report>The id of element is greater than idMax. id(1520) greater than idMax(1515).</Report>
  <Node>/QIFDocument/StandardsDefinitions/Standard{1520}</Node>
</Error>
```

### 2.3 External references

A QIF document **D** may contain references to elements in external QIF documents. To do this, **D** must include the Uniform Resource Identifier (URI) and QPId of each external document. It is checked that, for each external QIF document of **D**:

a.	A file **E** exists with the URI given in **D**, and **E** has a `QIFDocument` element in it
b.	The `QPId` of the `QIFDocument` in **E** is the one given in **D**
c.	Every external entity reference in **D** that is supposed to be in **E** is, in fact, in **E**.

### 2.4 NURBS curves – nCP/nKt/order

NURBS curves - It is checked that in any 2D or 3D NURBS curve, the number of control points equals the number of knots minus the order of the curve

Example:

```xml
<Error>
  <Report>Nurbs12Core/Nurbs13Core: id=205, nCP(63) != nKt(66) - order(5)</Report>
  <Node>/QIFDocument/Product/GeometrySet/Curve12Set/Nurbs12{205}/Nurbs12Core</Node>
</Error>
```

### 2.5 NURBS surfaces – nCP/nKt/order

NURBS surfaces - It is checked that for any NURBS surfaces the number of control points equals the product of `(nKtU - ordU)` and `(nKtV - ordV)`.

Example:

```xml
<Error>
  <Report>Nurbs23Core: id=102, nCP(16) != (nKtU(8) - ordU(4)) * (nKtV(8) - ordV(5))</Report>
  <Node>/QIFDocument/Product/GeometrySet/SurfaceSet/Nurbs23{102}/Nurbs23Core</Node>
</Error>
```

### 2.6 NURBS curves - nWt/nCP 

```diff
+ Proposed new check for future QIF versions
```

NURBS curves - the number of weights (if present) must be equal to the number of control points.

Example:

```xml
<Error>
  <Report>Nurbs12Core/Nurbs13Core/Nurbs23Core: id=208, nCP(5) != nWt(6)</Report>
  <Node>/QIFDocument/Product/GeometrySet/Curve12Set/Nurbs12{208}/Nurbs12Core</Node>
</Error>
```

### 2.7 NURBS surfaces – nWt/nCP

```diff
+ Proposed new check for future QIF versions
```

NURBS surfaces - It is checked that for any NURBS surfaces, the number of weights (if present) must be equal to the number of control points.

Example:

```xml
<Error>
  <Report>Nurbs12Core/Nurbs13Core/Nurbs23Core: id=208, nCP(5) != nWt(6)</Report>
  <Node>/QIFDocument/Product/GeometrySet/SurfaceSet/Nurbs23{208}/Nurbs23Core</Node>
</Error>
```

### 2.8 MeshTriangle – nNb/nTr

```diff
+ Proposed new check for future QIF versions
```

MeshTriangle - the number of neighbors (if present) must be equal to the number of triangles.

Example:

```xml
<Error>
  <Report>MeshTriangleCore: id=348, nNb(419) != nTr(418)</Report>
  <Node>/QIFDocument/Product/GeometrySet/SurfaceMeshSet/MeshTriangle{348}/MeshTriangleCore</Node>
</Error>
```

### 2.9 MeshTriangle – nNm/nVx

```diff
+ Proposed new check for future QIF versions
```

MeshTriangle - the number of normals (if present) must be equal to the number of vertices.

Example:

```xml
<Error>
  <Report>MeshTriangleCore: id=348, nNm(270) != nVx(269)</Report>
  <Node>/QIFDocument/Product/GeometrySet/SurfaceMeshSet/MeshTriangle{348}/MeshTriangleCore</Node>
</Error>
```

### 2.10 FaceMesh – nTrVisible/nTr

```diff
+ Proposed new check for future QIF versions
```

FaceMesh - the number of visible triangles (if present) must be less or equal to then number of triangles.

Example:

```xml
<Error>
  <Report>FaceMesh: id=365, nTrVisible (500) is greater than nTr(418)</Report>
  <Node>/QIFDocument/Product/TopologySet/FaceSet/FaceMesh{365}</Node>
</Error>
```

### 2.11 FaceMesh – nTrHidden/nTr

```diff
+ Proposed new check for future QIF versions
```

FaceMesh - the number of hidden triangles (if present) must be less or equal to then number of triangles.

Example:

```xml
<Error>
  <Report>FaceMesh: id=365, nTrHidden(500) is greater than nTr(418)</Report>
  <Node>/QIFDocument/Product/TopologySet/FaceSet/FaceMesh{365}</Node>
</Error>
```

### 2.12 FaceMesh – nTrColor/nTr

```diff
+ Proposed new check for future QIF versions
```

FaceMesh - the number of colors (if present) must be equal to then number of triangles.

Example:

```xml
<Error>
  <Report>FaceMesh: id=365, nTrColor(419) != nTr(418)</Report>
  <Node>/QIFDocument/Product/TopologySet/FaceSet/FaceMesh{365}</Node>
</Error>
```

### 2.13 Array of doubles

```diff
+ Proposed new check for future QIF versions
```

Array of doubles (`ArrayDoubleType`) - the number of double values in array must be equal to the `@count`.

Example:

```xml
<Error>
  <Report>ArrayDoubleType: nNumberActual(6) != count(5)</Report>
  <Node>/QIFDocument/Product/GeometrySet/Curve12Set/Nurbs12{208}/Nurbs12Core/Weights</Node>
</Error>
```

### 2.14 Array of 2D points

```diff
+ Proposed new check for future QIF versions
```

Array of 2D points (`ArrayPoint2dType`) - the number of 2D points in array must be equal to the `@count`.

Example:

```xml
<Error>
  <Report>ArrayPoint2dType: nNumberActual(11) != nNumberRequired(10), count(5)</Report>
  <Node>/QIFDocument/Product/GeometrySet/Curve12Set/Nurbs12[6]{237}/Nurbs12Core/CPs</Node>
</Error>
```

### 2.15 Array of 3D points

```diff
+ Proposed new check for future QIF versions
```

Array of 3D points (`ArrayPointType`)	- the number of 3D points in array must be equal to the `@count`.

Example:

```xml
<Error>
  <Report>ArrayPointType: nNumberActual(49) != nNumberRequired(48), count(16)</Report>
  <Node>/QIFDocument/Product/GeometrySet/SurfaceSet/Nurbs23{102}/Nurbs23Core/CPs</Node>
</Error>
```

### 2.16 Array of integer pairs

```diff
+ Proposed new check for future QIF versions
```

Array of integer pairs (`ArrayI2Type`) - the number of integer pairs in array must be equal to the `@count`.

Example:

```xml
<Error>
  <Report>ArrayI2Type: nNumberActual(97) != nNumberRequired(96), count(48)</Report>
  <Node>/QIFDocument/Product/GeometrySet/CurveMeshSet/PathTriangulation{355}/PathTriangulationCore/Edges</Node>
</Error>
```

## 3 CheckQuality.xsl

The CheckQuality.xsl file is used to make the following checks

### 3.1 Excessively high-degree Surface (G-SU-HD)

Check that there are no NURBS surfaces of excessively high degree. The maximum degree is a parameter that may be set in CheckParameters.xml.

Parameters:

```xml
<CheckParameters>
  ...
  <CheckQualityParameters>
    <Check name="G-SU-HD">
      <Parameter name="MaxDegree">8</Parameter>
    </Check>
    ...
  </CheckQualityParameters>
  ...
</CheckParameters>
```

### 3.2 Free edge (G-SH-FR)

Check that there are no free edges. A free edge is an edge that is used by only one face in a shell.

Example:

```xml
<Error>
  <Report>Free edge (G-SH-FR): id=204, nEdgeRef(1)</Report>
  <Node>/QIFDocument/Product/TopologySet/EdgeSet/Edge{204}</Node>
</Error>
```

### 3.3 Over-used edge (G-SH-NM)

Check that there are no overused edges. A overused edge is an edge that is used by more than two faces in a shell.

Example:

```xml
<Error>
  <Report>Over-used edge (G-SH-NM): id=225, nEdgeRef(3)</Report>
  <Node>/QIFDocument/Product/TopologySet/EdgeSet/Edge[3]{225}</Node>
</Error>
```

### 3.4 Fragmented curve (G-CU-FG)

Check that 2D and 3D polylines do not have excessively many segments. The maximum number of segments is a parameter that may be set in CheckParameters.xml.

Parameters:

```xml
<CheckParameters>
  ...
  <CheckQualityParameters>
    <Check name="G-CU-FG">
      <Parameter name="MaxNumSegments">200</Parameter>
    </Check>
    ...
  </CheckQualityParameters>
  ...
</CheckParameters>
```

Example:

```xml
<Error>
  <Report>Fragmented curve (G-CU-FG): id=101 nSeg(207) greater than MaxNumSegments(200)</Report>
  <Node>/QIFDocument/Product/GeometrySet/Curve13Set/Polyline13{101}/Polyline13Core</Node>
</Error>
```

### 3.5 Unit vector length

The length of a unit vector must be close to 1.

Parameters:

```xml
<CheckParameters>
  ...
  <CheckFormatParameters>
    <Check name="unitVectorLength">
      <Parameter name="MinLength">0.99999999</Parameter>
      <Parameter name="MaxLength">1.00000001</Parameter>
    </Check>
  </CheckFormatParameters>
  ...
</CheckParameters> 
```

Example:

```xml
<Error>
  <Report>Unit vector too long: length of (1.0001 -0 0) greater than 1.00000001</Report>
  <Node>/QIFDocument/Product/GeometrySet/Curve13Set/ArcCircular13{11}/ArcCircular13Core/Normal</Node>
</Error>
```

### 3.6 Unused parametric patches - (G-SU-UN)

```diff
+ Proposed new check for future QIF versions
```

Surface entity contains patches that are not used in any face of a solid.

Example:

```xml
<Error>
  <Report>Unused parametric patch (G-SU-UN): id=662</Report>
  <Node>/QIFDocument/Product/GeometrySet/SurfaceSet/Nurbs23[7]{662}</Node>
</Error>
```

### 3.7 Unused mesh patches - (G-SU-UN)

```diff
+ Proposed new check for future QIF versions
```

Surface entity contains patches that are not used in any face of a solid.

Example:

```xml
<Error>
  <Report>Unused mesh patch (G-SU-UN): id=662</Report>
  <Node>/QIFDocument/Product/GeometrySet/SurfaceMeshSet/MeshTriangle[7]{662}</Node>
</Error>
```

### 3.8 Inconsistent face on surface - (G-FA-IT)

```diff
+ Proposed new check for future QIF versions
```

The direction of the face normal vectors is inconsistent with its underlying surface.

Example:

```xml
<Error>
  <Report>Inconsistent face on surface (G-FA-IT): id=174</Report>
  <Node>/QIFDocument/Product/TopologySet/FaceSet/Face{174}</Node>
</Error>
```

### 3.9 Multi-region parametric surface - (G-FA-MU)

```diff
+ Proposed new check for future QIF versions
```

More than one face associated with a single base surface.

Example:

```xml
<Error>
  <Report>Multi-region parametric surface (G-FA-MU): id=164, nLink=2</Report>
  <Node>/QIFDocument/Product/GeometrySet/SurfaceSet/Nurbs23[6]{164}</Node>
</Error>
```

### 3.10 Multi-region mesh surface - (G-FA-MU)

```diff
+ Proposed new check for future QIF versions
```

More than one face associated with a single base surface.

Example:

```xml
<Error>
  <Report>Multi-region mesh surface (G-FA-MU): id=164, nLink=2</Report>
  <Node>/QIFDocument/Product/GeometrySet/SurfaceMeshSet/MeshTriangle[6]{164}</Node>
</Error>
```

### 3.11 Over-used vertex - (G-SH-OU)

```diff
+ Proposed new check for future QIF versions
```

A vertex is shared by too many edges.

Parameters:

```xml
<CheckParameters>
  ...
  <CheckQualityParameters>
    <Check name="G-SH-OU">
      <Parameter name="MaxLinks">4</Parameter>
    </Check>
    ...
  </CheckQualityParameters>
  ...
</CheckParameters>
```

Example:

```xml
<Error>
  <Report>Over-used vertex (G-SH-OU): id=41, nLink(8) greater than MaxLinks(4)</Report>
  <Node>/QIFDocument/Product/TopologySet/VertexSet/Vertex[9]{41}</Node>
</Error>
```

### 3.12 Solid void - (G-SO-VO)

```diff
+ Proposed new check for future QIF versions
```

Body has internal void.

Example:

```xml
<Error>
  <Report>Solid void (G-SO-VO): id=167, nShell(2) greater than 1</Report>
  <Node>/QIFDocument/Product/TopologySet/BodySet/Body{167}/ShellIds</Node>
</Error>
```

### 3.13 Over-Used Face - (G-FA-OU)

```diff
+ Proposed new check for future QIF versions
```

A face which is used in more than one shell.

Example:

```xml
<Error>
  <Report>Over-Used Face (G-FA-OU): id=7, nLink(2) greater than 1</Report>
  <Node>/QIFDocument/Product/TopologySet/FaceSet/Face{7}</Node>
</Error>
```

### 3.14 Unviewed Annotation - (A-AN-UV)

```diff
+ Proposed new check for future QIF versions
```

An annotation is not included in a saved view.

Example:

```xml
<Error>
  <Report>Unviewed Annotation (A-AN-UV): id=684</Report>
  <Node>/QIFDocument/DatumDefinitions/DatumDefinition{684}</Node>
</Error>
```

### 3.15 Non-Graphical Annotation - (A-AN-NG)

```diff
+ Proposed new check for future QIF versions
```

The semantic representation of an annotation has no corresponding graphical representation.

Example:

```xml
<Error>
  <Report>Non-Graphical Annotation (A-AN-NG): id=1441</Report>
  <Node>/QIFDocument/Characteristics/CharacteristicNominals/PerpendicularityCharacteristicNominal{1441}</Node>
</Error>
```

### 3.16 Multi-volume solid - (G-SO-MU)

```diff
+ Proposed new check for future QIF versions
```

A model contains multiple solid bodies.

Example:

```xml
<Error>
  <Report>Multi-volume solid (G-SO-MU): id=2, nLink(6) greater than 1</Report>
  <Node>/QIFDocument/Product/PartSet/Part{2}</Node>
</Error>
```

### 3.17 Inconsistent face in shell - (G-SH-IT)

```diff
+ Proposed new check for future QIF versions
```

Faces with normal vectors pointing in opposite directions share a common boundary.

Example:

```xml
<Error>
  <Report>Inconsistent face in shell (G-SH-IT): face=174, faces=179, 177, 178, 175,</Report>
  <Node>/QIFDocument/Product/TopologySet/FaceSet/Face{174}</Node>
</Error>
```

## 4 CheckSemantic.xsl

The CheckSemantic.xsl file is used to make the following checks

### 4.1 FeatureNominal connected with topology

A given FeatureNominal is connected to an entity (which should be a topology entity). This check is optional and is inactive by default. It can be activated via CheckParamaters.xml. If the connection is to an internal entity, a separate key/keyref check ensures that the entity is a topology entity. If the connection is to an external entity, its type is not checked.

Parameters:

```xml
<CheckParameters>
  ...
  <CheckSemanticParameters>
    <Check name="FeatureNominalTopologyLink" active="false">
    </Check>
  </CheckSemanticParameters>
  ...
</CheckParameters>
```

### 4.2 Position characteristic definition - material condition

In any position characteristic definition, if the tolerance is zero, the material condition must be maximum.

Example:

```xml
<Error>
  <Report>PositionCharacteristicDefinition: id=704, ToleranceValue=0 and MaterialCondition(NONE) != 'MAXIMUM'</Report>
  <Node>/QIFDocument/Characteristics/CharacteristicDefinitions/PositionCharacteristicDefinition{704}</Node>
</Error>
```

### 4.3 Shell - faces

```diff
+ Proposed new check for future QIF versions
```

Shell must refer to faces from the body that contains this shell.

Example:

```xml
<Error>
  <Report>Shell refers to face from another body: body=7, shell=40, face=18</Report>
  <Node>/QIFDocument/Product/TopologySet/ShellSet/Shell{40}/FaceIds/Id</Node>
</Error>
```

### 4.4 Face - loops

```diff
+ Proposed new check for future QIF versions
```

Face must refer to loops from the body that contains this face.

Example:

```xml
<Error>
  <Report>Face refers to loop from another body: body=7, face=29, loop=28</Report>
  <Node>/QIFDocument/Product/TopologySet/FaceSet/Face[2]{29}/LoopIds/Id</Node>
</Error>
```

### 4.5 Loop - edges

```diff
+ Proposed new check for future QIF versions
```

Loop must refer to edges from the body that contains this loop.

Example:

```xml
<Error>
  <Report>Loop refers to edge from another body: body=7, loop=17, edge=14</Report>
  <Node>/QIFDocument/Product/TopologySet/LoopSet/Loop{17}/CoEdges/CoEdge/EdgeOriented/Id</Node>
</Error>
```

### 4.6 Edge - vertices

```diff
+ Proposed new check for future QIF versions
```

Edge must refer to vertices from the body that contains this edge.

Example:

```xml
<Error>
  <Report>Edge refers to vertex from another body: body=7, edge=16, vertex=10</Report>
  <Node>/QIFDocument/Product/TopologySet/EdgeSet/Edge[2]{16}/VertexEnd/Id</Node>
</Error>
```

### 4.7 Shell - sewed faces

```diff
+ Proposed new check for future QIF versions
```

Faces from a shell can be sewed with faces only from this shell.

Example:

```xml
<Error>
  <Report>Face from shell sewed with face from another shell: shell=165, face=7</Report>
  <Node>/QIFDocument/Product/TopologySet/FaceSet/Face{7}</Node>
</Error>
```

### 4.8 Body form

```diff
+ Proposed new check for future QIF versions
```

Check body form.

* `SOLID`: body must refer to at least one shell, body must refer to at least one face
* `WIRE`: body must not refer to shell, body must not refer to face
* `TRIMMED_SURFACE`: body must refer to at least one face

Example:

```xml
<Error>
  <Report>Body form: id(6), form(TRIMMED_SURFACE), nShell(0), nFace(0) - should refer to faces</Report>
  <Node>/QIFDocument/Product/TopologySet/BodySet/Body{6}</Node>
</Error>

<Error>
  <Report>Body form: id(12), form(SOLID), nShell(0), nFace(0) - should refer to faces and shells</Report>
  <Node>/QIFDocument/Product/TopologySet/BodySet/Body[2]{12}</Node>
</Error>

<Error>
  <Report>Body form: id(12), form(WIRE), nShell(0), nFace(2) - should not refer to faces and shells</Report>
  <Node>/QIFDocument/Product/TopologySet/BodySet/Body[2]{12}</Node>
</Error>
```

### 4.9 Body topology

```diff
+ Proposed new check for future QIF versions
```

Do not share topology entities between different bodies.

Example:

```xml
<Error>
  <Report>Body: id(6), vertex_id(8), n_link(2) - vertex shared between bodies</Report>
  <Node>/QIFDocument/Product/TopologySet/BodySet/Body{6}/VertexIds/Id</Node>
</Error>

<Error>
  <Report>Body: id(6), edge_id(11), n_link(2) - edge shared between bodies</Report>
  <Node>/QIFDocument/Product/TopologySet/BodySet/Body{6}/EdgeIds/Id</Node>
</Error>

<Error>
  <Report>Body: id(6), loop_id(11), n_link(2) - loop shared between bodies</Report>
  <Node>/QIFDocument/Product/TopologySet/BodySet/Body{6}/EdgeIds/Id</Node>
</Error>

<Error>
  <Report>Body: id(6), face_id(11), n_link(2) - face shared between bodies</Report>
  <Node>/QIFDocument/Product/TopologySet/BodySet/Body{6}/EdgeIds/Id</Node>
</Error>

<Error>
  <Report>Body: id(6), shell_id(11), n_link(2) - shell shared between bodies</Report>
  <Node>/QIFDocument/Product/TopologySet/BodySet/Body{6}/EdgeIds/Id</Node>
</Error>
```