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
* Before finishing, run `markdownlint -c ~/.markdownlintrc <file>` and fix every finding until it prints nothing.

## Working preferences (all repos)

* Jira footers: every commit on a ticket branch gets `Resolves: <ISSUE-ID>` (closes the ticket) or `Refs: <ISSUE-ID>` (related only).
  GitLab's Jira integration links each commit individually, so repeat it on every commit.
* Refactor commits: if an implementation forces a real refactor, put it in its own commit before the feature commit.
* OpenTofu applies: I apply Tofu changes myself (MR pipeline or locally).
  You prepare, run `tofu plan` and open MRs.
* Empirical checks: verify infra assumptions by running things (`tofu plan`, provider schemas, a throwaway repro in a scratch dir) instead of only reasoning about them.
* Skill corrections: when a correction to skill output reveals a structural gap in the skill's template, also patch the SKILL.md in the same turn.
  Don't turn one-off editorial choices into rules.

@RTK.md
@CLAUDE.private.md
