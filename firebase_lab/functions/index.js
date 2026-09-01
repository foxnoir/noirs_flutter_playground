"use strict";

const {initializeApp} = require("firebase-admin/app");
const {FieldValue, getFirestore} = require("firebase-admin/firestore");
const express = require("express");
const {onRequest} = require("firebase-functions/v2/https");
const {parseNoteInput, SEED_NOTES, toNoteDto} = require("./notes");

initializeApp();

const db = getFirestore();
const notes = db.collection("notes");
const app = express();

app.use(express.json());

let didEnsureSeed = false;

function sendError(res, status, code, details) {
  const payload = {code};
  if (details) {
    payload.details = details;
  }
  res.status(status).json(payload);
}

async function ensureSeed() {
  if (didEnsureSeed) {
    return;
  }
  const existing = await notes.limit(1).get();
  if (existing.empty) {
    const now = FieldValue.serverTimestamp();
    for (const seed of SEED_NOTES) {
      await notes.add({
        title: seed.title,
        body: seed.body,
        createdAt: now,
        updatedAt: now,
      });
    }
  }
  didEnsureSeed = true;
}

app.get("/health", (_req, res) => {
  res.json({ok: true});
});

app.post("/seed", async (_req, res) => {
  try {
    const existing = await notes.get();
    const wipe = db.batch();
    for (const doc of existing.docs) {
      wipe.delete(doc.ref);
    }
    await wipe.commit();

    const now = FieldValue.serverTimestamp();
    for (const seed of SEED_NOTES) {
      await notes.add({
        title: seed.title,
        body: seed.body,
        createdAt: now,
        updatedAt: now,
      });
    }
    didEnsureSeed = true;
    res.status(204).send();
  } catch (error) {
    console.error(error);
    sendError(res, 500, "unknown");
  }
});

app.get("/notes", async (_req, res) => {
  try {
    await ensureSeed();
    const snapshot = await notes.orderBy("createdAt", "asc").get();
    res.json(snapshot.docs.map((doc) => toNoteDto(doc.id, doc.data())));
  } catch (error) {
    console.error(error);
    sendError(res, 500, "unknown");
  }
});

app.get("/notes/:id", async (req, res) => {
  try {
    const doc = await notes.doc(req.params.id).get();
    if (!doc.exists) {
      sendError(res, 404, "not_found");
      return;
    }
    res.json(toNoteDto(doc.id, doc.data()));
  } catch (error) {
    console.error(error);
    sendError(res, 500, "unknown");
  }
});

app.post("/notes", async (req, res) => {
  try {
    const parsed = parseNoteInput(req.body);
    if (!parsed.ok) {
      sendError(res, 400, parsed.code, parsed.details);
      return;
    }
    const now = FieldValue.serverTimestamp();
    const ref = await notes.add({
      ...parsed.value,
      createdAt: now,
      updatedAt: now,
    });
    const created = await ref.get();
    res.status(201).json(toNoteDto(created.id, created.data()));
  } catch (error) {
    console.error(error);
    sendError(res, 500, "unknown");
  }
});

app.patch("/notes/:id", async (req, res) => {
  try {
    const parsed = parseNoteInput(req.body, {partial: true});
    if (!parsed.ok) {
      sendError(res, 400, parsed.code, parsed.details);
      return;
    }
    const ref = notes.doc(req.params.id);
    const existing = await ref.get();
    if (!existing.exists) {
      sendError(res, 404, "not_found");
      return;
    }
    await ref.update({
      ...parsed.value,
      updatedAt: FieldValue.serverTimestamp(),
    });
    const updated = await ref.get();
    res.json(toNoteDto(updated.id, updated.data()));
  } catch (error) {
    console.error(error);
    sendError(res, 500, "unknown");
  }
});

app.delete("/notes/:id", async (req, res) => {
  try {
    const ref = notes.doc(req.params.id);
    const existing = await ref.get();
    if (!existing.exists) {
      sendError(res, 404, "not_found");
      return;
    }
    await ref.delete();
    res.status(204).send();
  } catch (error) {
    console.error(error);
    sendError(res, 500, "unknown");
  }
});

app.use((_req, res) => {
  sendError(res, 404, "not_found");
});

exports.api = onRequest(
    {
      region: "europe-west1",
      cors: true,
      invoker: "public",
      maxInstances: 2,
    },
    app,
);
