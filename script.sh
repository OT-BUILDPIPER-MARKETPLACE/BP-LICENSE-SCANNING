#!/bin/bash
source /opt/buildpiper/shell-functions/functions.sh
source /opt/buildpiper/shell-functions/log-functions.sh
CODEBASE_LOCATION="${WORKSPACE}"/"${CODEBASE_DIR}"
logInfoMessage "I'll do processing at [$CODEBASE_LOCATION]"
cd "${CODEBASE_LOCATION}"
if [ -d "reports" ]; then
    true
else
    mkdir reports
fi
STATUS=0

logInfoMessage "Scanning the code available at ${WORKSPACE}/${CODEBASE_DIR} "
sleep  "$SLEEP_DURATION"
logInfoMessage "Executing command"
logInfoMessage "scancode -q ${FORMAT_ARG} - --license ${WORKSPACE}/${CODEBASE_DIR}"
scancode -q ${FORMAT_ARG} - --license "${WORKSPACE}"/"${CODEBASE_DIR}"

logInfoMessage "scancode -cl -q --license --json reports/${OUTPUT_ARG} ${WORKSPACE}/${CODEBASE_DIR}"
scancode -cl -q --license --json reports/"${OUTPUT_ARG}" "${WORKSPACE}"/"${CODEBASE_DIR}"
TASK_STATUS=$(echo $?)

saveTaskStatus ${TASK_STATUS} ${ACTIVITY_SUB_TASK_CODE}
