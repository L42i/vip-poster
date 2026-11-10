#let projects = yaml("projects.yaml")
#let info = yaml("info.yaml")
#let accent = rgb("#b3a369")   // GT gold
#let navy = rgb("#003057")

#set page(width: 36in, height: 48in, margin: 1in, fill: white)
#let sans = "Inter"          // body, as on the website
#let mono = "Space Mono"     // headings and labels, as on the website
#set text(font: sans, size: 34pt, fill: rgb("#282828"))

#let label(t) = block(text(font: mono, size: 24pt, weight: "bold", fill: navy, tracking: 2pt)[#t])

// Header: title, affiliation, team, logo
#block(fill: navy, width: 100%, inset: 0.8in, radius: 12pt)[
  #set text(fill: white)
  #grid(columns: (1fr, auto), gutter: 0.5in, align: horizon,
    [
      #text(font: mono, size: 72pt, weight: "bold")[VIP: Interacting with Sound and Space] \
      #v(0.2in)
      #text(font: mono, size: 40pt)[#text(fill: accent)[Team:] #info.team.join("  ·  ")] \
      #v(0.1in)
      #text(font: mono, size: 40pt)[#text(fill: accent)[Contact:] #info.contact_name, #info.email]
    ],
    align(right)[
      #image("media/l42i-logo-white.png", width: 7in)
      #v(0.15in)
      #text(font: mono, size: 32pt)[Lab for Interaction & Immersion] \
      #text(font: mono, size: 32pt, fill: accent)[School of Music, College of Design] \
      #text(font: mono, size: 32pt, fill: accent)[Georgia Institute of Technology]
    ],
  )
]
#v(0.5in)

// Intro and basic info
#grid(columns: (1.5fr, 1fr), gutter: 0.8in, align: horizon,
  [Students join across class years and stay with the team over multiple semesters,
   taking on progressively larger parts of the work on interactive and immersive audio systems.],
  list(..info.basics.map(b => [#text(font: mono, weight: "bold", fill: navy, size: 26pt)[#b.label:] #b.text])),
)
#v(0.5in)

// Project tiles: image fills the card, text sits on a translucent panel
#grid(columns: 2, gutter: 0.5in,
  ..projects.map(p => block(
    stroke: 6pt + navy, radius: 16pt, clip: true, width: 100%, height: 8.9in,
  )[
    #place(image(p.img, width: 100%, height: 100%, fit: "cover"))
    #block(fill: navy, width: 100%, inset: (x: 0.4in, y: 0.25in))[
      #text(font: mono, size: 52pt, weight: "bold", fill: white)[#p.name]
    ]
    #place(bottom, block(fill: rgb("#f4f1e8bb"), width: 100%, inset: 0.4in)[
      #set text(size: 32pt)
      #p.abstract
      #v(0.3in)
      #label("MAJORS NEEDED") #p.majors
      #v(0.25in)
      #grid(columns: (1fr, 1fr, 1.4fr),
        [#label("TEAM SIZE") #p.team_size],
        [#label("PROJECT AGE") #p.age],
        [#label("MEETING HOURS") #p.meeting])
    ])
  ])
)

#v(0.5in)
// Footer: spaces, team, contact
#block(stroke: 6pt + navy, radius: 16pt, width: 100%, inset: 0.4in, fill: rgb("#f4f1e8"))[
  #grid(columns: (1fr,), gutter: 0.5in,
    [
      #label("OUR SPACES")
      #v(0.15in)
      #grid(columns: (1fr, 1fr), gutter: 0.3in,
        ..info.spaces.map(sp => [
          #block(height: 4.5in, clip: true, radius: 8pt, image(sp.img, width: 100%, height: 100%, fit: "cover"))
          #text(font: mono, weight: "bold", fill: navy)[#sp.name] \
          #text(size: 24pt)[#sp.text]
        ]))
    ],
  )
]
