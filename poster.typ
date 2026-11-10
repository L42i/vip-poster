#let projects = yaml("projects.yaml")
#let info = yaml("info.yaml")
#let accent = rgb("#b3a369")   // GT gold
#let navy = rgb("#003057")

// Page size comes from the command line (see export.py); the design is always 36in wide
// and is scaled uniformly to the page width. Extra or missing height is absorbed by the tile heights.
#let page-w = float(sys.inputs.at("w", default: "36"))
#let page-h = float(sys.inputs.at("h", default: "48"))
#let s = page-w / 36
#let design-h = page-h / s           // design height in inches
#let extra = design-h - 48            // vs. the 36x48 design
#set page(width: page-w * 1in, height: page-h * 1in, margin: 0pt, fill: white)
#let sans = "Inter"          // body, as on the website
#let mono = "Space Mono"     // headings and labels, as on the website
#set text(font: sans, size: 34pt, fill: rgb("#282828"))

#let label(t) = block(text(font: mono, size: 24pt, weight: "bold", fill: navy, tracking: 2pt)[#t])

#let poster() = block(width: 36in, height: design-h * 1in, inset: 1in)[
// Header: title, affiliation, team, logo
#block(fill: navy, width: 100%, inset: 0.8in, radius: 12pt)[
  #set text(fill: white)
  #grid(columns: (1fr, auto, auto), gutter: 0.6in, align: horizon,
    [
      #text(font: mono, size: 54pt, weight: "bold")[VIP: Interacting with Sound and Space] \
      #v(0.2in)
      #text(font: mono, size: 34pt)[#text(fill: accent)[Grad Advisors:] #info.team.join(" · ")] \
      #v(0.1in)
      #text(font: mono, size: 36pt)[#text(fill: accent)[Contact:] #info.contact_name, #info.email]
    ],
    align(right)[
      #image("media/l42i-logo-white.png", width: 6in)
      #v(0.15in)
      #text(font: mono, size: 26pt)[Lab for Interaction & Immersion] \
      #text(font: mono, size: 26pt, fill: accent)[School of Music, College of Design] \
      #text(font: mono, size: 26pt, fill: accent)[Georgia Institute of Technology]
    ],
    align(center)[
      #block(fill: white, inset: 0.2in, radius: 10pt, image("media/qr-lab.svg", width: 2.6in))
      #v(0.05in)
      #text(font: mono, size: 24pt)[l42i.music.gatech.edu]
    ],
  )
]
#v(0.5in)

// Intro and basic info
#info.intro #for b in info.basics [#text(font: mono, weight: "bold", fill: navy, size: 26pt)[#b.label:] #b.text]
#v(0.5in)

// One image fills the tile; several: first one large on the left, the rest stacked on the right
#let fr(x) = float(x.replace("fr", "")) * 1fr   // "1.2fr" in YAML -> fraction
#let images(p) = {
  let imgs = p.imgs
  let fill(path) = image(path, width: 100%, height: 100%, fit: "cover")
  if imgs.len() == 1 { fill(imgs.first()) } else {
    let rest = imgs.slice(1)
    grid(columns: p.at("cols", default: ("2fr", "1fr")).map(fr), rows: (100%,), gutter: 6pt,
      fill(imgs.first()),
      grid(rows: p.at("rows", default: rest.map(_ => "1fr")).map(fr), gutter: 6pt, ..rest.map(fill)))
  }
}

// Project tiles: image fills the card, text sits on a translucent panel
#grid(columns: if projects.len() == 1 { 1 } else { 2 }, gutter: 0.5in,
  ..projects.map(p => block(
    stroke: 6pt + navy, radius: 16pt, clip: true, width: 100%, height: 12.3in + extra / 2 * 1in,
  )[
    #place(block(height: 100% - p.at("reserve", default: 0) * 1in, images(p)))
    #block(fill: navy, width: 100%, inset: (x: 0.4in, y: 0.25in))[
      #text(font: mono, size: 52pt, weight: "bold", fill: white)[#p.name]
    ]
    #place(bottom, block(fill: rgb("#f4f1e8bb"), width: 100%, inset: 0.4in)[
      #set text(size: if projects.len() == 1 { 40pt } else { 32pt })
      #p.abstract
      #v(0.3in)
      #label("MAJORS NEEDED") #(p.majors.map(m => eval(m, mode: "markup")).join(", ") + [, ...])
    ])
  ])
)

#v(0.5in)
// Footer: spaces (square photos, west to east) with a map between them
#block(stroke: 6pt + navy, radius: 16pt, width: 100%, inset: 0.4in, fill: rgb("#f4f1e8"))[
  #label("OUR SPACES")
  #v(0.15in)
  #let space(sp) = [
    #block(height: 5.6in, clip: true, radius: 8pt, image(sp.img, width: 100%, height: 100%, fit: "cover"))
    #text(font: mono, weight: "bold", fill: navy)[#sp.name] \
    #text(size: 24pt)[#sp.text]
  ]
  #grid(columns: (1fr, 12.9in, 1fr), gutter: 0.3in, align: top,
    space(info.spaces.at(0)),
    block(height: 5.6in, clip: true, radius: 8pt, image("media/map.png", width: 100%, height: 100%, fit: "cover")),
    space(info.spaces.at(1)),
  )
]
]

#scale(s * 100%, origin: top + left, reflow: true, poster())
