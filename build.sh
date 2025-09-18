#!/bin/bash
source /opt/buildpiper/shell-functions/functions.sh
source /opt/buildpiper/shell-functions/log-functions.sh
source /opt/buildpiper/shell-functions/file-functions.sh
source /opt/buildpiper/shell-functions/aws-functions.sh


CODEBASE_LOCATION="${WORKSPACE}"/"${CODEBASE_DIR}"
logInfoMessage "I'll do processing at [$CODEBASE_LOCATION]"
sleep  $SLEEP_DURATION
cd  "${CODEBASE_LOCATION}"



BASE_DIR=$(dirname "${SOURCE_DIR_PATH}")

# Check if SOURCE_DIR_PATH ends with '/*' (zip contents)
if [[ "${SOURCE_DIR_PATH}" == */\* ]]; then
  BASE_DIR=$(dirname "${SOURCE_DIR_PATH}")
else
  BASE_DIR=$SOURCE_DIR_PATH
fi
logInfoMessage "I'll zip the following [$SOURCE_DIR_PATH]"
cd "$BASE_DIR" || { logErrorMessage "Failed to cd into $BASE_DIR"; exit 1; }
ls
logInfoMessage "zip -r ${ZIP_NAME}-${V3_EXECUTION_ID}.zip ."
zip -r "zip -r ${ZIP_NAME}-${V3_EXECUTION_ID}.zip ." .
TASK_STATUS=$?

saveTaskStatus ${TASK_STATUS} ${ACTIVITY_SUB_TASK_CODE}