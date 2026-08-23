#!/usr/bin/env python3
"""Generate local README badges. Official brand colors stay official.

When a tool has no published badge color, pick from the playground palette
(purple / blue / turquoise / pink / green). Avoid orange, red, and yellow
unless that is the official brand color.
"""

from __future__ import annotations

from pathlib import Path

ROOT = Path(__file__).resolve().parent

# label, fill, note
BADGES: list[tuple[str, str, str, str]] = [
    ("flutter", "Flutter", "#02569B", "official Flutter"),
    ("dart", "Dart", "#0175C2", "official Dart"),
    ("riverpod", "Riverpod", "#8B5FBF", "app purple (no published badge color)"),
    ("gorouter", "GoRouter", "#2D8A86", "teal (no published badge color)"),
    ("flutter_localizations", "Flutter Localizations", "#02569B", "official Flutter"),
    ("intl", "Intl", "#7A5EA8", "purple (replaces orange)"),
    ("very_good", "Very Good Analysis", "#B22C89", "Very Good Ventures magenta"),
    ("fvm", "FVM", "#2A9D8F", "turquoise (no published badge color)"),
    ("ios", "iOS", "#000000", "official Apple"),
    ("web", "Web", "#1A7A84", "turquoise (no published badge color)"),
    ("linkedin", "LinkedIn", "#0A66C2", "official LinkedIn"),
    ("instagram", "Instagram", "#E4405F", "official Instagram"),
    ("x", "X", "#000000", "official X"),
]


def badge_svg(label: str, color: str) -> str:
    width = max(72, 22 + len(label) * 8)
    return f"""<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="28" role="img" aria-label="{label}">
  <title>{label}</title>
  <rect width="{width}" height="28" fill="{color}"/>
  <text x="{width / 2}" y="18" text-anchor="middle" fill="#fff" font-family="Verdana,Geneva,DejaVu Sans,sans-serif" font-size="11" font-weight="700">{label}</text>
</svg>
"""


def write_all(out_dir: Path) -> None:
    out_dir.mkdir(parents=True, exist_ok=True)
    for slug, label, color, _note in BADGES:
        (out_dir / f"{slug}.svg").write_text(badge_svg(label, color), encoding="utf-8")


def main() -> int:
    write_all(ROOT)
    print(f"wrote {len(BADGES)} badges → {ROOT}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
