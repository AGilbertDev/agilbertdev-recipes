#!/usr/bin/env bash
# PreToolUse(Bash) guard for personal repos.
#
# Blocks a `git commit` or `git push` made under an identity other than the
# expected personal one. It reads the tool-call JSON from stdin and only acts
# when the command looks like a commit or push. It fails open on anything it is
# unsure about, so it never blocks unrelated work. Exit 2 is what blocks the
# action and shows the message to Claude.
#
# Fork-friendly: override the expected identity with AGD_GIT_NAME and
# AGD_GIT_EMAIL.
set -uo pipefail

expected_email="${AGD_GIT_EMAIL:-alexandre.gilbert.dev@gmail.com}"
expected_name="${AGD_GIT_NAME:-AGilbertDev}"

input="$(cat)"

# Only guard commits and pushes. Everything else passes straight through.
case "$input" in
  *"git commit"* | *"git push"*) ;;
  *) exit 0 ;;
esac

email="$(git config user.email 2>/dev/null || true)"

# Unset identity is left to git and other guards. A matching identity is fine.
if [ -n "$email" ] && [ "$email" != "$expected_email" ]; then
  {
    echo "Blocked: git user.email is '$email', not the personal identity '$expected_email'."
    echo "This is a personal repo. Set the local identity, then retry:"
    echo "  git config user.name \"$expected_name\" && git config user.email \"$expected_email\""
  } >&2
  exit 2
fi

exit 0
