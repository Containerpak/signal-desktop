FROM ubuntu:26.04 AS source

ADD --checksum=sha256:1d92e0986a9b1895f43a1e2e726e85f69c627c621e1d090477b261b4e26ee870 https://updates.signal.org/desktop/apt/pool/s/signal-desktop/signal-desktop_8.22.0_amd64.deb /tmp/source

FROM ghcr.io/containerpak/gtk3:main

RUN --mount=type=bind,from=source,source=/tmp/source,target=/run/signal-desktop.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/signal-desktop.deb && \
    ln -sf /opt/Signal/signal-desktop /usr/bin/signal-desktop && \
    cpak-clean-junk
