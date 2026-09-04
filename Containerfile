FROM ubuntu:26.04 AS source

ADD --checksum=sha256:5265d3e3090a9785393c7547f8d720658d04ee717efb5810e01de2221b032b3d https://updates.signal.org/desktop/apt/pool/s/signal-desktop/signal-desktop_8.26.0_amd64.deb /tmp/source

FROM ghcr.io/containerpak/gtk3:main

RUN --mount=type=bind,from=source,source=/tmp/source,target=/run/signal-desktop.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/signal-desktop.deb && \
    ln -sf /opt/Signal/signal-desktop /usr/bin/signal-desktop && \
    cpak-clean-junk
