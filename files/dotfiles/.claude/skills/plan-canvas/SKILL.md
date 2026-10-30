---
name: plan-canvas
description: Open a plan or local .md/.html artifact in a browser canvas where the user annotates elements, chats, and approves or requests changes. Use when the user asks for /plan-canvas, a visual review, to annotate a plan, or "open it in the browser". Not for diff code review or remote URLs.
---

# Plan Canvas

Browser review loop for local plan files, driven by the `ecc-plan-canvas` CLI (npm `ecc-universal`, pinned, installed globally).
The user annotates elements and chats in the browser; you block on `await` and get their feedback as JSON.
The server listens on `127.0.0.1:4517` only, keyed by file path, and exits after 30 idle minutes.

## Workflow

1. Write the plan as a Markdown file in `~/.claude/plans/<slug>.md` (or use the file the user names).
   Use fenced `mermaid` blocks for flows or architecture; the canvas renders them.
1. Open it: `ecc-plan-canvas open <file>`.
1. Listen: run `ecc-plan-canvas await <file>` via Bash with `run_in_background: true`.
   It exits when feedback arrives and you are re-invoked with its JSON.
   Never end a turn without an `await` running while the review is open, or the user's messages go nowhere.
1. Handle the items:
   - `chat`: freeform message; answer it in the canvas.
   - `annotation`: feedback anchored to `anchor.snippet` / `anchor.selector` (`anchor.textRange.text` if they highlighted text).
   - `verdict: request-changes`: edit the plan file (the canvas live-reloads; never re-run `open`), then keep listening.
   - `verdict: approve`: the plan is confirmed; run `ecc-plan-canvas end <file>` and start implementing.
1. Reply and keep listening in one call (background again): `ecc-plan-canvas await <file> --reply "<short answer>"`.
   Reply to every user message in the canvas, even with "On it".
   For revisions over a minute, refresh `ecc-plan-canvas typing <file> --state thinking`.

`{"status":"ended","endedBy":"user"}` or `sessionEnded: true` means the user closed the review: stop listening, report in the terminal, don't reopen unless asked (`open --reopen`).
If unsure whether feedback was missed, run `ecc-plan-canvas pending`.

## Rules

- Keep the terminal summary to one line; the plan lives in the canvas.
- Don't poll with `--timeout-ms`; it exists for tests.
- Sibling assets (images, CSS) must sit next to the file, referenced by relative path.
