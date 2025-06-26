#!/bin/bash

# Script to update WFCore.xctestplan based on changed files in WFCore or WFCommon targets
# Usage: ./update-xctestplan.sh [commit1] [commit2]
# If no commits are provided, compares working tree to origin/main

if ! command -v jq > /dev/null; then
    echo "Error: jq is not installed. Please install jq to use this script."
    exit 1
fi

XCTESTPLAN_FILE="WFCore.xctestplan"
CORE_DIR="Sources/WFCore/"
COMMON_DIR="Sources/WFCommon/"

# Get list of changed files
git fetch myOrigin selectiveTesting > /dev/null 2>&1
if [ $# -eq 2 ]; then
    CHANGED_FILES=$(git diff --name-only "$1" "$2")
else
    CHANGED_FILES=$(git diff --name-only myOrigin/selectiveTesting)
fi

CORE_CHANGED=false
COMMON_CHANGED=false

for file in $CHANGED_FILES; do
    if [[ "$file" == $CORE_DIR* ]]; then
        CORE_CHANGED=true
    fi
    if [[ "$file" == $COMMON_DIR* ]]; then
        COMMON_CHANGED=true
    fi
    # Early exit if both are true
    if $CORE_CHANGED && $COMMON_CHANGED; then
        break
    fi
done

# Prepare new testTargets array based on changes
if $CORE_CHANGED && $COMMON_CHANGED; then
    JQ_TEST_TARGETS='[
      {"target": {"containerPath": "container:", "identifier": "WFCommonTests", "name": "WFCommonTests"}},
      {"target": {"containerPath": "container:", "identifier": "WFCoreTests", "name": "WFCoreTests"}}
    ]'
elif $COMMON_CHANGED; then
    JQ_TEST_TARGETS='[
      {"target": {"containerPath": "container:", "identifier": "WFCommonTests", "name": "WFCommonTests"}}
    ]'
elif $CORE_CHANGED; then
    JQ_TEST_TARGETS='[
      {"target": {"containerPath": "container:", "identifier": "WFCoreTests", "name": "WFCoreTests"}}
    ]'
else
    # No relevant changes; keep both
    JQ_TEST_TARGETS='[
      {"target": {"containerPath": "container:", "identifier": "WFCommonTests", "name": "WFCommonTests"}},
      {"target": {"containerPath": "container:", "identifier": "WFCoreTests", "name": "WFCoreTests"}}
    ]'
fi

# Use jq to update the testTargets array
jq --argjson targets "$JQ_TEST_TARGETS" '.testTargets = $targets' "$XCTESTPLAN_FILE" > "$XCTESTPLAN_FILE.tmp" && mv "$XCTESTPLAN_FILE.tmp" "$XCTESTPLAN_FILE"

echo "Updated $XCTESTPLAN_FILE with test targets:"
echo "$JQ_TEST_TARGETS"
