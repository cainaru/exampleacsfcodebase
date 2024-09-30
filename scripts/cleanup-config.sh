#!/usr/bin/env bash

# Ensure the script exits if any command fails.
set -eo pipefail

# Check if the directory argument is provided.
if [ -z "$1" ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

# Use the provided directory.
TARGET_DIR="$1"

# Ensure the target directory is absolute.
if [[ ! "$TARGET_DIR" = /* ]]; then
  TARGET_DIR="$(pwd)/$TARGET_DIR"
fi

echo -e "**********************"
echo -e "*   Cleanup Config   *"
echo -e "**********************"
echo -e "Cleaning up configuration in: ${TARGET_DIR}\n"

# Determine the `sed` syntax based on OS.
if [[ "$OSTYPE" == "darwin"* ]]; then
  find "${TARGET_DIR}" -type f -name "*.yml" -exec sed -i '' '/^uuid: /d' {} \;
  find "${TARGET_DIR}" -type f -name "*.yml" -exec sed -i '' '/_core:/{N;d;}' {} \;
else
  find "${TARGET_DIR}" -type f -name "*.yml" -exec sed -i '/^uuid: /d' {} \;
  find "${TARGET_DIR}" -type f -name "*.yml" -exec sed -i '/_core:/,+1d' {} \;
fi

echo -e "********************************"
echo -e "*    Config cleanup complete   *"
echo -e "********************************"
