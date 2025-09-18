FROM alpine:latest

# Install required packages
RUN apk add --no-cache bash jq zip unzip shadow

# Create non-root user 'buildpiper'
RUN groupadd -g 65522 buildpiper && \
    useradd -u 65522 -g buildpiper -d /home/buildpiper -s /bin/bash buildpiper && \
    mkdir -p /home/buildpiper && \
    chown -R buildpiper:buildpiper /home/buildpiper

# Create required directories with correct ownership
RUN mkdir -p \
        /bp/workspace \
        /src \
        /opt/buildpiper/shell-functions \
        /home/buildpiper/reports && \
    chown -R buildpiper:buildpiper /src /bp /opt /home/buildpiper

# Copy scripts and shell functions
COPY --chown=buildpiper:buildpiper build.sh /home/buildpiper/build.sh
COPY --chown=buildpiper:buildpiper BP-BASE-SHELL-STEPS /opt/buildpiper/shell-functions/

# Environment variables
ENV SLEEP_DURATION=5s
ENV ACTIVITY_SUB_TASK_CODE=ZIP_STEP
ENV VALIDATION_FAILURE_ACTION=WARNING

# Set permissions
RUN chmod +x /home/buildpiper/build.sh

# Switch to non-root user
USER buildpiper

# Set working directory
WORKDIR /home/buildpiper

# Entrypoint
ENTRYPOINT ["./build.sh"]
