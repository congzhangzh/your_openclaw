FROM debian:trixie
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    # Core
    curl \
    git \
    ca-certificates \
    sudo \
    # Tini — a proper init for containers (see README for why this matters)
    tini \
    # Network diagnostics
    iproute2 \
    net-tools \
    iputils-ping \
    # Monitoring (because you WILL want to watch your AI think)
    btop \
    nload \
    iftop \
    procps \
    docker.io \
    screen
#    && rm -rf /var/lib/apt/lists/*

ENV NVM_VERSION=v0.40.3
ENV NODE_VERSION=24.13.1
ENV NVM_DIR=/root/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash \
    && bash -c "source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION"
ENV PATH=/root/.nvm/versions/node/v$NODE_VERSION/bin:$PATH
RUN npm install -g openclaw@latest

ENV PS1='openclaw:\w\$ '
EXPOSE 18789
VOLUME ["/root/.openclaw"]
ENTRYPOINT ["tini", "--"]
CMD ["/bin/bash"]
