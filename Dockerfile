FROM --platform=linux/amd64 python:3.8-slim-buster

# Python settings: Force unbuffered stdout and stderr (i.e. they are flushed to terminal immediately)
ENV PYTHONUNBUFFERED 1
# Python settings: do not write pyc files
ENV PYTHONDONTWRITEBYTECODE 1
# Install required system dependencies using apt-get
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        jq \
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
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ENV ACTIVITY_SUB_TASK_CODE BP-SCANCODE
# Create directory for scancode sources
WORKDIR /scancode-toolkit

# Copy sources into docker container
COPY . /scancode-toolkit

# Initial configuration using ./configure, scancode-reindex-licenses to build
# the base license index
RUN ./configure \
 && ./venv/bin/scancode-reindex-licenses

# Add scancode to path
ENV filename=somevalue.html
#ENV filename=/scancode-toolkit:$PATH
ENTRYPOINT ["./script.sh"]

