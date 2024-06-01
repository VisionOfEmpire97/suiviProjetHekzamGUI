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
[ ] Sort button that allows one to hide or display specific columns of the table
[ ] Field view checkbox that change’s the table’s view from grouped to detailed
[ ] Table that details each exam, copy, page, field and syntax of an exam paper (field or grouped syntax depending on the view)
[ ] Interaction between table and preview that displays data according to a cell’s column

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
    - it doesn’t work for the tag search because it’s not even implemented in filterTagSearchRow
== Preview
// TODO

= Description of the test case

= Known Bugs


= Missing features
- menu bar
- modifications Table -> preview
- counting papers submitted
= What’s not working
- [ ] Column that specifies a field’s value (checked/unchecked or sentence) and the ability to modify it directly from the table
- [ ] Associate missing files once the table’s data was initialised
- [ ] Delete an exam, copy or a page from the table
- [ ] Mark a field as modified in the table

= What could be improved
- Change the distance of Levenshtein by the distance of Damerau-Levenshtein
- variables in ScanInfo could be renamed to match the Table Headers


== What needs to be removed

- [ ] The JsonLinker class associates pages with their corresponding Json file by matching the file names
- [ ] This association also allows the exam, copies, pages and fields to be initialised using specific data structures
- [ ] The PageInfo data structure contains an attribute that describes the path of the file it is associated with
- [ ] All of these points will not be necessary once the library allowing a page to be associated with its json file is properly implemented

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
