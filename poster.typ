#let projects = yaml("projects.yaml")
#let info = yaml("info.yaml")
#let accent = rgb("#b3a369")   // GT gold
#let navy = rgb("#003057")

#set page(width: 36in, height: 48in, margin: 1in, fill: white)
#let sans = "Inter"          // body, as on the website
#let mono = "Space Mono"     // headings and labels, as on the website
#set text(font: sans, size: 34pt, fill: rgb("#282828"))

// Header
#block(fill: navy, width: 100%, inset: 1in, radius: 12pt)[
  #set text(fill: white)
  #text(font: mono, size: 96pt, weight: "bold")[Interacting with Sound and Space] \
  #v(0.2in)
  #text(font: mono, size: 44pt, fill: accent)[Vertically Integrated Project · Georgia Tech · L42i]
]
#v(0.6in)

// Intro + team photo
#grid(columns: (1.4fr, 1fr), gutter: 0.5in,
  [Students join across class years and stay with the team over multiple semesters,
   taking on progressively larger parts of the work on interactive and immersive audio systems.],
  block(height: 2.0in, clip: true, image("media/team.jpg", width: 100%, height: 100%, fit: "cover")),
)
#v(0.6in)

#let label(t) = block(text(font: mono, size: 24pt, weight: "bold", fill: navy, tracking: 2pt)[#t])

// Project tiles: image fills the card, text sits on a translucent panel
#grid(columns: 2, gutter: 0.5in,
  ..projects.map(p => block(
    stroke: 6pt + navy, radius: 16pt, clip: true, width: 100%, height: 10in,
  )[
    #place(image(p.img, width: 100%, height: 100%, fit: "cover"))
    #block(fill: navy, width: 100%, inset: (x: 0.4in, y: 0.25in))[
      #text(font: mono, size: 52pt, weight: "bold", fill: white)[#p.name]
    ]
    #place(bottom, block(fill: rgb("#f4f1e8ee"), width: 100%, inset: 0.4in)[
      #set text(size: 32pt)
      #p.abstract
      #v(0.3in)
      #label("MAJORS NEEDED") #p.majors
      #v(0.25in)
      #grid(columns: (1fr, 1fr),
        [#label("TEAM SIZE") #p.team_size],
        [#label("PROJECT AGE") #p.age])
    ])
  ])
)

#v(0.5in)
// Footer: spaces, team, contact
#block(stroke: 6pt + navy, radius: 16pt, width: 100%, inset: 0.4in, fill: rgb("#f4f1e8"))[
  #grid(columns: (2.2fr, 1fr, 1.2fr), gutter: 0.5in,
    [
      #label("OUR SPACES")
      #v(0.15in)
      #grid(columns: (1fr, 1fr), gutter: 0.3in,
        ..info.spaces.map(sp => [
          #block(height: 1.5in, clip: true, radius: 8pt, image(sp.img, width: 100%, height: 100%, fit: "cover"))
          #text(font: mono, weight: "bold", fill: navy)[#sp.name] \
          #text(size: 24pt)[#sp.text]
        ]))
    ],
    [
      #label("TEAM")
      #v(0.15in)
      #info.team.join(linebreak())
    ],
    [
      #label("CONTACT")
      #v(0.15in)
      #info.email
      #for e in info.extra [#v(0.2in) #e]
    ],
  )
]
