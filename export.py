"""Export the poster as PDFs in all standard sizes: .venv/bin/python export.py"""
import os, typst
SIZES = {            # name: (width, height) in inches
    "11x17-tabloid": (11, 17), "A3": (11.69, 16.54), "A2": (16.54, 23.39), "18x24": (18, 24),
    "A1": (23.39, 33.11), "24x36": (24, 36), "27x40": (27, 40), "30x40": (30, 40),
    "A0": (33.11, 46.81), "36x48": (36, 48),
}
os.makedirs("exports", exist_ok=True)
for name, (w, h) in SIZES.items():
    out = f"exports/VIP-poster_{name}.pdf"
    typst.compile("poster.typ", output=out, font_paths=["fonts"], sys_inputs={"w": str(w), "h": str(h)})
    print(out)
