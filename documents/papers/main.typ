#import "assets/template-submission.typ": template

#let title = [
    How to write a nice paper
  ]

#let authors = (
    (
      name: "Author 1",
      orcid: "",
      email: "author1@lmu.de",
      affiliation: [Economic Geography Group \ Department of Geography \ LMU Munich],
      corresponding: true,
    ),
    (
      name: "Author 2",
      orcid: "",
      email: "author2@lmu.de",
      affiliation: [Economic Geography Group \ Department of Geography \ LMU Munich],
      corresponding: false,
    ),
    (
      name: "Author 3",
      orcid: "",
      email: "author3@lmu.de",
      affiliation: [Economic Geography Group \ Department of Geography \ LMU Munich],
      corresponding: false,
    ),
  )

#let keywords = ("keyword 1", "keyword 2", "keyword 3")

#let abstract = [
    #lorem(150)
]

#show: template.with(
  title: title,
  authors: authors,
  keywords: keywords,
  abstract: abstract,
  references: "references.bib",
)


//////////////////////////////////////////////////////////////////////////////////////


= Introduction <introduction>
As demonstrated, institutions are the best thing since sliced bread @gluckler2023b @eckhardt2025. #lorem(500)

= Theory <theory>
#lorem(1000)

= Case and Data <data>
#lorem(500)

= Methods <methods>
#lorem(500)

= Results
#lorem(1000)

= Discussion and conclusions
#lorem(500)
