FROM ubuntu:latest

RUN apt-get update \
    && apt-get install -y \
        python3 \
        bind9-dnsutils \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/app
WORKDIR /home/app
COPY . .

# For the account key, CSR, TSIG key, etc.
VOLUME ["/data"]

ENV KEYFILE=/data/my-tsig.key
# NSSERVER defaults to localhost, change it via environment if you want.

ENTRYPOINT ["/usr/bin/python3", "/home/app/acme_tiny.py"]
CMD ["--help"]
