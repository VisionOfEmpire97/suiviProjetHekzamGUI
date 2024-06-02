#import "template.typ" : base
#show: doc => base(
  // left_header:[],
  right_header : [Equipe scan-GUI-Printemps-2024],
  title: [Projet Hekzam-GUI],
  subtitle: [Technical documentation],
  version: [1.0],
  authors:(
    (
    name: "REGRAGUI MARTINS Marco",
    affiliation:"Paul Sabatier University",
    email:"",
    ),
    ( 
    name: "ROSET Nathan",
    affiliation:"Paul Sabatier University",
    email:"",
    ),
    (
    name: "SANCHEZ Emilien",
    affiliation:"Paul Sabatier University",
    email:"",
    ),
    (
    name: "YABAR Fabio",
    affiliation:"Paul Sabatier University",
    email:"",
    ) 
  ),
    doc
)
// TODO Add authors
// Nom du tuteur sur la doc ou pas ?
// TODO Add a front cover
#outline(
  title: "Table of Content",
)
#v(1fr)
#align(right,[_Last edited on June 2#super[nd] 2024_])

#pagebreak()

= Context
// context goes here

= Definitions

- *Hekzam* : The whole program, #link("https://github.com/hekzam")[(GUI + parser + generator)], including frontend and backend.
- *Project* : a directory regrouping all files generated during the execution by Hekzam.
- *Exam*#footnote[_Sujet d'examen_] : Batch of questions asked to students to evaluate them
- *Paper*#footnote[_Copie_] : refers to one batch of pages filled by a single student during an examination session.
- *Page*#footnote[_page_] : Scan of a single sheet, each uniquely identified.

= User Manual


= Current State of the Frontend By module

== Main Window

== Information Box
This text zone show the binding problem’s between the copies and the Json.

== CLI
== Saving and Restoring User Configuration

== Project Data Management

=== Collecting Data

=== Storing Data

==== JSONReader

==== ScanInfo

=== Saving and Restoring Data

== Evaluation Table
What’s working
- [ ] Sort button that allows one to hide or display specific columns of the table
- [ ] Field view checkbox that change’s the table’s view from grouped to detailed
- [ ] Table that details each exam, copy, page, field and syntax of an exam paper (field or grouped syntax depending on the view)
- [ ] Interaction between table and preview that displays data according to a cell’s column

== Search Function within the Table
=== Searchbar

    - Signal -> 
	-> change carac

    - Slot -> searchprocess
			-> test format with regex 
			-> process the different type of search

        - Unknown -> error message
        - Simple ->  select the columns and filter the rows
        - Multiple -> select the columns, create the regex via join and filter the rows
        - Tag -> select the column, create the list of tag and the list of regex and filter the rows

=== Fuzzy search
	It’s an approximate string matching. It show a list of the first nearest found words. Implement the Wagner and Fischer algorithm’s which use the concept of the distance of Levenshtein (cf. Links).
	It use a dynamic threshold (30% of the size of the string but doesn’t seem to be the perfect ratio).
	The fuzzy search only work for the simple and multiple text search due to do a lack of time for implement it for the tag search (more complicate)
	

=== AtomicSearchBox
	Allow there user to do an atomic search (search the exact word with the pattern instead of searching a match with the regex)
    - work only for the simple search (for the multiple because I use the join character it will search for the concatenation of the word)
    - it doesn’t work for the tag search because it’s not even implemented in `filterTagSearchRow`
== Preview
=== Layout in the Window
This is described in the `preview.h` file directly (in French!).
One thing of note is the existence of two previews and two scenes, but I focused on one pair and left the other totally empty.
=== ExamViewPort
Subclass of `QGraphicsView`, allows you to render a scene. This class allows you to zoom in and out of the scene without transforming the objects in the scene.  
- Antialiasing and `FullViewportUpdate` are turned on because I noticed small visual artifacts when a specific brush was set for highlighting fields. 
- The attribute `dimensionToConsider` and the `scaleToFit` enum are here to allow the dev or even the user to scale the page they're viewing to fit the whole height or width of the page in the viewport. *Full height* has been selected for now.
=== ExamScene
Subclass of `QGraphicsScene`, will be filled with items to be rendered by the view. This class can *manipulates* items directly. The most important parts are the `loadImage` and `loadAnswerSheets` functions.
=== PageMask
Subclass of `QGraphicsPathItem`. First a mask is initialized over the whole page when it's loaded, then subpaths are added to add transparency where we want them (over the fields). The mask is refreshed every time the page is reloaded (right now, this means every time we click on a cell).
=== ExamSinglePage
Subclass of `QGraphicsPixmapItem`. Holds the attributes of the page. Parent of every other all the Item Fields. this is where the functions that perform the unit conversions are defined. They allow you to convert JSON coordinates from the parser to Image coordinates used in the preview, and vice versa. This is also where the `FieldItems` are initialized.
=== FieldItems
Subclass of `QGraphicsPolygonItem`. *Generic polygon* that is then subclassed in `AtomicBoxItems` and `MarkerItems` with different properties. Each item is able to send data to the underlying library with `sendNewDataToLib`.\
Here's a tip: when re-implementing a mouseEvent in a subclass of QGraphicsItem, do not forget to call the corresponding mouseEvent of the parent class.
_Example_ : see ```cpp void MarkerItem::mouseReleaseEvent(QGraphicsSceneMouseEvent *event)``` in `markeritem.cpp`.
==== Why the use of `QVariant` ?
In `FieldItem::sendNewDataToLib`, we send `QMap<QString, QList<QVariant>>` as it allows us to use one function to reflect changes to all the fields. In the case of markers, the data we send is a list of new coordinates, but in the case of Atomic Boxes, it's simply a boolean value. Using QVariants wraps every possible type into one.

= Description of the test case
Description of the test case GOES HERE
= Known Bugs
== Markers, MarkerHandles and coordinate systems
_It is possible to move a whole Marker and its corners (called `MarkerHandles` in code) individually. But this feature was implemented at the tail end of the project so some bugs flew under my radar._
- Fixing and converting the coordinates systems used by the markers.
  - Every `FieldItem` on the page is actually located at `QPointF(0,0)` (the origin of the scene, in the top-left corner) in page coordinates, with a polygon drawn at the correct location. This causes strange behavior when moving a marker around (see `qDebug` output when moving a marker). The only value I was able to ensure was consistently correct was the displacement relative to the starting point of the item. I became aware of this issue too late to fix it because it did not cause any visual bug but will surely be very annoying when other libraries will receive that data.
  - Changes to the position of an marker are not reflected on his corners, meaning that moving the whole marker from its initial position, then moving a corner will exhibit weird behavior as the corner's position hasn't been updated from the prior move.
  - The next step would then be to actually convert the positions from their page coordinates (in pixels) back into parser coordinates in millimeters. (The test JSON files we had available had every coordinate in millimeters).

= Missing features
- menu bar
- modifications Table -> preview
- counting papers submitted
- #text(fill: rgb("#2CBEC0"), [Preview : ])The `FieldItem::getRect` is used to inform the `QGraphicsView` of the new region to display when the user clicks on a "field" cell inside the Table. The call stack is :\
  #par(justify: false,[`FieldItem::getRect -> ExamSinglePage::getFieldPos -> Examscene::setROI -> ExamViewPort::fitROIInView`.])
  But `fitROIInView` wasn't implemented due to the lack of time.

= What’s not working
- [ ] Column that specifies a field’s value (checked/unchecked or sentence) and the ability to modify it directly from the table
- [ ] Associate missing files once the table’s data was initialized
- [ ] Delete an exam, copy or a page from the table
- [ ] Mark a field as modified in the table

= What could be improved
- Change the distance of Levenshtein by the distance of Damerau-Levenshtein
- variables in ScanInfo could be renamed to match the Table Headers
- The minimum size of the Preview might be too restrictive, feel free to reduce `minPreviewSize` and change the `previewSizePolicy` if needed.
- The second preview viewport (only visible when the primary preview is present in another window) has been left unused for now. It might be a good idea to reconsider if it's useful or not.<secondpreview>
- the image is reloaded every time we click on a field. Could be an area of improvement if you have the time.
== Preview module
- Hiding the mouse cursor when moving a corner of a marker could improve accuracy.

== What needs to be removed

- [ ] The `JsonLinker` class associates pages with their corresponding Json file by matching the file names
- [ ] This association also allows the exam, copies, pages and fields to be initialized using specific data structures
- [ ] The `PageInfo` data structure contains an attribute that describes the path of the file it is associated with
- [ ] All of these points will not be necessary once the library allowing a page to be associated with its json file is properly implemented
- [ ] I used the `mViewPort` and `mJSON` namespaces in some parts of the code, but they might be useless, remove them if you will.

= OS specific issues
== MacOS
- MacOS specific error message
== Linux
=== Wayland
- window position cannot be restored because Wayland

= Sources
#link("https://doc.qt.io/qt-6/qtwidgets-index.html")[Qt official documentation]\
#link("https://fr.wikipedia.org/wiki/Distance_de_Levenshtein")[Levenshtein distance]\ 
#link("https://fr.wikipedia.org/wiki/Distance_de_Damerau-Levenshtein")[Levenshtein-Damerau distance]\ 
