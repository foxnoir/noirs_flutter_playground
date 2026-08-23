#!/usr/bin/env python3
"""Build coverage SVGs from an lcov.info file."""

from __future__ import annotations

import argparse
import re
from pathlib import Path


def parse_lcov(path: Path) -> tuple[int, int]:
    lines_found = 0
    lines_hit = 0
    for raw in path.read_text(encoding="utf-8").splitlines():
        if raw.startswith("LF:"):
            lines_found += int(raw[3:])
        elif raw.startswith("LH:"):
            lines_hit += int(raw[3:])
    return lines_hit, lines_found


def coverage_color(percent: float) -> str:
    if percent >= 90:
        return "#4c1"
    if percent >= 80:
        return "#97ca00"
    if percent >= 70:
        return "#dfb317"
    if percent >= 60:
        return "#fe7d37"
    return "#e05d44"


def format_percent(hit: int, found: int) -> tuple[float, str]:
    if found == 0:
        return 0.0, "0%"
    percent = 100.0 * hit / found
    if percent == int(percent):
        label = f"{int(percent)}%"
    else:
        label = f"{percent:.1f}%"
    return percent, label


def write_badge(path: Path, percent: float, label: str) -> None:
    color = coverage_color(percent)
    left = "coverage"
    left_w = 82
    right_w = max(54, 16 + len(label) * 8)
    width = left_w + right_w
    svg = f"""<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="28" role="img" aria-label="coverage: {label}">
  <title>coverage: {label}</title>
  <rect width="{width}" height="28" fill="#555"/>
  <rect x="{left_w}" width="{right_w}" height="28" fill="{color}"/>
  <g fill="#fff" text-anchor="middle" font-family="Verdana,Geneva,DejaVu Sans,sans-serif" font-size="11" font-weight="700">
    <text x="{left_w / 2}" y="18">{left}</text>
    <text x="{left_w + right_w / 2}" y="18">{label}</text>
  </g>
</svg>
"""
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(svg, encoding="utf-8")


def write_card(path: Path, percent: float, label: str, hit: int, found: int) -> None:
    color = coverage_color(percent)
    bar_w = 380
    fill_w = 0 if found == 0 else round(bar_w * min(percent, 100.0) / 100.0)
    svg = f"""<svg xmlns="http://www.w3.org/2000/svg" width="420" height="108" role="img" aria-label="line coverage {label}">
  <rect width="420" height="108" rx="10" fill="#0d1117" stroke="#30363d"/>
  <text x="20" y="32" fill="#8b949e" font-family="Verdana,Geneva,DejaVu Sans,sans-serif" font-size="12" font-weight="700">LINE COVERAGE</text>
  <text x="400" y="40" text-anchor="end" fill="#ffffff" font-family="Verdana,Geneva,DejaVu Sans,sans-serif" font-size="32" font-weight="700">{label}</text>
  <text x="20" y="52" fill="#8b949e" font-family="Verdana,Geneva,DejaVu Sans,sans-serif" font-size="11">{hit} / {found} lines hit</text>
  <rect x="20" y="70" width="{bar_w}" height="16" rx="8" fill="#21262d"/>
  <rect x="20" y="70" width="{fill_w}" height="16" rx="8" fill="{color}"/>
</svg>
"""
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(svg, encoding="utf-8")


def update_readme(path: Path, percent_label: str, hit: int, found: int) -> None:
    if not path.is_file():
        return
    text = path.read_text(encoding="utf-8")
    block = (
        f"**{percent_label}** line coverage ({hit} of {found} lines).\n"
    )
    pattern = re.compile(
        r"<!-- coverage-percent:start -->.*?<!-- coverage-percent:end -->",
        re.DOTALL,
    )
    replacement = (
        "<!-- coverage-percent:start -->\n"
        f"{block}"
        "<!-- coverage-percent:end -->"
    )
    if not pattern.search(text):
        return
    path.write_text(pattern.sub(replacement, text, count=1), encoding="utf-8")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--lcov", required=True, type=Path)
    parser.add_argument("--badge", required=True, type=Path)
    parser.add_argument("--card", required=True, type=Path)
    parser.add_argument("--readme", type=Path)
    args = parser.parse_args()

    hit, found = parse_lcov(args.lcov)
    percent, label = format_percent(hit, found)
    write_badge(args.badge, percent, label)
    write_card(args.card, percent, label, hit, found)
    if args.readme:
        update_readme(args.readme, label, hit, found)
    print(f"coverage: {label} ({hit}/{found})")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
