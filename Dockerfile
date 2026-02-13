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
    docker.io
    # docker.io \
    # && rm -rf /var/lib/apt/lists/*
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh

ENV NODE_VERSION=24.13.1    
RUN nvm install $NODE_VERSION
ENV PATH=/root/.nvm/versions/node/$NODE_VERSION/bin:$PATH 
RUN npm install -g openclaw@latest

EXPOSE 18789
VOLUME ["/root/.openclaw"]
ENTRYPOINT ["tini"]
CMD ["--", "/entrypoint.sh"]
