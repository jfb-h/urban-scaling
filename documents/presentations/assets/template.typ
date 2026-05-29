#let template(
  font: "Aptos Display",
  fontsize: 18pt,
  references: "references.bib",
  cls: "egg.csl",
  body,
) = {
  set page(
    paper: "presentation-16-9",
    margin: 0em,
    numbering: "1",
    number-align: left
  )

  set text(
    rgb("#3f3f3f"), fontsize,
    font: font,
    stretch: 90%
  )

  // set list(spacing: 1.3em)
  set par(leading: 0.5em)
  
  let refcol = rgb("#8b8b8b")

  show cite.where(form: "normal"): set text(11pt, refcol)
  show cite.where(form: "prose"): set text(11pt, refcol)
  show cite.where(form: "year"): it => {
    set text(11pt, refcol)
    [(#it)]
  }

  show heading.where(level: 1): it => [
    #set block(below: 1em)
    #set text(rgb("#303131"), 28pt, weight: "bold")
    #upper(it)
  ]

  show figure.caption: it => {
    set text(size: 12pt, style: "italic")
    set align(left)
    // h(1em)
    it.body
  }

  show bibliography: none
  bibliography(references, style: cls)

  body
}

#let pagerefs = state("refs", ())

#let r(label, form: "normal") = {
  pagerefs.update(x => x + (label,))
  cite(label, form: form)
}

#let leftbox(content, fill: none) = {
  grid.cell(
    fill: fill,
    align: center,
    rowspan: 2,
    inset: (top: 1.5em, bottom: 1.5em, left: 1em, right: 1em),
    content
  )
}

#let rightbox(content, fill: none) = {
  grid.cell(
    fill: fill,
    inset: (top: 1.5em, bottom: 1.5em, left: 1em, right: 2em),
    content
  )
}

#let citebox(fill: none) = {
  grid.cell(
    fill: fill,
    inset: (top: 0em, bottom: 0.5em, left: 1em, right: 2em),
    align: bottom,
    [
      #set text(7pt)
      #context if pagerefs.get().len() > 0 {
        v(2em)
        line(length:10%, stroke: black + 1pt)

        for (i, label) in pagerefs.get().enumerate() {
          if i > 0 {
            h(0.4em)
            box(fill: black, height: 0.8em, width: 0.8em, [])
            h(0.4em)
          }
          cite(label, form: "full")
        }
        pagerefs.update(x => ())
      }
    ]
  )
}

#let slide_template(
  leftcontent, rightcontent,
  rightsize: 50%,
  citesize: 15%,
  leftcolor: rgb("#f3f3f3"),
  rightcolor: rgb("#f3f3f3"),
) = {
  [
    #grid(
      columns: (100% - rightsize, rightsize),
      rows: (100% - citesize, citesize),
      gutter: 0pt,
      leftbox(fill: leftcolor)[#leftcontent],
      rightbox(fill: rightcolor)[#rightcontent],
      citebox(fill: rightcolor),
    )

    #context place(
      dx: 98%, dy:-3.20%, [
      #let col = luma(40%)
      #set text(12pt, col, weight: "bold")
      #let i = here().page()
      #if(i) > 1 [#i]
    ])
  ]
}
