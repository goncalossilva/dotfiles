## Skills

- Use the `oracle` skill whenever you need a review, a second opinion, or you're stuck.
- Use the `browser-tools` skill whenever you need to interact with web pages or automate browser actions.

## Tools

- Use `gh` to access GitHub issues, pull requests, etc.

## Git

### Atomic commits

- Keep commits small, focused, and atomic.
- Avoid commits that mix unrelated changes (e.g., "Address feedback")
- When appropriate, such as when working on a branch whose changes are not upstream yet, or when working on a PR that is still in draft, prefer fixup and rebase of prior commmits to keep history clean.

### Clear, succint messages

If you're asked to commit changes or propose commit messages, follow best practices:

1. Write a short subject line
  - Up to 50 chars
  - Start subject with a capital letter, don't end with a period, use imperative mood (e.g. "Fix memory leak while scrolling widget")
  - If the project uses conventional commits, use them too
2. Leave a blank line between subject and body
3. Only when needed (don't force it for trivial changes), write a body
  - Wrap lines at 72 chars
  - Focus on why and what, not the how
    - Explain the motivation
    - Mention side effects, trade-offs, or alternatives considered
    - Reference relevant issue IDs / tickets at the bottom if you know them
