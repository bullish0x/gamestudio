#!/usr/bin/env bash
# SessionStart hook: if the session is on a 1M-context model variant, inject a
# one-time advisory so Claude can flag it to the user. Context-heavy skills
# (/reverse-document, /adopt, /review-all-gdds) can hit the 1M usage-credit gate.
#
# Only SessionStart hooks receive the `model` field, so this fires once per
# session (not on mid-session /model switches). Fails silently if jq is absent.

input=$(cat 2>/dev/null)

model=""
if command -v jq >/dev/null 2>&1; then
  model=$(printf '%s' "$input" | jq -r '.model // empty' 2>/dev/null)
else
  model=$(printf '%s' "$input" \
    | grep -oE '"model"[[:space:]]*:[[:space:]]*"[^"]*"' \
    | head -1 \
    | sed -E 's/.*:[[:space:]]*"([^"]*)".*/\1/')
fi

case "$model" in
  *"[1m]"*|*-1m|*1m]*)
    msg="HEADS-UP FOR THE USER: this session is on a 1M-context model (${model}). Context-heavy GameStudio skills like /reverse-document, /adopt, and /review-all-gdds can trip the '1M context usage credits required' error. If that happens, tell the user to run /model and pick a standard-context model (no [1m]) — or /usage-credits to enable 1M. Surface this once at the start of the session."
    # msg contains no double-quotes or newlines, so direct JSON embedding is safe.
    printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"%s"}}\n' "$msg"
    ;;
  *)
    : # standard context (or unknown) — stay silent
    ;;
esac

exit 0
