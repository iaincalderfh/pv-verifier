#!/bin/bash

trap finish TERM INT

function finish {
  echo "Exiting with code 0"
  exit 0
}

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