#import "assets/template.typ": template, slide_template, r

#let lightgray = rgb("#f0f0f0")

#show: template.with(
  font: "Aptos",
  fontsize: 18pt,
)

#let slide = slide_template.with(
  leftcolor: lightgray,
  rightcolor: white,
  rightsize: 50%,
  citesize: 20%
)

// Slides start here

#slide([

  Put some figures here

],[

  = Put the slide title here

  - Put some 
  - Bullet points
  - Here

])
