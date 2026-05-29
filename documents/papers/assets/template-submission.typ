#let template(
  title: none,
  authors: (),
  abstract: none,
  keywords: (),
  JEL: none,
  references: "references.bib",
  mark_corresponding: true,
  body
) = {
  set page(
    paper: "a4",
    columns: 1,
    numbering: "1",
    margin: (x: 1.2in, y: auto)
  )
  set par(justify: true)
  set text(
    font: "Libertinus Serif",
    size: 12pt,
  )

  show heading.where(level: 1): set heading(numbering: "1")
  show heading.where(level: 1): set text(16pt, weight: "bold")
  show heading.where(level: 2): set text(14pt, weight: "bold")

  show heading.where(body: [References]): set heading(numbering: none)

  show heading.where(level: 1): set block(below: 1em, above: 2em)
  show heading.where(level: 2): set block(below: 1.2em, above: 1.5em)
  
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
        column-gutter: 0.2em,
        ..authors.map(author => text(11pt)[
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

  v(4em)

  set align(left)

  set par(leading: 1.2em, spacing: 2em)
  // set block(below: 2em)
    
  text()[
    *_Abstract._*
    #abstract
  ]

  v(1em)

  if JEL != none {
    v(0.1em)
    text(style: "italic")[JEL Codes: #JEL]
  }
  
  if keywords != none {
    v(0.1em)
    text()[_Keywords:_ #keywords.join(", ")]
  }

  pagebreak()
  
  body

  bibliography(references, title: "References", style: "egg.csl")
}
