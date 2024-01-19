#!/bin/bash

source functions.sh
source log-functions.sh
source str-functions.sh
source file-functions.sh
source aws-functions.sh

logInfoMessage "Scanning the code available at [$WORKSPACE] and mounted at [$CODEBASE_DIR]"
code="$WORKSPACE/$CODEBASE_DIR"
sleep $SLEEP_DURATION
cd  $code
logInfoMessage "Received arguments: [$@]"
scancode -cl --license --html $OUTPUT_ARG .

if [ $? -eq 0 ];
then
#if scancode -cl --license --html "$filename" .; then
  generateOutput scancode_execute false "License scan succeeded!"
  logInfoMessage "License scan succeeded!"
  echo "License scan succeeded!" 
else
  generateOutput scancode_execute false "License scan failed!"
  logErrorMessage "License scan failed!"
  echo "Build unsuccessful"
  exit 1
fi
