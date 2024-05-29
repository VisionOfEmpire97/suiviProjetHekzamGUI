#let base(
  left_header: [
    #datetime.today().display("[day]/[month]/[year]")
  ],
  right_header: none,
  title: none,
  subtitle: none,
  version: [],
  doc
) = {
  set page(                           //page rules
    paper:"a4",
    margin: (x:2cm, y:3cm),
    numbering: "1/1",
    header: [                         //header rules
      #set text(
        font: "Noto Mono",
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
    size: 12pt
  )

  show raw : it =>[                   // verbatim/code rules
    #set text(
      font: "JetBrainsMono NF"
    )
    #it
  ]

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
  set heading(                        // headings rules
    numbering: "I.1.i.a"
  )
  show link : it => [                 //external links rules
    #set text(
      fill: blue.darken(30%),
      )
    #underline[#it]
  ]

  doc
}