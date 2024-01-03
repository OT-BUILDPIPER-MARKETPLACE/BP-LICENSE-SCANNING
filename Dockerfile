FROM --platform=linux/amd64 python:3.8-slim-buster
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
RUN apt-get update \
 && apt-get install git -y \
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
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /scancode-toolkit

COPY . /scancode-toolkit

RUN ./configure \
 && ./venv/bin/scancode-reindex-licenses

ENV PATH=/scancode-toolkit:$PATH


ENTRYPOINT ["./scancode"]
