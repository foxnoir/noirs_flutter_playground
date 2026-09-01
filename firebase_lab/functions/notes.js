"use strict";

const TITLE_MAX = 80;
const BODY_MAX = 2000;

const SEED_NOTES = [
  {
    title: "GET list",
    body: "Practice fetchNotes() against GET /notes.",
  },
  {
    title: "GET one",
    body: "Practice 404 by requesting a missing id.",
  },
  {
    title: "POST create",
    body: "Practice createNote() against POST /notes.",
  },
];

function parseNoteInput(body, {partial = false} = {}) {
  if (body == null || typeof body !== "object" || Array.isArray(body)) {
    return {ok: false, code: "validation", details: "JSON object required"};
  }

  const patch = {};

  if (!partial || body.title !== undefined) {
    if (typeof body.title !== "string") {
      return {ok: false, code: "validation", details: "title must be a string"};
    }
    const title = body.title.trim();
    if (title.length === 0) {
      return {ok: false, code: "validation", details: "title is required"};
    }
    if (title.length > TITLE_MAX) {
      return {
        ok: false,
        code: "validation",
        details: `title must be at most ${TITLE_MAX} characters`,
      };
    }
    patch.title = title;
  }

  if (!partial || body.body !== undefined) {
    if (body.body === undefined || body.body === null) {
      patch.body = "";
    } else if (typeof body.body !== "string") {
      return {ok: false, code: "validation", details: "body must be a string"};
    } else if (body.body.length > BODY_MAX) {
      return {
        ok: false,
        code: "validation",
        details: `body must be at most ${BODY_MAX} characters`,
      };
    } else {
      patch.body = body.body;
    }
  }

  if (partial && Object.keys(patch).length === 0) {
    return {ok: false, code: "validation", details: "no fields to update"};
  }

  return {ok: true, value: patch};
}

function toIso(value) {
  if (value == null) {
    return null;
  }
  if (typeof value.toDate === "function") {
    return value.toDate().toISOString();
  }
  if (value instanceof Date) {
    return value.toISOString();
  }
  if (typeof value === "string") {
    return value;
  }
  return null;
}

function toNoteDto(id, data) {
  return {
    id,
    title: data.title ?? "",
    body: data.body ?? "",
    createdAt: toIso(data.createdAt),
    updatedAt: toIso(data.updatedAt),
  };
}

module.exports = {
  BODY_MAX,
  TITLE_MAX,
  SEED_NOTES,
  parseNoteInput,
  toNoteDto,
};
