#import "@preview/cheq:0.1.0": checklist
#let base(
  left_header: [
    #datetime.today().display("[day]/[month]/[year]")
  ],
  right_header: none,
  title: none,
  subtitle: none,
  version: [],
  authors:(),
  doc
) = {
  set document(                       //basic doc settings
    author: "ROSET Nathan", 
    title: [#title],
    date: datetime.today()
    )

  set page(                           //page rules
    paper:"a4",
    margin: (x:2cm, y:3cm),
  )

  set par(                            // paragraph rules
    justify: true
  )

  set text(
    font : "Noto Sans",
    size: 12pt,
    fallback: true,
    lang:"en",
    region: "US",

  )

  show raw : it =>{                   // verbatim/code rules
    set text(
      font: "JetBrainsMono NF",
      size: 12pt,
    )
    [#it]
  }

  v(1fr)                              // front cover rules
  
  // Set colors
  let main-color = "#2CDE85" //Qt Neon Green
  let primary-color = rgb(main-color) // alpha = 100%

  // change alpha of primary color
  let alpha = 60%
  let secondary-color = color.mix(color.rgb(100%, 100%, 100%, alpha), primary-color, space:rgb)

  // decorations at top left
  place(top + left, dx: -35%, dy: -28%, circle(radius: 150pt, fill: primary-color))
  place(top + left, dx: -5%, dy: 0%, circle(radius: 75pt, fill: secondary-color))
  
  //logo in the top-right
  let logo = image("logo-UT3.png",width: 6cm)
  place(top + right, dy:-5%, logo)

  // decorations at bottom right
  place(bottom +right, dx: 48%, dy: 40%, circle(radius: 200pt, fill: secondary-color))

  text(
    size : 18pt,
    hyphenate: false,
    align(center)[                      // title rules
      #heading(numbering: none)[
        #title 
      ]
        #parbreak()
        #heading(level :2)[#subtitle
        #if version != []{
          [ \- _V_ #emph[#version]]
        }
      ]
      #parbreak()
      *Encadrant* : Millian Poquet - Maître de conférences à l'Université Paul Sabatier - Chercheur à l'IRIT
    ]
  )

  v(1fr)

  let count = authors.len()
  let ncols = calc.min(count, 4)
  grid(
    columns: (1fr,) * ncols,
    column-gutter: 10pt,
    rows: (1em, 1em),
    row-gutter: 20pt,
    align: center,
    ..authors.map(author =>
    [
      #set text(size: 10pt)
      #set par(justify:false)
      *#author.name*
    ]),
    ..authors.map(author =>
    [
      #set text(size: 10pt)
      #author.affiliation
      #author.email
    ])
  )
  counter(page).update(0)
  set page(
    numbering:"1/1",
    header: [                         //header rules
      #set text(
        font: "Noto Sans Mono",
        size: 10pt
        )
      #left_header
      #h(1fr) #right_header
    ],  
    )

  set outline(
    depth: 2,
    indent: true,
  )

  set heading(                        // headings rules
    numbering: (..nums) => {
      let level = nums.pos().len()
      // only level 1 and 2 are numbered
      let pattern = if level == 1 {
      "I."
      } else if level == 2 {
      "I.1."
      }
      if pattern != none {
      numbering(pattern, ..nums)
      }
    }
  )
  set table(                          //table rules
    fill: (x,y) => if y == 0 {
      gray.lighten(40%)
    },
  )

  show link : it => {                 //external links rules
    set text(
      fill: blue.darken(30%),
      )
    underline[#it]
  }

  show: checklist.with(               //checklist rules
    unchecked: sym.ballot, 
    checked: sym.ballot.x
  )
  show heading : it =>{
    if it.level > 2 {
      set text(
        // fill: rgb("#2CBEC0"),
      )
    [#it]
    } else {
    [#it]
    }
  }
  
  pagebreak(weak: true)
  doc
}

// highlight paths differently from verbatim text
#let dirpath(body) = {
    set text(fill: rgb("#AA0000"))
     raw(body)
}