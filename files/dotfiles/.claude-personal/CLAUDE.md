# CLAUDE.md

## Authoring CLAUDE.md / AGENTS.md files

Applies whenever you create or update a repository's CLAUDE.md/AGENTS.md pair, whether via /init or manually.

* Make CLAUDE.md exactly this three-line stub, verbatim, nothing else:
  ```text
  # CLAUDE.md

  @AGENTS.md
  ```
* Put all real content in AGENTS.md instead.
* Respect an already-established different convention in a repo instead of forcing this one.
* Title AGENTS.md with a top-level heading matching its own filename: `# AGENTS.md`.
* Place a GitLab `[TOC]` macro directly below the H1, with a blank line above and below it.
* Write prose as one sentence per line (semantic linebreaks); never wrap mid-sentence.
* Never join two clauses in a sentence with an em dash.
  End the first clause as its own sentence with a period and start a new sentence instead.
  If the part after the dash is only a short qualifier rather than a full clause, use parentheses instead of a dash.
* In lists, use a colon between a term and its description instead of a dash.
* List items and code fences are otherwise unaffected by the one-sentence-per-line rule.
* Before finishing, verify the file is fully clean against `markdownlint -c ~/.markdownlintrc <file>`.
* Fix every finding markdownlint reports; the file must lint with zero output.
