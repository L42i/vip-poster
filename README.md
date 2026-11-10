# VIP poster: Interacting with Sound and Space

Poster (30x40 in, portrait, VIP Rush format) for L42i's Vertically Integrated Project at Georgia Tech, built with [Typst](https://typst.app).

## Build

```sh
python3 -m venv .venv && .venv/bin/pip install -r requirements.txt
./build.sh          # writes poster.pdf (30x40 in)
.venv/bin/python export.py   # writes exports/VIP-poster_30x40.pdf
./build.sh watch    # rebuild on save
```

## Edit

- `projects.yaml`: one entry per project tile (name, image, abstract, majors, team size, age)
- `info.yaml`: footer (spaces, team, contact email, extra info)
- `poster.typ`: layout
- `media/`: images; `fonts/`: Space Mono (converted from the website's webfont); body font is Inter (install system-wide)
