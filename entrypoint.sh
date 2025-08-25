#!/bin/bash
set -e

# Default values
VERBOSITY=${VERBOSITY:-0}
BECOME=${BECOME:-false}
CHECK=${CHECK:-false}

ARGS=""

[ "$EXTRA_VARS" != "" ] && ARGS="$ARGS --extra-vars \"$EXTRA_VARS\""
[ "$LIMIT" != "" ] && ARGS="$ARGS --limit $LIMIT"
[ "$TAGS" != "" ] && ARGS="$ARGS --tags $TAGS"
[ "$CHECK" == "true" ] && ARGS="$ARGS --check"
[ "$BECOME" == "true" ] && ARGS="$ARGS --become"

# Add verbosity
for ((i=0;i<VERBOSITY;i++)); do
    ARGS="$ARGS -v"
done

# Run playbook
exec ansible-playbook "$PLAYBOOK" -i "$INVENTORY" $ARGS
