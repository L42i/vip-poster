#!/bin/sh
# usage: ./build.sh   (add "watch" to rebuild on save)
cd "$(dirname "$0")"
.venv/bin/python -c "import typst,sys; (typst.watch if 'watch' in sys.argv else typst.compile)('poster.typ', output='poster.pdf', font_paths=['fonts'])" "$@"
