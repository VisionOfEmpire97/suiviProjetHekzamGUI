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
The `scaninfo.h` file details every structure used to store the data of an exam. Each class listed in `scaninfo.h` contains getters and setters for its attributes as well as methods to iterate through its specific map except for the class `FieldInfo` which doesn't have any. The ```cpp Q_DECLARE_METATYPE``` macro at the very end of the file is used to enable Qt's meta-object system to recognize custom data types. This allows pointers to ExamInfo, CopyInfo and PageInfo to be used with QVariant, signal-slot mechanisms, and other Qt features that require runtime type information. In this context, this macro is used in order to store such structures inside ```cpp QTableWidgetItems``` contained in a tabled cell to facilitate access to the data they refer to. 

More information about `QMetaType` class through this #link("https://doc.qt.io/qt-6/qmetatype.html")[link].


==== ExamInfo 

The class `ExamInfo` represents the main data structure that will be used throughout the program to manipulate exam data. It contains information about an exam name, the data collected from the corresponding JSON file, a map associating paper names with a `CopyInfo` object and the number of papers contained in the exam.

Even though papers can be classified by an integer, I considered using a map since there is no guarantee that papers will be added in order. For the test cases that are currently used, an *array* or a *vector* could have been used since the number of copies contained in an exam is specified in a file's name. However since this association process is bound to change, I preferred keeping a map in case the copy numbers turn out to be missing or imprecise. \ Other data structures such as *LinkedList*, *Queue*, *Stack* and *Dequeue* will not be efficient when consulting the structure since both table's initialisation need to go through this data structure once (twice in total). Hence a map will be more efficient time wise. The map is ordered for the pages to be inserted inside the table in the correct order (more detail about the table's initialisation later on).

In addition to getters and setters, this class contains several public methods in order to manipulate the other objects of the `scaninfo.h` classes through their private methods. Any field, page or paper can be added anywhere directly from the `ExamInfo` class. 

===== CopyInfo
`CopyInfo` is used to describe a paper and gather every page contained in it. A paper is composed of a name, a map associating a page name to its corresponding `PageInfo` object, the number of the copy, a boolean that indicates whether the paper is specified in a JSON file among those selected by the user, a boolean that informs on whether the paper is among the scan files selected by the user, and the number of pages contained in the paper.

An ordered map is used for the same reasons stated in *ExamInfo* except this time, an *array* would need to be initialised with the correct value and this approach would be valid assuming the JSON file specifying every page contained in a paper is correct. If the JSON file lacks information about a page, then the page could never be added to the paper because the index would be out of range. A *vector* could fix this problem by expanding its size every time this happens but this would not be as efficient as directly using a map. 
===== PageInfo
The class `PageInfo` categorises an exam page by its name, file path, number, two booleans that serve the same purpose as the ones described in *CopyInfo* but that imply the presence of a page instead, a map associating every field contained in the page with their names and the number of fields contained in the page. The private methods are used to facilitate the manipulation of a page directly from `CopyInfo` or `ExamInfo`. 

==== FieldInfo
The class `FieldInfo` represents every field contained in a page. Each field can either be checked/unchecked or contain a value written by a student. The structure classifies a field by its *name*, *checked* status, *value* and *syntax* value that represents the programs certainty of the interpreted value in the field. The rest of the class is constituted of getters and setters for the previously listed values.

==== JsonLinker
Data storage is managed by the `JsonLinker` class. It is instantiated in the program as an attribute of `MainWindow` and has a unique public method: ```cpp std::map<QString, ExamInfo> &collectFields(QStringList const &filePaths, QStringList const &jsonFilePaths)```. This method takes the paths of previously selected scan and JSON files and aims to associate a scan to its corresponding JSON by matching their file names. 

During this method's execution, a map (```cpp std::map<QString, ExamInfo> fileExamMap```) associating an exam identifier (e.g. 1-0-0) with an `ExamInfo` object is initialised by the  ```cpp void initialiseMaps(QStringList const &jsonPath)``` method. This process works by going through each JSON file path from the path list given in the method's argument. For each JSON file, the data is loaded into a `dataCopieJSON` pointer by calling ```cpp dataCopieJSON *loadAndGetJsonCoords(QString const &jsonPath)```. The data is loaded with an object from the `JSONReader` class that is instantiated as an attribute of `JsonLinker`. Next, an ExamInfo object is created and filled with `CopyInfo`, `PageInfo` and `FieldInfo` objects depending to the JSON's data.

After the map's initialisation, the list containing every scan path is iterated through and the path of already existing pages is updated to the scan's path. If a file is not specified in any JSON, a dummy object will be created and inserted into the structure. Lastly, the map is returned and will be used to initialise the evaluation tables.


=== Saving and Restoring Data
When a project is created, the same paths that are being loaded in `jsonFilePaths` and `scanFilePaths` are also stored in the save data (`data.json`) of the project. Those are the only informations that are being saved by the software at its current state.

Whenever a user open a `data.json` save file via the main menu, it will load the paths that were saved previously into the `jsonFilePaths` and `scanFilePaths` variables. The software will then drop us to the evaluation menu.

== Evaluation Table <table>
=== TableBox
The class `TableBox` is used as the main evaluation layout containing every component directly linked to the evaluation table. It is instantiated inside ```cpp void MainWindow::createEvaluationView()``` and receives as arguments the previously initialised map containing every `ExamInfo` retrieved from the selected files, the parent of a `QDockedWidget` which is the `Mainwindow` itself and its parent window which is the layout it is stored in.

`TableBox` contains several methods and attributes, half is used to instantiate the tables and the other half are used for the search features. 

=== SortDock
In order to display or hide specific columns of the table, the `sortDock` object from the `QDockWidget` class  is displayed after pressing on the `sortButton` object from the `QPushButton` class. The dock is initialised through ```cpp void TableBox::initTableFilter()``` and contains a layout that gathers several `QCheckBox` objects that each are connected to a method that will be responsible for hiding or showing the corresponding column. 

Here are some links to the documentation concerning the previously mentionned classes: #link("https://doc.qt.io/qt-6/qdockwidget.html")[QDockWidget], #link("https://doc.qt.io/qt-6/qpushbutton.html")[QPushButton] and #link("https://doc.qt.io/qt-6/qcheckbox.html")[QCheckBox].

=== SortTable
The `SortTable` class is an abstract class that extends the `QTableWidget` class. The tables' data comes from the ```cpp std::map<QString, ExamInfo> &examMap``` attribute that is initialised when the tables are first instantiated in the `TableBox`'s constructor. This class serves as template for every evaluation table used in the GUI. The table details each exam, copy, page, field and syntax of an exam paper (field or grouped syntax depending on the view) with columns that share the same name. 

In order to simulate the grouping or unfolding of table cells, two tables `groupTable` and `fieldTable` are instantiated from custom classes called `GroupViewTable` and `FieldViewTable` that heritate from `SortTable`.  This map is issued from the previous file association done by `JsonLinked`, it contains every information about the selected exam files. 

To fill in the tables, each method is responsible for inserting a specific structure. The `ExamInfo` objects from the map are unfolded in order to extract `CopyInfo`, `PageInfo` and `FieldInfo` objects and add them into  `QTableWidgetItem` objects as `QVariants` for them to be easily accessible from a table cell. The main difference between `GroupViewTable` and `FieldViewTable` is that at the end of each insertion, `GroupViewTable` sets the cells span to a specific value so that common cells are grouped as one unique cell. It is during the filling process that any error concerning a copy or a page is communicated to the user.

Back to the `TableBox`, it is possible to switch between both tables thanks to the `fieldViewToggle` from the `QCheckBox` class. The `sortTableList` object is a `QList` that contains `SortTable` pointers and is used to store both tables. When toggling from one table to another, the `actualTable` attribute which is a `SortTable` pointer changes to the pointer of the other table in the list so that every operation is applied to the currently displayed table. The switch also considers the current table's scrollbars position so that the same parameters can be applied to the other table upon switching. The same can be done with the columns size thanks to this slot ```cpp &TableBox::synchronizeColumnWidth```.

More information about these classes: #link("https://doc.qt.io/qt-6/qtablewidget.html")[QTableWidget], #link("https://doc.qt.io/qt-6/qtablewidgetitem.html")[QTableWidgetItem] and #link("https://doc.qt.io/qt-6/qvariant.html")[QVariant].


=== Interaction between Table and Preview
In order to display the content of a clicked table cell in the preview, both `groupTable` and `fieldTable` are connected so that when they receive a ```cpp &QTableWidget::cellClicked``` signal, the `TableBox` class will call the following slot: ```cpp &TableBox::collectData```. This slot will check the item clicked by the user on the currently displayed table and if it exists, it will firstly collect the data stored in the corresponding `ExamInfo` class. If the data is not ```cpp NULL```, the slot will fill a `QStringList` with the paths of the files to display according to the column the item is situated in. If the column is *Field*, the method will also instantiate a `QString` with the field's name so that the preview can display an isolate it from the rest of the page. Lastly will the acquired information, the slot will emit a signal ```cpp &TableBox::sendDataToPreview``` so that the preview can receive the correct information. `TableBox` and `ExamPreview` are connected in the `Mainwindow` class.

== Search Function within the Table

For now, the searchbar brings functionalities such as simple and multiple text search and also a 
tagged search. All the available functionalities are detailed below.

=== Searchbar
The `QWidget` use for the search is a `QLineEdit`. Two signals are used here : 

- `QLineEdit::textChanged` : 
every time a character is changed, the slot 
  `TableBox::cleanSortTable` 
      will check if the text zone is empty. If so, it will show all the lines of the table and clear 
      the error message of `searchInfo`.

- `QLineEdit::returnPressed` :
when the user press return, the slot `TableBox::searchProcessing` will start the search.
  The first step is a search process. It will test the format with a regular expression #link(<ref4>)[[4]]#link(<ref5>)[[5]]. Depends on the result, 
  it will process the differents type of search :
    - Unknown : error message in the `QLabel` named `searchInfo`.
    - Simple : select the columns concerned by the search, create the regex for the search and filter the rows.
    - Multiple : select the columns concerned by the search, create the regex by joinning all the searched words and filter the rows.
    - Tag : select the columns concerned by the search, create the list of tag and the list of regex and filter the rows.

=== Fuzzy search
	It’s an approximate string matching. It shows a list of the maximum three first nearest found words. It implements the Wagner and Fischer 
  algorithm’s which use the concept of the distance of Levenshtein #link(<ref2>)[[2]]. It use a dynamic threshold (30% of the size of the searched text).
	The fuzzy search works only for the simple and multiple text search.

=== AtomicSearchBox
	Allow the user to do an atomic search (search the exact word with the pattern instead of searching a match with the regex) :
    - works only for the simple search (also for the multiple but because words are jointed it will search for their concatenations).

=== Search on FieldView and GroupView
  A search is process on the GroupView either the FieldView not the two at the same time. Because of 
  the use of two tables, the previous search will not be automatically cleared. But, if `textZone` is cleared
  by the user, the slot `TableBox::cleanSortTable` is called for the two table.

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


== All the search-related problems

- When a tag search is processed, it happens that not wanted "copies" are showed on the table. This happens only in the case of the "copies not found" or sometimes 
  in the "Json not find".
#figure(
  image(
  "Evaluation_table.png", width: 30%
  ),
caption:"here the four latest copies are showed"
)


= Missing features
- #text(fill: rgb("#2CBEC0"), [Menu Bar : ])It lacks most of its functionality, however, most of the functions are already present in the code and just need to be written. Some options may need to be removed as they were more of a placeholder than anything else (i.e. darkmode).
- modifications Table -> preview
- Because of the lack of modifications possible, the save system doesn't account for any modifications, only storing the initial state of the data.
- counting papers submitted
- #text(fill: rgb("#2CBEC0"), [Searchbar : ]) First, the help for the user is missing. It could be great to have a reminder on the search format.
  The fuzzy search only work for the simple and multiple text search due to do a lack of time for implement it for the tag search.
  Finally, the atomic search work only for the tag search. In fact, if the user do an atomic search on a multiple text search it will try to search
  the joint of the words. For the tag search, #link(<refImple>)[we have to think in a completely different way to implement this feature].

- #text(fill: rgb("#2CBEC0"), [Table : ])A column containing the value of a field to allow the user to modify a it directly from the table was initially requested but could not be implemented do to lack of time. Currently, the GUI will notify the user of missing or unassociated files but we did not have the time to implement the feature that can help fix those issues. This version of the GUI only displays items in the table without offering the possibility to modify them. Hence, users will not be able to modify or remove any cell manually.

- #text(fill: rgb("#2CBEC0"), [Preview : ])The `FieldItem::getRect` is used to inform the `QGraphicsView` of the new region to display when the user clicks on a "field" cell inside the Table. The call stack is :\
  #par(justify: false,[`FieldItem::getRect -> ExamSinglePage::getFieldPos -> Examscene::setROI -> ExamViewPort::fitROIInView`.])
  But `fitROIInView` wasn't implemented due to the lack of time.

= What could be improved <refImple>
- The executable doesn't have a logo, so a per-platform generic logo like #box(image("genericlogo1.png", height: 1em)) on Linux is used by default.
- The Regex are good but the use of them to compare the text in the cells brings too much difficulty when we want to change
  the way our search work. Changing this could benefit to easily implements the atomic search for all types of search.
- Changing the distance of Levenshtein#link(<ref2>)[[2]] by the distance of Damerau-Levenshtein#link(<ref3>)[[3]] to get a more precise threshold.
- variables in ScanInfo could be renamed to match the Table Headers
- #link("https://doc.qt.io/qt-6/model-view-programming.html")[An MVC architecture] could be implemented.
- The minimum size of the Preview might be too restrictive, feel free to reduce `minPreviewSize` and change the `previewSizePolicy` if needed.
- The second preview viewport (only visible when the primary preview is present in another window) has been left unused for now. It might be a good idea to reconsider if it's useful or not.<secondpreview>
- the image is reloaded every time we click on a field. Could be an area of improvement if you have the time.
- The CLI could have been implemented with a `QCommandLineParser` instead of doing it from ground-up like we did. It may end up being simpler to implement and possesses an already built in help and version option. Because the CLI was implemented on the last week of the project, we couldn't dive into the #link("https://doc.qt.io/qt-6/qcommandlineparser.html")[documentation] deep enough.
- The data structures used to store information about exams might be subject to change since some decisions made were very specific on the test cases we were using to test different features of the program.
== Preview module
- Hiding the mouse cursor when moving a corner of a marker could improve accuracy.

== What needs to be removed

- The `JsonLinker` class associates pages with their corresponding Json file by matching the file names. This class was only useful since we had no other way of associating files. Ultimately, Hekzam will contain a library supports this feature. 
- This association was also responsible for initialising exam, copies, pages and fields into the dedicated data structures `ExamInfo`, `CopyInfo`, `PageInfo` and `FieldInfo`. Those structures will need to be initialised differently.
- The `PageInfo` data structure contains an attribute that describes the path of the file it is associated with this will no longer be needed in the final version since the association library will take care of that.
- I used the `mViewPort` and `mJSON` namespaces in some parts of the code, but they might be useless, remove them if you will.

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
<ref1>[1]#link("https://doc.qt.io/qt-6/qtwidgets-index.html")[Qt official documentation]\
<ref2>[2]#link("https://fr.wikipedia.org/wiki/Distance_de_Levenshtein")[Levenshtein distance]\ 
<ref3>[3]#link("https://fr.wikipedia.org/wiki/Distance_de_Damerau-Levenshtein")[Levenshtein-Damerau distance]\ 
<ref4>[4]#link("https://doc.qt.io/qt-6/qregularexpression.html")[QRegularExpression documentation]\
<ref5>[5]#link("https://perldoc.perl.org/perlre")[Perl-Regex]\