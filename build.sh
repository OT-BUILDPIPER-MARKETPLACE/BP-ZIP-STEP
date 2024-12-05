#!/bin/bash
source /opt/buildpiper/shell-functions/functions.sh
source /opt/buildpiper/shell-functions/log-functions.sh
source /opt/buildpiper/shell-functions/str-functions.sh
source /opt/buildpiper/shell-functions/file-functions.sh
source /opt/buildpiper/shell-functions/aws-functions.sh

CODEBASE_LOCATION="${WORKSPACE}"/"${CODEBASE_DIR}"
logInfoMessage "I'll do processing at [$CODEBASE_LOCATION]"
sleep  $SLEEP_DURATION
cd  "${WORKSPACE}"
TAG=$(tail -n 1 data.properties)
logInfoMessage "I'll zip the following [$CODEBASE_DIR]"
rm -rf "${CODEBASE_DIR}"/.git
logInfoMessage "Zip File: ${CODEBASE_DIR}-${TAG}.zip"
zip -qr "${CODEBASE_DIR}"-"${TAG}".zip "${CODEBASE_DIR}"

TASK_STATUS=$?
saveTaskStatus ${TASK_STATUS} ${ACTIVITY_SUB_TASK_CODE}