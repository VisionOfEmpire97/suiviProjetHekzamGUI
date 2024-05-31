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
    header: [                         //header rules
      #set text(
        font: "Noto Sans Mono",
        size: 10pt
        )
      #left_header
      #h(1fr) #right_header
    ],
  )

  set par(                            // paragraph rules
    justify: true
  )

  set text(
    font : "Noto Serif",
    size: 12pt,
  )

  show raw : it =>[                   // verbatim/code rules
    #set text(
      font: "JetBrainsMono NF"
    )
    #it
  ]

  v(1fr)

  align(center)[                      // title rules
    #heading(numbering: none)[
      #title 
      #parbreak()
      #if version == [] {
         [#subtitle]
      } else {
         [ #subtitle - _V_ #emph[#version]]
      }
    ]
  ]

  v(1fr)
  show grid : it =>[                  //authors
    #set text(size: 10pt)
    #it
  ]
  
  let count = authors.len()
  let ncols = calc.min(count, 4)
  grid(
    columns: (1fr,) * ncols,
    rows: (1em, 1em),
    row-gutter: 20pt,
    align: center,
    ..authors.map(author =>
    [
      #set par(justify:false)
      *#author.name*
    ]),
    ..authors.map(author =>
    [
      #author.affiliation
      #author.email
    ])
  )
  counter(page).update(0)
  set page(numbering:"1/1"  )

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
  show link : it => [                 //external links rules
    #set text(
      fill: blue.darken(30%),
      )
    #underline[#it]
  ]
  pagebreak()
  doc
}