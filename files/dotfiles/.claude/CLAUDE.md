# CLAUDE.md

@~/.claude-personal/CLAUDE.md

## Working preferences (work)

* Jira footers: every commit on a ticket branch gets `Resolves: <ISSUE-ID>` (closes the ticket) or `Refs: <ISSUE-ID>` (related only).
  GitLab's Jira integration links each commit individually, so repeat it on every commit.
* OpenTofu applies: I apply Tofu changes myself (MR pipeline or locally).
  You prepare, run `tofu plan` and open MRs.

@~/.claude/CLAUDE.private.md
