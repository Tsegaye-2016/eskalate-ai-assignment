# AI Software Engineer Assignment (TypeScript)

## Overview

This project implements a simple HTTP client in TypeScript with OAuth2 support and a test suite using Vitest.

The repository includes:

- `src/` – Application source code
- `tests/` – Test suite
- `Dockerfile` – Docker configuration to run tests in an isolated environment
- `Explanation.md` – Bug explanation and fix description
- `.gitignore` – Git ignore rules
- `package.json` – Dependencies with pinned versions (no ^ or ~)

Lockfiles are intentionally not committed, as required.

---

## Requirements

- Node.js 20.5.1
- npm

---

## Install Dependencies

```bash
npm install
```

---

## Run Tests Locally

```bash
npm test
```

This runs the test suite using Vitest.

---

## Run Tests in Watch Mode (Optional)

```bash
npm run test:watch
```

---

## Build and Run Tests with Docker

Make sure you are in the project root directory (where the Dockerfile exists).

### 1. Build Docker Image

```bash
docker build -t ai-assignment .
```

### 2. Run Tests Inside Docker

```bash
docker run --rm ai-assignment
```

Docker will install dependencies and run the test suite inside a clean container.

---

## Notes

- All dependency versions are pinned in `package.json`.
- No lockfiles are committed.
- The Docker image uses Node 20.5.1.
- Tests pass both locally and inside Docker.

---

## Author

Tsegaye
