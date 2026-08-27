FROM ubuntu:26.04 AS source

ADD --checksum=sha256:bb071ec2433305d5ed8ec6572b7aceb14b75bf2dd36b2b13b957d567e3f4124e https://updates.signal.org/desktop/apt/pool/s/signal-desktop/signal-desktop_8.25.0_amd64.deb /tmp/source

FROM ghcr.io/containerpak/gtk3:main

RUN --mount=type=bind,from=source,source=/tmp/source,target=/run/signal-desktop.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/signal-desktop.deb && \
    ln -sf /opt/Signal/signal-desktop /usr/bin/signal-desktop && \
    cpak-clean-junk
