"""Export the poster as a 30x40 in portrait PDF (VIP Rush format): .venv/bin/python export.py"""
import os, typst
os.makedirs("exports", exist_ok=True)
out = "exports/VIP-poster_30x40.pdf"
typst.compile("poster.typ", output=out, font_paths=["fonts"], sys_inputs={"w": "30", "h": "40"})
print(out)
