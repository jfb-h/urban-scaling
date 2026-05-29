#let template(
  title: none,
  authors: (
    name: "Author 1",
    email: "author1@lmu.de",
    orcid: none,
    affiliation: [Economic Geography Group / Department of Geography / LMU Munich],
    corresponding: false
  ),
  mark_corresponding: true,
  abstract: none,
  keywords: (),
  JEL: none,
  references: "references.bib",
  include_references_section: true,
  body
) = {
  set page(
    paper: "a4",
    columns: 2,
    numbering: "1",
    margin: (x: 60pt, y: auto)
  )
  set par(justify: true)
  set text(
    font: "Libertinus Serif",
    size: 11pt,
  )

  show heading.where(level: 1): set heading(numbering: "1")
  show heading.where(level: 2): set text(12pt, weight: "bold")
  show heading.where(body: [References]): set heading(numbering: none)
  
  // show ref: set text(weight: "semibold")
  
  let count = authors.len()
  let ncols = calc.min(count, 3)
  
  place(
    top + center,
    scope: "parent",
    float: true,
    text(17pt)[
      #title
      
      #v(1em)
      
      #grid(
        columns: (1fr,) * ncols,
        column-gutter: 1em,
        row-gutter: 24pt,
        ..authors.map(author => text(10pt)[
          #text(12pt, weight: 800, [*#author.name*])
          #if (author.corresponding and mark_corresponding) {super($dagger$)} \
          #author.affiliation \
          #link("mailto:" + author.email)
        ]),
      )
      
      #v(0.5em)
      #if mark_corresponding {
        align(left)[
          #set text(size: 10pt, style: "italic")
          #super($dagger$) corresponding author.
        ]
      }
    ],
  )

  set align(left)
    
  text(weight: "semibold")[
    _Abstract._
    #abstract
  ]

  if JEL != none {
    v(0.1em)
    text(style: "italic")[JEL Codes: #JEL]
  }
  
  if keywords != none {
    v(0.1em)
    text()[_Keywords:_ #keywords.join(", ")]
  }
  
  body

  if include_references_section {
    bibliography(references, title: "References", style: "egg.csl")
  }
}
