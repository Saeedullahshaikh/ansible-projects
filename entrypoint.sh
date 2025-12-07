#!/bin/bash
set -e

# Default values
VERBOSITY=${VERBOSITY:-0}
BECOME=${BECOME:-false}
CHECK=${CHECK:-false}

# Use array to avoid argument splitting issues
ARGS=()

[ -n "$EXTRA_VARS" ] && ARGS+=("--extra-vars" "$EXTRA_VARS")
[ -n "$LIMIT" ] && ARGS+=("--limit" "$LIMIT")
[ -n "$TAGS" ] && ARGS+=("--tags" "$TAGS")
[ "$CHECK" = "true" ] && ARGS+=("--check")
[ "$BECOME" = "true" ] && ARGS+=("--become")

# Add verbosity (-v, -vv, -vvv…)
for ((i=0;i<VERBOSITY;i++)); do
    ARGS+=("-v")
done

# Run playbook
exec ansible-playbook "$PLAYBOOK" -i "$INVENTORY" "${ARGS[@]}"

