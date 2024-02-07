FROM --platform=linux/amd64 python:3.8-slim-buster
ENV SLEEP_DURATION 5s
COPY script.sh .
ADD BP-BASE-SHELL-STEPS /opt/buildpiper/shell-functions/
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
       bzip2 \
       xz-utils \
       zlib1g \
       libxml2-dev \
       libxslt1-dev \
       libgomp1 \
       libsqlite3-0 \
       libgcrypt20 \
       libpopt0 \
       libzstd1 \
       jq \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 && pip install scancode-toolkit
ENV ACTIVITY_SUB_TASK_CODE SCANCODE_EXECUTE
ENV OUTPUT_ARG scancode.json
ENV FORMAT_ARG --yaml
ENTRYPOINT ["./script.sh"]
