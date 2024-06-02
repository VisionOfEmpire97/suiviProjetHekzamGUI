#import "template.typ" : base, dirpath
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

#pagebreak(weak: true)

= Context
In any contemporary academic context, it would be foolish to ask for a teacher to grade hundreds or thousands of exam sheets every week. To ease their burden, several tools like AMC aim to automate this process. However, they’re more often than not dated, unmaintained and prone to errors. To tackle this issue, we have been tasked to design a *modern interface* for a new grading and polling tool called Hekzam.\
The Hekzam program is composed of several components. First, there’s the compiler that will generate exam printouts using *Typst* libraries. Then, a scanner interface will collect and convert if necessary the answer-filled sheets to produce images that will be passed on to the other components. The OCR component will then extract useful data from scanned sheets. And finally, an *automatic verification/grading interface* will allow the user to quickly check for erroneous scans, grade sheets or get statistics from one or multiple examination session. 
We describe the Graphical User Interface (or GUI) made using *C++* and *Qt Widget libraries* in this document.

= Definitions

- *Hekzam* : The whole program, #link("https://github.com/hekzam")[(GUI + parser + generator)], including frontend and backend.
- *Typst* : This is a typesetting tool that aims to replace LaTeX. Due to its novelty the API might be unstable.
- *Project* : a directory regrouping all files generated during the execution by Hekzam.
- *Exam*#footnote[_Sujet d'examen_] : Batch of questions asked to students to evaluate them
- *Paper*#footnote[_Copie_] : refers to one batch of pages filled by a single student during an examination session.
- *Page*#footnote[_Page_] : Scan of a single sheet, each uniquely identified.
- *Field*#footnote[_Champ_] : refers to a generic box with different properties based on its type. They all have positions on the page and a (unique ?) ID but AtomicBoxItems contains boolean values, MarkerItems can be moved by the user and OCRItems contain strings.
- *Signals & Slots in Qt* : Qt applications work by using events instead of callbacks. This mechanism is the way `QObjects` can communicate between each other. To make two unrelated objects communicate you `connect` a `signal` from one to the `slot` of the other. There's plenty of working examples in the code already.\
  #figure(
    align(left)[
    ```cpp
    connect(openButton, &QPushButton::clicked, this, &MainWindow::openProject);
    ```],
      caption: [_connection between a GUI element and a user-defined function_],
    )
  The requirements for working communications are : _a)_ both objects are subclasses of `QObject` and _b)_ the functions you're trying to connect have the same signature (the same number and type of arguments). Learn more about this mechanism in #link("https://doc.qt.io/qt-6/signalsandslots.html")[the official Qt documentation].\
 Be warned that `QGraphicsItem` cannot use signals and slots by default as they do not subclass `QObject` as it adds significant overhead according the Qt documentation.

= User Manual
_from the project `README.md`_:\
Execute the program either through Qt Creator after importing the project (easy) 
or by running `./scan-gui` after building.
- *If you haven't ran the program before*:
    - Click `Create a New Project`
    - In the field *Project Repository* : Select a directory to store the recovery data (useful for testing as you'll only need to pass this JSON file to open all previous files)
    - In the field *Exam Data* : select all or some of the files from #dirpath("resources/test_case/Json/")
    - In the field *Scan Files* : select all or some of the files from #dirpath("resources/test_case/Fichiers")
    - last field is left empty for now
- *If you've already ran the program before*
    - Click `Open an Existing Project`
    - Open the `data.json` file from the directory you specified in Project Repository.
Then you can :
 - Click on an entry in the table
 - Clicking on different columns yield different results
 - Click on the search bar to enter your search
 - Different type of search, the simple : _word_ , the multiple : _word1, word2, ..._ and the tag search : _tag1: word1; tag2: word2, word3;..._
 - Hovering the sliders below the preview opens up a tooltip that tells you what they do.
 - Interaction with the preview is basic. You can zoom in/out with the `Ctrl + Mouse wheel` combination (`cmd + scroll gesture on MacOS`), 
= Current State of the Frontend By module

== Main Window
=== Layout of the Window
The layout is described in the `mainwindow.h` file directly (in French!).

It is composed of a `QStackedWidget` that is going to switch between the different menus depending on our needs.

=== Main Menu
The main menu is only used to *open* or *create* a project. Thus, it is composed of two `QPushButton`.
- The first leads to the creation menu developed later.
- The second opens a file explorer where you can choose a save file to import. It will then redirect you to the evaluation menu.

=== Creation Menu
The creation menu acts as a `QFormLayout` formulary with a total of four fields to fill. In its current state, only the first three fields are working and necessary to continue.
Here is a quick rundown of what each field is :
- The first one is the location of the repository where you want the *save file* (`data.json`) to be.
- The second one is the list of *exam data* in the `Json` format.
- The third one is the list of *scan files* in the `png` or `pdf` formats.

After clicking next, the save file will be created and the Json and scans will be loaded. For more information about the save file, check #link(<data>)[this section].

It is possible to easily add new fields with the help of `addRow` on the `QFormLayout`, as well as the ```cpp QHBoxLayout *createFileEntry(const QString &labelText, QLineEdit *lineEdit)``` method that create those said fields with a :
- `QLabel` as the title of the line.
- `QLineEdit` as the field that will be filled.
- `QPushButton` to browse the file directory.

=== Evaluation Menu
This menu is made of a horizontal `QSplitter`, separating the #link(<table>)[table] from the #link(<preview>)[preview]. On the #link(<table>)[table] side, there is another `QSplitter`, this time vertical, separating it from the #link(<infobox>)[information box].

== Information Box <infobox>
This text zone show the binding problem’s between the copies and the Json.

== CLI
The CLI is implemented using the arguments of the `main.cpp` file.

Each arguments has its own "show" function, those arguments being :
- `--help` : Show the list of options.
- `--version` : Show the program version.

== Saving and Restoring User Configuration 
User configuration by the use of the `settings.cpp` class. It initiates a `QSettings` variable that will be loaded with the saved configuration when the software is started, and that will be saved when it is closed.

This information is often stored in the system registry on Windows, and in property list files on macOS and iOS. On Unix systems, in the absence of a standard, many applications (including the KDE applications) use INI text files.#footnote[https://doc.qt.io/qt-6/qsettings.html]

At its current state, the program only saves the dimensions (`QSize`) and position (`QPoint`) of the main window and can only be launched with the user configuration. When loaded, those informations are transformed into a `QRect` to be set as geometry of the window.

== Project Data Management <data>

=== Collecting Data
Two types of data are stored at the creation of a project, both in the forms of `QStringList` :
- The exam data (a list of json) in the `jsonFilePaths` variable.
- The scanned files (a list of png/pdf) in the `scanFilePaths` variable.

=== Storing Data

==== JSONReader
The `JSONReader` class is a simple class that handles reading from JSON file located on disk. It was however tailored for our test case (#emph([detailed in @testcase])). It contains error messages for every step of the conversion in case the file is not readable or empty. The `mJSON::JSONERROR` enum holds the different error values.\
We separate Markers from other fields in ```cpp int jsonreader::getCoordinates()```. This is where you should add other marker types if the need arises (for exemple, for fields containing strings instead of boolean values). We read the relevant keys in 
```cpp
void jsonreader::parseValues(QJsonObject &o, dataFieldJSON &coo)
```
If you need to access other fields (*boolean value* of the field, *string* recognized by OCR, *percentage* of certainty), you'll have to add the relevant keys in that function. They're currently missing because our test case did not include any such keys.\
The data is stored in the `dataFieldJSON` struct. and they're grouped by Paper in `dataCopieJSON`.
#let fieldjson = [
  ```cpp
  struct dataFieldJSON
{
  qreal x, y, h, w;
  QString clef;
  QVariant valeur;
  int pagenum;
}
  ```
]
#let copiejson = [
  ```cpp
  struct dataCopieJSON
{
  QSize pageSizeInMM;
  QList<dataFieldJSON> *documentFields;
  QList<dataFieldJSON> *documentMarkers;
  int pagecount = 0;
}
  ```
]
#figure(  
  grid(
    align: center,
    columns: 2,
    column-gutter: 20pt,
    fieldjson, copiejson),
  caption : [_current data model_]
)

==== ScanInfo

=== Saving and Restoring Data
When a project is created, the same paths that are being loaded in `jsonFilePaths` and `scanFilePaths` are also stored in the save data (`data.json`) of the project. Those are the only informations that are being saved by the software at its current state.

Whenever a user open a `data.json` save file via the main menu, it will load the paths that were saved previously into the `jsonFilePaths` and `scanFilePaths` variables. The software will then drop us to the evaluation menu.

== Evaluation Table <table>
What’s working
- [x] Sort button that allows one to hide or display specific columns of the table
- [x] Field view checkbox that change’s the table’s view from grouped to detailed
- [x] Table that details each Exam, Paper, Page, field and syntax of an exam paper (field or grouped syntax depending on the view)
- [x] Interaction between table and preview that displays data according to a cell’s column
- [x] Basic interactions with the preview, such as zoom operations, previous page/next page operations within a single Paper, and different interactions with the fields based on their type.

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
== Preview <preview>
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
Here's a tip: when re-implementing a mouseEvent in a subclass of QGraphicsItem, do not forget to call the corresponding mouseEvent of the parent class.\
_Example_ : read the
```cpp
void MarkerItem::mouseReleaseEvent(QGraphicsSceneMouseEvent *event)
```
function in `markeritem.cpp`.
==== Why the use of `QVariant` ?
In `FieldItem::sendNewDataToLib`, we send `QMap<QString, QList<QVariant>>` as it allows us to use one function to reflect changes to all the fields. In the case of markers, the data we send is a list of new coordinates, but in the case of Atomic Boxes, it's simply a boolean value. Using QVariants wraps every possible type into one.

= Description of the test case<testcase>
The test case we used is located in the #dirpath("resources/test_case/Fichiers") and #dirpath("resources/test_case/Json") folders. They contain _manually_ renamed files to match JSON files and images based on their names since this was the only identifier we had. Each file is named following this syntax `X-Y-Z-copieA-pageB:`
- _X-Y-Z identifier_
  - X : id of the Exam
  - Y : boolean value, is each Page double-sided or not ?
  - Z : boolean value, is each Paper printed on two pages or not ?
- _copieA_ :
  - A : id of the Paper
- _pageB_ :
  - B : current page number
The original test case generated by M.Poquet is also available in a set of 12 different folders at #dirpath("resources/test_case/basic-*-*-*/"), with each Paper in a separate folder. *Please keep in mind that we wrote all of our code without a definitive idea of the data format we would end up handling, as the API was not available at the time*
= Known Bugs
== Markers, MarkerHandles and coordinate systems
_It is possible to move a whole Marker and its corners (called `MarkerHandles` in code) individually. But this feature was implemented at the tail end of the project so some bugs flew under my radar._
- Fixing and converting the coordinates systems used by the markers.
  - Every `FieldItem` on the page is actually located at `QPointF(0,0)` (the origin of the scene, in the top-left corner) in page coordinates, with a polygon drawn at the correct location. This causes strange behavior when moving a marker around (see `qDebug` output when moving a marker). The only value I was able to ensure was consistently correct was the displacement relative to the starting point of the item. I became aware of this issue too late to fix it because it did not cause any visual bug but will surely be very annoying when other libraries will receive that data.
  - Changes to the position of an marker are not reflected on his corners, meaning that moving the whole marker from its initial position, then moving a corner will exhibit weird behavior as the corner's position hasn't been updated from the prior move.
  - The next step would then be to actually convert the positions from their page coordinates (in pixels) back into parser coordinates in millimeters. (The test JSON files we had available had every coordinate in millimeters).
== Duplication of data when opening a save file
_It is possible, with the help of the menu bar, to open a save file on the evaluation window. Because of a lack of time, the table doesn't possess a method to clean its content, and thus the save data will add on top of the pre-existing data._

There could be two fixes to this issue :
- Creating a method to clean the content of the table.
- Creating a method to delete and recreate a new table made up of this new data.
= Missing features
- #text(fill: rgb("#2CBEC0"), [Menu Bar : ])It lacks most of its functionality, however, most of the functions are already present in the code and just need to be written. Some options may need to be removed as they were more of a placeholder than anything else (i.e. darkmode).
- modifications Table -> preview
- Because of the lack of modifications possible, the save system doesn't account for any modifications, only storing the initial state of the data.
- counting papers submitted
- #text(fill: rgb("#2CBEC0"), [Preview : ])The `FieldItem::getRect` is used to inform the `QGraphicsView` of the new region to display when the user clicks on a "field" cell inside the Table. The call stack is :\
  #par(justify: false,[`FieldItem::getRect -> ExamSinglePage::getFieldPos -> Examscene::setROI -> ExamViewPort::fitROIInView`.])
  But `fitROIInView` wasn't implemented due to the lack of time.
- [ ] Column that specifies a field’s value (checked/unchecked or sentence) and the ability to modify it directly from the table
- [ ] Associate missing files once the table’s data was initialized
- [ ] Delete an exam, copy or a page from the table
- [ ] Mark a field as modified in the table

= What could be improved
- The executable doesn't have a logo, so a per-platform generic logo like #box(image("genericlogo1.png", height: 1em)) on Linux is used by default.
- Change the distance of Levenshtein by the distance of Damerau-Levenshtein
- variables in ScanInfo could be renamed to match the Table Headers
- #link("https://doc.qt.io/qt-6/model-view-programming.html")[An MVC architecture] could be implemented.
- The minimum size of the Preview might be too restrictive, feel free to reduce `minPreviewSize` and change the `previewSizePolicy` if needed.
- The second preview viewport (only visible when the primary preview is present in another window) has been left unused for now. It might be a good idea to reconsider if it's useful or not.<secondpreview>
- the image is reloaded every time we click on a field. Could be an area of improvement if you have the time.
- The CLI could have been implemented with a `QCommandLineParser` instead of doing it from ground-up like we did. It may end up being simpler to implement and possesses an already built in help and version option. Because the CLI was implemented on the last week of the project, we couldn't dive into the #link("https://doc.qt.io/qt-6/qcommandlineparser.html")[documentation] deep enough.
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
#figure(
  image(
    "errormac.png"
  ),
  caption: [_captured on M1 MacBook (ARM)_]
)
This seemingly happens when the user clicks anywhere in the window then hover on the preview frame. This didn't seem to affect the program in any other way.
== Linux
=== Wayland
- Window position cannot be restored because Wayland.

= Sources
#link("https://doc.qt.io/qt-6/qtwidgets-index.html")[Qt official documentation]\
#link("https://fr.wikipedia.org/wiki/Distance_de_Levenshtein")[Levenshtein distance]\ 
#link("https://fr.wikipedia.org/wiki/Distance_de_Damerau-Levenshtein")[Levenshtein-Damerau distance]\ 
