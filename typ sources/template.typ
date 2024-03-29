#let base(
  left_header: [
    #datetime.today().display("[day]/[month]/[year]")
  ],
  right_header: none,
  title: none,
  subtitle: none,
  version: none,
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
  set text(
    font : "Noto Serif",
    size: 12pt
  )
  
  align(center)[                      // title rules
    #heading(numbering: none)[
      #title //TODO : if version is not indicated, don't show this
      
      #subtitle - _V_#emph[#version]
    ]
  ]
  set heading(                        // headings rules
    numbering: "I.1.a"
  )
  show link : it => [                 //external links rules
    #set text(
      fill: blue.darken(30%),
      )
    #underline[#it]
  ]

  doc
}