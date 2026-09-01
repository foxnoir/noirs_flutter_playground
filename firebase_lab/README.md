<a name="readme-top"></a>

<!-- Top Links Bar -->

[![LinkedIn](../assets/badges/linkedin.svg)](https://www.linkedin.com/in/tanja-polz-5636401a5/)
[![X](../assets/badges/x.svg)](https://twitter.com/_foxnoir_?lang=de)
[![Instagram](../assets/badges/instagram.svg)](https://www.instagram.com/codeincouture/)

<!-- PROJECT LOGO -->
<br />

<div align="center">
  <img src="../assets/logo.png" alt="Logo" width="179" height="179">
  <h1 align="center">Firebase Lab</h1>
  <p>
     Own Firebase backend for practicing API services — Cloud Functions HTTP + Firestore.
  </p>
</div>

---

<div align="left">

[![Firebase](../assets/badges/firebase.svg)](https://firebase.google.com/)
[![Dart](../assets/badges/dart.svg)](https://dart.dev/)
[![Flutter](../assets/badges/flutter.svg)](https://flutter.dev/)

</div>

---

## About

This is **your** practice backend in [Noir's Flutter Playground](../README.md). Not a Flutter app. Point a `remote_service` at it and map HTTP errors to `AppException`.

- **Firestore** collection `notes`
- **HTTP API** (`GET` / `POST` / `PATCH` / `DELETE`) in Cloud Functions, region `europe-west1`
- **Emulators** so you can practice without creating a cloud project first

Open Firestore rules are on purpose (no Auth). Practice only.

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Run

Needs Node, Java (Firestore emulator). `./start.sh` installs the Firebase CLI locally.

```
./start.sh
```

| | |
| --- | --- |
| API | `http://127.0.0.1:5001/noirs-firebase-lab/europe-west1/api` |
| Emulator UI | `http://127.0.0.1:4000` |

iOS Simulator and Chrome can use that API URL as-is.

Smoke the API:

```
./examples/curl.sh
```

The first `GET /notes` writes three seed notes if the collection is empty. `POST /seed` wipes and reseeds.

<p align="right"><a href="#readme-top">back to top</a></p>

---

## API

Base path is `/` on the function named `api`.

| Method | Path | Status | Body |
| --- | --- | --- | --- |
| `GET` | `/health` | 200 | `{ "ok": true }` |
| `GET` | `/notes` | 200 | `[Note]` |
| `GET` | `/notes/:id` | 200 / 404 | `Note` |
| `POST` | `/notes` | 201 / 400 | `{ "title": "…", "body": "…" }` → `Note` |
| `PATCH` | `/notes/:id` | 200 / 400 / 404 | partial `title` / `body` |
| `DELETE` | `/notes/:id` | 204 / 404 | empty |
| `POST` | `/seed` | 204 | empty |

`Note`:

```json
{
  "id": "abc",
  "title": "GET list",
  "body": "Practice fetchNotes() against GET /notes.",
  "createdAt": "2026-09-01T10:00:00.000Z",
  "updatedAt": "2026-09-01T10:00:00.000Z"
}
```

Errors:

```json
{ "code": "not_found" }
{ "code": "validation", "details": "title is required" }
{ "code": "unknown" }
```

Map `not_found` → `NotFoundException`, everything else → `NetworkException` (or a validation case if you add one).

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Deploy (optional)

Local emulators are enough for API practice. Cloud deploy needs a Google login and **Blaze** (pay-as-you-go; this lab stays inside the free quota).

```
./deploy.sh
```

If `noirs-firebase-lab` is taken:

```
FIREBASE_PROJECT_ID=noirs-lab-yourname ./deploy.sh
```

After deploy the base URL is:

`https://europe-west1-<project-id>.cloudfunctions.net/api`

<p align="right"><a href="#readme-top">back to top</a></p>
