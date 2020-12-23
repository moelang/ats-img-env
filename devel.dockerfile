ARG FROM_IMAGE
FROM ${FROM_IMAGE}

RUN apt-get update && apt-get install -q -y --no-install-recommends \
    git \
    nano \
    net-tools \
    openssh-client \
    proxychains4 \
    && rm -rf /var/lib/apt/lists/*