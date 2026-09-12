FROM ubuntu:26.04 AS source

ADD --checksum=sha256:e4383c9d29725496aef7abdfeccd05d5d9e4a72725a41541690b97d91913ee01 https://updates.signal.org/desktop/apt/pool/s/signal-desktop/signal-desktop_8.27.0_amd64.deb /tmp/source

FROM ghcr.io/containerpak/gtk3:main

RUN --mount=type=bind,from=source,source=/tmp/source,target=/run/signal-desktop.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/signal-desktop.deb && \
    ln -sf /opt/Signal/signal-desktop /usr/bin/signal-desktop && \
    cpak-clean-junk
