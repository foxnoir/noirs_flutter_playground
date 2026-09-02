"use strict";

const {initializeApp} = require("firebase-admin/app");
const {getFirestore} = require("firebase-admin/firestore");
const express = require("express");
const {onRequest} = require("firebase-functions/v2/https");

initializeApp();

const db = getFirestore();
const books = db.collection("books");
const app = express();

app.use(express.json());

const STATUSES = new Set(["not_started", "reading", "finished"]);

const SUCCESS_BOOK = {
  id: null,
  title: "A Court of Silver Flames",
  author: "Sarah J. Maas",
  status: "reading",
};

const SEED_BOOKS = [
  {
    id: "1",
    title: "A Court of Thorns and Roses",
    author: "Sarah J. Maas",
    status: "finished",
  },
  {
    id: "2",
    title: "A Court of Mist and Fury",
    author: "Sarah J. Maas",
    status: "finished",
  },
  {
    id: "3",
    title: "Fourth Wing",
    author: "Rebecca Yarros",
    status: "finished",
  },
  {
    id: "4",
    title: "Iron Flame",
    author: "Rebecca Yarros",
    status: "reading",
  },
  {
    id: "5",
    title: "Onyx Storm",
    author: "Rebecca Yarros",
    status: "not_started",
  },
  {
    id: "6",
    title: "House of Earth and Blood",
    author: "Sarah J. Maas",
    status: "finished",
  },
  {
    id: "7",
    title: "A Court of Wings and Ruin",
    author: "Sarah J. Maas",
    status: "finished",
  },
  {
    id: "8",
    title: "A Court of Frost and Starlight",
    author: "Sarah J. Maas",
    status: "reading",
  },
  {
    id: "9",
    title: "A Court of Silver Flames",
    author: "Sarah J. Maas",
    status: "not_started",
  },
  {
    id: "10",
    title: "Blood and Ash – Liebe kennt keine Grenzen",
    author: "Jennifer Armentrout",
    status: "finished",
  },
  {
    id: "11",
    title: "Flesh and Fire – Liebe kennt keine Grenzen",
    author: "Jennifer Armentrout",
    status: "reading",
  },
  {
    id: "12",
    title: "Crown and Bones – Liebe kennt keine Grenzen",
    author: "Jennifer Armentrout",
    status: "not_started",
  },
  {
    id: "13",
    title: "War and Queens – Liebe kennt keine Grenzen",
    author: "Jennifer Armentrout",
    status: "not_started",
  },
];

const SEED_VERSION = 4;

function sendError(res, status, code, message) {
  res.status(status).json({code, message});
}

function bookStatus(data) {
  if (STATUSES.has(data.status)) {
    return data.status;
  }
  return data.finished ? "finished" : "reading";
}

function toBook(id, data) {
  return {
    id,
    title: data.title ?? "",
    author: data.author ?? "",
    status: bookStatus(data),
  };
}

async function ensureSeed() {
  const meta = db.collection("_meta").doc("books");
  const marker = await meta.get();
  const version = marker.data()?.version ?? 0;
  if (version >= SEED_VERSION) {
    return;
  }
  for (const seed of SEED_BOOKS) {
    await books.doc(seed.id).set({
      title: seed.title,
      author: seed.author,
      status: seed.status,
    });
  }
  await meta.set({seeded: true, version: SEED_VERSION});
}

function parseBook(body) {
  if (body == null || typeof body !== "object" || Array.isArray(body)) {
    return {ok: false, message: "JSON object required"};
  }
  if (typeof body.title !== "string" || body.title.trim().length === 0) {
    return {ok: false, message: "title is required"};
  }
  if (typeof body.author !== "string" || body.author.trim().length === 0) {
    return {ok: false, message: "author is required"};
  }
  let status = "not_started";
  if (body.status !== undefined) {
    if (!STATUSES.has(body.status)) {
      return {ok: false, message: "status must be not_started, reading, or finished"};
    }
    status = body.status;
  } else if (body.finished !== undefined) {
    if (typeof body.finished !== "boolean") {
      return {ok: false, message: "finished must be a boolean"};
    }
    status = body.finished ? "finished" : "reading";
  }
  return {
    ok: true,
    value: {
      title: body.title.trim(),
      author: body.author.trim(),
      status,
    },
  };
}

app.get("/health", (_req, res) => {
  res.json({ok: true});
});

app.get("/success", (_req, res) => {
  res.status(200).json({
    message: "Success response from server",
    data: SUCCESS_BOOK,
  });
});

app.get("/error", (_req, res) => {
  sendError(res, 500, "unknown", "Internal server error occurred");
});

app.get("/timeout", async (_req, res) => {
  await new Promise((resolve) => setTimeout(resolve, 2000));
  res.status(200).json({message: "Delayed response"});
});

app.post("/search", async (req, res) => {
  try {
    await ensureSeed();
    const title = req.body?.title;
    const author = req.body?.author;
    if (typeof title !== "string" || title.trim().length === 0) {
      sendError(res, 400, "validation", "title is required");
      return;
    }
    if (typeof author !== "string" || author.trim().length === 0) {
      sendError(res, 400, "validation", "author is required");
      return;
    }
    const snapshot = await books.where("title", "==", title.trim()).get();
    const doc = snapshot.docs.find(
        (entry) => entry.data().author === author.trim(),
    );
    if (!doc) {
      sendError(res, 401, "unauthorized", "Invalid title or author");
      return;
    }
    res.status(200).json({
      message: "Match found",
      book: toBook(doc.id, doc.data()),
    });
  } catch (error) {
    console.error(error);
    sendError(res, 500, "unknown", "Internal server error occurred");
  }
});

app.get("/books", async (_req, res) => {
  try {
    await ensureSeed();
    const snapshot = await books.orderBy("title", "asc").get();
    res.status(200).json({
      message: "Books fetched",
      books: snapshot.docs.map((doc) => toBook(doc.id, doc.data())),
    });
  } catch (error) {
    console.error(error);
    sendError(res, 500, "unknown", "Internal server error occurred");
  }
});

app.get("/books/:id", async (req, res) => {
  try {
    const doc = await books.doc(req.params.id).get();
    if (!doc.exists) {
      sendError(res, 404, "not_found", "Book not found");
      return;
    }
    res.status(200).json({
      message: "Book fetched",
      book: toBook(doc.id, doc.data()),
    });
  } catch (error) {
    console.error(error);
    sendError(res, 500, "unknown", "Internal server error occurred");
  }
});

app.post("/books", async (req, res) => {
  try {
    await ensureSeed();
    const parsed = parseBook(req.body);
    if (!parsed.ok) {
      sendError(res, 400, "validation", parsed.message);
      return;
    }
    const clash = await books.where("title", "==", parsed.value.title).limit(1).get();
    if (!clash.empty) {
      sendError(res, 409, "conflict", "Book with this title already exists");
      return;
    }
    const ref = await books.add(parsed.value);
    const created = await ref.get();
    res.status(201).json({
      message: "Book added",
      book: toBook(created.id, created.data()),
    });
  } catch (error) {
    console.error(error);
    sendError(res, 500, "unknown", "Internal server error occurred");
  }
});

app.put("/books/:id", async (req, res) => {
  try {
    const parsed = parseBook(req.body);
    if (!parsed.ok) {
      sendError(res, 400, "validation", parsed.message);
      return;
    }
    const ref = books.doc(req.params.id);
    const existing = await ref.get();
    if (!existing.exists) {
      sendError(res, 404, "not_found", "Book not found");
      return;
    }
    const clash = await books.where("title", "==", parsed.value.title).get();
    if (clash.docs.some((doc) => doc.id !== ref.id)) {
      sendError(res, 409, "conflict", "Book with this title already exists");
      return;
    }
    await ref.set(parsed.value);
    const updated = await ref.get();
    res.status(200).json({
      message: "Book updated",
      book: toBook(updated.id, updated.data()),
    });
  } catch (error) {
    console.error(error);
    sendError(res, 500, "unknown", "Internal server error occurred");
  }
});

app.delete("/books/:id", async (req, res) => {
  try {
    const ref = books.doc(req.params.id);
    const existing = await ref.get();
    if (!existing.exists) {
      sendError(res, 404, "not_found", "Book not found");
      return;
    }
    await ref.delete();
    res.status(200).json({message: "Book deleted"});
  } catch (error) {
    console.error(error);
    sendError(res, 500, "unknown", "Internal server error occurred");
  }
});

app.use((_req, res) => {
  sendError(res, 404, "not_found", "Not found");
});

exports.api = onRequest(
    {
      region: "europe-west1",
      cors: true,
      invoker: "public",
      maxInstances: 2,
      timeoutSeconds: 60,
    },
    app,
);
