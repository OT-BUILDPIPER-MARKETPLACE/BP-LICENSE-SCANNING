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

#logInfoMessage "Received arguments: [$@]"
# Perform license scanning using scancode

scancode -cl --license --html $filename .
# scancode -cl --license --html /path/to/port_name.html .
if [ $? -eq 0 ]
then
# Check the exit status of scancode
#if scancode -cl --license --html "$filename" .; then
  generateOutput scancode_execute true "License scan succeeded!"
  logInfoMessage "License scan succeeded!"
  echo "License scan succeeded!" 
elif
then
  generateOutput scancode_execute false "License scan failed!"
  logErrorMessage "License scan failed!"
  echo "Build unsuccessful"
  exit 1
fi
