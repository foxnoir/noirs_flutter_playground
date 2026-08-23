#!/usr/bin/env python3
"""Generate local README badges.

Official brand colors stay official, except black — it is hard to see.
When a tool has no published color, or the official color is black, pick from
the playground palette (purple / blue / turquoise / pink / green).
Avoid black, orange, red, and yellow.
"""

from __future__ import annotations

from pathlib import Path
from typing import Tuple, Union

ROOT = Path(__file__).resolve().parent

# slug, label, fill (hex or 3-stop top→bottom gradient), note
Fill = Union[str, Tuple[str, str, str]]
BADGES: list[tuple[str, str, Fill, str]] = [
    ("flutter", "Flutter", "#02569B", "official Flutter"),
    ("dart", "Dart", "#0175C2", "official Dart"),
    ("riverpod", "Riverpod", "#8B5FBF", "app purple (no published badge color)"),
    ("gorouter", "GoRouter", "#2D8A86", "teal (no published badge color)"),
    ("flutter_localizations", "Flutter Localizations", "#02569B", "official Flutter"),
    ("intl", "Intl", "#7A5EA8", "purple (replaces orange)"),
    ("very_good", "Very Good Analysis", "#B22C89", "Very Good Ventures magenta"),
    ("fvm", "FVM", "#2A9D8F", "turquoise (no published badge color)"),
    ("ios", "iOS", "#4DB8C4", "pastel turquoise (replaces black)"),
    ("web", "Web", "#1A7A84", "turquoise (no published badge color)"),
    ("linkedin", "LinkedIn", "#0A66C2", "official LinkedIn"),
    (
        "instagram",
        "Instagram",
        ("#4A2F6B", "#8B5FBF", "#C9A8E0"),
        "lilac gradient: dark → mid → light",
    ),
    ("x", "X", "#7EB8D6", "pastel light blue (replaces black)"),
]


def badge_svg(label: str, fill: Fill) -> str:
    width = max(72, 22 + len(label) * 8)
    if isinstance(fill, tuple):
        dark, mid, light = fill
        defs = f"""  <defs>
    <linearGradient id="fill" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0%" stop-color="{dark}"/>
      <stop offset="50%" stop-color="{mid}"/>
      <stop offset="100%" stop-color="{light}"/>
    </linearGradient>
  </defs>
"""
        rect_fill = "url(#fill)"
    else:
        defs = ""
        rect_fill = fill
    return f"""<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="28" role="img" aria-label="{label}">
  <title>{label}</title>
{defs}  <rect width="{width}" height="28" fill="{rect_fill}"/>
  <text x="{width / 2}" y="18" text-anchor="middle" fill="#fff" font-family="Verdana,Geneva,DejaVu Sans,sans-serif" font-size="11" font-weight="700">{label}</text>
</svg>
"""


def write_all(out_dir: Path) -> None:
    out_dir.mkdir(parents=True, exist_ok=True)
    for slug, label, fill, _note in BADGES:
        (out_dir / f"{slug}.svg").write_text(badge_svg(label, fill), encoding="utf-8")


def main() -> int:
    write_all(ROOT)
    print(f"wrote {len(BADGES)} badges → {ROOT}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
