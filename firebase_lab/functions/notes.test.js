"use strict";

const {describe, it} = require("node:test");
const assert = require("node:assert/strict");
const {parseNoteInput, toNoteDto} = require("./notes");

describe("parseNoteInput", () => {
  it("requires a JSON object", () => {
    assert.equal(parseNoteInput(null).ok, false);
    assert.equal(parseNoteInput([]).ok, false);
    assert.equal(parseNoteInput("note").ok, false);
  });

  it("trims title and defaults body", () => {
    const parsed = parseNoteInput({title: "  Hello  "});
    assert.equal(parsed.ok, true);
    assert.deepEqual(parsed.value, {title: "Hello", body: ""});
  });

  it("rejects an empty title", () => {
    const parsed = parseNoteInput({title: "   "});
    assert.equal(parsed.ok, false);
    assert.equal(parsed.code, "validation");
  });

  it("allows a partial patch", () => {
    const parsed = parseNoteInput({body: "updated"}, {partial: true});
    assert.equal(parsed.ok, true);
    assert.deepEqual(parsed.value, {body: "updated"});
  });
});

describe("toNoteDto", () => {
  it("maps timestamps to ISO strings", () => {
    const createdAt = new Date("2026-09-01T10:00:00.000Z");
    const dto = toNoteDto("abc", {
      title: "GET list",
      body: "Practice",
      createdAt: {toDate: () => createdAt},
      updatedAt: createdAt,
    });
    assert.deepEqual(dto, {
      id: "abc",
      title: "GET list",
      body: "Practice",
      createdAt: "2026-09-01T10:00:00.000Z",
      updatedAt: "2026-09-01T10:00:00.000Z",
    });
  });
});
