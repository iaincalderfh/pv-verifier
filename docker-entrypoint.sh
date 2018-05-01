#!/bin/bash

trap finish TERM INT
STORAGE_TEST_FOLDER="storage_tests"
function finish {
  echo "Exiting with code 0"
  exit 0
}

if [ ! -f "$STORAGE_PATH/$STORAGE_TEST_FOLDER" ]; then
  echo "Creating folder for storage test $STORAGE_PATH/$STORAGE_TEST_FOLDER"
  mkdir -p "$STORAGE_PATH/$STORAGE_TEST_FOLDER"
fi

STORAGE_PATH="$STORAGE_PATH/$STORAGE_TEST_FOLDER"

if [ "$(ls -A $STORAGE_PATH)" ]; then
  # STORAGE_PATH is not empty, we expect to find it contains $TEST_FILE_NAME
  if [ ! -f "$STORAGE_PATH/$TEST_FILE_NAME" ]; then
    >&2 echo "Storage path is not empty and does not contain expected test file $TEST_FILE_NAME"
    ls "$STORAGE_PATH"
    exit 1
  else
    echo "Found expected test file $TEST_FILE_NAME"
    sleep infinity & wait
  fi
else
  # STORAGE_PATH is empty
  echo "Storage path is empty.  Creating test file $TEST_FILE_NAME"
  touch "$STORAGE_PATH/$TEST_FILE_NAME"
  sleep infinity & wait
fi