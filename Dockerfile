FROM python:3.12-slim

RUN --mount=type=cache,target=/var/cache/apt <<EOF
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y \
  bind9-dnsutils
rm -rf /var/lib/apt/lists/*
EOF

WORKDIR /app
COPY . .

# For the account key, CSR, TSIG key, etc.
VOLUME ["/data"]

ENV KEYFILE=/data/my-tsig.key
# NSSERVER defaults to localhost, change it via environment if you want.

ENTRYPOINT ["/usr/local/bin/python3", "/app/acme_tiny.py"]
CMD ["--help"]
