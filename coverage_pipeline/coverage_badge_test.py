#!/usr/bin/env python3
"""Tests for coverage_badge.py. Run: python3 coverage_pipeline/coverage_badge_test.py"""

from __future__ import annotations

import tempfile
import unittest
from pathlib import Path

from coverage_badge import (
    append_unhit_lib_files,
    executable_line_numbers,
    parse_lcov,
)


class ExecutableLineNumbersTest(unittest.TestCase):
    def test_skips_comments_imports_and_const_only_classes(self) -> None:
        source = """
import 'package:flutter/material.dart';

/// Route names.
abstract final class AppRouteNames {
  static const landing = 'landing';
  static const nested =
      'nested-path';
}
"""
        self.assertEqual(executable_line_numbers(source), [])

    def test_counts_widget_body_lines(self) -> None:
        source = """
import 'package:flutter/material.dart';

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
    );
  }
}
"""
        numbers = executable_line_numbers(source)
        self.assertIn(5, numbers)
        self.assertIn(10, numbers)
        self.assertIn(11, numbers)
        self.assertNotIn(1, numbers)
        self.assertNotIn(4, numbers)


class AppendUnhitLibFilesTest(unittest.TestCase):
    def test_adds_unused_lib_file_as_zero_hits(self) -> None:
        with tempfile.TemporaryDirectory() as raw:
            app = Path(raw)
            dart = app / "lib" / "orphan.dart"
            dart.parent.mkdir(parents=True)
            dart.write_text(
                "void unused() {\n  return;\n}\n",
                encoding="utf-8",
            )
            lcov = app / "coverage" / "lcov.info"
            lcov.parent.mkdir(parents=True)
            lcov.write_text(
                "SF:lib/used.dart\nDA:1,1\nLF:1\nLH:1\nend_of_record\n",
                encoding="utf-8",
            )

            added = append_unhit_lib_files(lcov, app)
            self.assertEqual(added, 1)
            text = lcov.read_text(encoding="utf-8")
            self.assertIn("SF:lib/orphan.dart", text)
            self.assertIn("LH:0", text)
            hit, found = parse_lcov(lcov)
            self.assertEqual(hit, 1)
            self.assertGreater(found, 1)


if __name__ == "__main__":
    unittest.main()
