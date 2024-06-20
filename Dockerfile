FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN --mount=type=cache,target=/var/cache/apt \
    apt-get update \
    && apt-get install -y \
        bind9-dnsutils \
        python3 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

# For the account key, CSR, TSIG key, etc.
VOLUME ["/data"]

ENV KEYFILE=/data/my-tsig.key
# NSSERVER defaults to localhost, change it via environment if you want.

ENTRYPOINT ["/usr/bin/python3", "/app/acme_tiny.py"]
CMD ["--help"]
