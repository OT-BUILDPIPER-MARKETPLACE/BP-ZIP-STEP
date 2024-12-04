#!/bin/bash
source /opt/buildpiper/shell-functions/functions.sh
source /opt/buildpiper/shell-functions/log-functions.sh
source /opt/buildpiper/shell-functions/str-functions.sh
source /opt/buildpiper/shell-functions/file-functions.sh
source /opt/buildpiper/shell-functions/aws-functions.sh

TAG=$(tail -n 1 data.properties)


CODEBASE_LOCATION="${WORKSPACE}"/"${CODEBASE_DIR}"
logInfoMessage "I'll do processing at [$CODEBASE_LOCATION]"
sleep  $SLEEP_DURATION
cd  "${WORKSPACE}"
logInfoMessage "I'll zip the following [$CODEBASE_DIR]"
rm -rf "${CODEBASE_DIR}"/.git
zip -r "${CODEBASE_DIR}"-"${TAG}".zip "${CODEBASE_DIR}"

TASK_STATUS=$?
saveTaskStatus ${TASK_STATUS} ${ACTIVITY_SUB_TASK_CODE}