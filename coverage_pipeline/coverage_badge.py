#!/usr/bin/env python3
"""Build coverage SVGs from an lcov.info file."""

from __future__ import annotations

import argparse
import re
from pathlib import Path

_GENERATED_SUFFIXES = (".g.dart", ".freezed.dart", ".mocks.dart")
_SKIP_PREFIXES = (
    "import ",
    "export ",
    "library ",
    "part ",
    "part of ",
    "static const ",
)
_CLASS_DECL = re.compile(
    r"^(abstract\s+|base\s+|final\s+|sealed\s+|mixin\s+)*"
    r"(class|mixin|enum|extension)\s+"
)
_STRING_ONLY = re.compile(r"^[rRuU]?['\"].+['\"];?$")


def parse_lcov(path: Path) -> tuple[int, int]:
    lines_found = 0
    lines_hit = 0
    for raw in path.read_text(encoding="utf-8").splitlines():
        if raw.startswith("LF:"):
            lines_found += int(raw[3:])
        elif raw.startswith("LH:"):
            lines_hit += int(raw[3:])
    return lines_hit, lines_found


def lcov_source_files(path: Path) -> set[str]:
    return {
        raw[3:]
        for raw in path.read_text(encoding="utf-8").splitlines()
        if raw.startswith("SF:")
    }


def executable_line_numbers(source: str) -> list[int]:
    """Approximate VM-instrumented lines for a Dart file tests never loaded.

    `flutter test --coverage` only emits records for libraries the VM loaded.
    An unused copy under lib/ would otherwise not change the percent.
    """
    numbers: list[int] = []
    in_block_comment = False
    for index, raw in enumerate(source.splitlines(), start=1):
        stripped = raw.strip()
        if not stripped:
            continue
        if in_block_comment:
            if "*/" in stripped:
                in_block_comment = False
            continue
        if stripped.startswith("/*"):
            if "*/" not in stripped:
                in_block_comment = True
            continue
        if stripped.startswith("//"):
            continue
        if stripped.startswith(_SKIP_PREFIXES):
            continue
        if stripped in ("{", "}", "(", ");", ","):
            continue
        if _CLASS_DECL.match(stripped):
            continue
        if _STRING_ONLY.match(stripped):
            continue
        numbers.append(index)
    return numbers


def append_unhit_lib_files(lcov_path: Path, app_root: Path) -> int:
    """Add lib/*.dart files missing from lcov as 0-hit records. Returns files added."""
    lib_root = app_root / "lib"
    if not lib_root.is_dir():
        return 0
    known = lcov_source_files(lcov_path)
    records: list[str] = []
    for dart in sorted(lib_root.rglob("*.dart")):
        if dart.name.endswith(_GENERATED_SUFFIXES):
            continue
        relative = dart.relative_to(app_root).as_posix()
        if relative in known:
            continue
        numbers = executable_line_numbers(dart.read_text(encoding="utf-8"))
        if not numbers:
            continue
        lines = [f"SF:{relative}"]
        lines.extend(f"DA:{number},0" for number in numbers)
        lines.append(f"LF:{len(numbers)}")
        lines.append("LH:0")
        lines.append("end_of_record")
        records.append("\n".join(lines) + "\n")
    if not records:
        return 0
    text = lcov_path.read_text(encoding="utf-8")
    if text and not text.endswith("\n"):
        text += "\n"
    lcov_path.write_text(text + "".join(records), encoding="utf-8")
    return len(records)


def coverage_color(percent: float) -> str:
    if percent >= 90:
        return "#4c1"
    if percent >= 80:
        return "#97ca00"
    if percent >= 70:
        return "#dfb317"
    if percent >= 60:
        return "#B385DC"
    return "#9B7BB8"


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
  <rect width="{width}" height="28" fill="#8B7E9E"/>
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
  <rect width="420" height="108" rx="10" fill="#F3EDF8" stroke="#D0B6EB"/>
  <text x="20" y="32" fill="#8B7BA3" font-family="Verdana,Geneva,DejaVu Sans,sans-serif" font-size="12" font-weight="700">LINE COVERAGE</text>
  <text x="400" y="40" text-anchor="end" fill="#6B4C8A" font-family="Verdana,Geneva,DejaVu Sans,sans-serif" font-size="32" font-weight="700">{label}</text>
  <text x="20" y="52" fill="#8B7BA3" font-family="Verdana,Geneva,DejaVu Sans,sans-serif" font-size="11">{hit} / {found} lines hit</text>
  <rect x="20" y="70" width="{bar_w}" height="16" rx="8" fill="#DCCFEA"/>
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

    app_root = args.lcov.resolve().parent.parent
    added = append_unhit_lib_files(args.lcov, app_root)
    hit, found = parse_lcov(args.lcov)
    percent, label = format_percent(hit, found)
    write_badge(args.badge, percent, label)
    write_card(args.card, percent, label, hit, found)
    if args.readme:
        update_readme(args.readme, label, hit, found)
    extra = f", +{added} unhit lib file(s)" if added else ""
    print(f"coverage: {label} ({hit}/{found}){extra}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
