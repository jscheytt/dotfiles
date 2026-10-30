# CLAUDE.md

## Authoring AGENTS.md files

Applies whenever you create or update a repository's project instructions, whether via /init or manually.

* Put all project instructions in AGENTS.md.
* Don't create a CLAUDE.md: Claude Code reads AGENTS.md natively, and a CLAUDE.md in the repo would take precedence over it.
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

* Refactor commits: if an implementation forces a real refactor, put it in its own commit before the feature commit.
* Empirical checks: verify infra assumptions by running things (`tofu plan`, provider schemas, a throwaway repro in a scratch dir) instead of only reasoning about them.
* Skill corrections: when a correction to skill output reveals a structural gap in the skill's template, also patch the SKILL.md in the same turn.
  Don't turn one-off editorial choices into rules.

@~/.claude-personal/RTK.md
