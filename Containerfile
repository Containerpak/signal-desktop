FROM ghcr.io/containerpak/gtk:main

ADD --checksum=sha256:1d92e0986a9b1895f43a1e2e726e85f69c627c621e1d090477b261b4e26ee870 https://updates.signal.org/desktop/apt/pool/s/signal-desktop/signal-desktop_8.22.0_amd64.deb /tmp/source

RUN apt-get update && \
    apt-get install -y --no-install-recommends libasound2t64 libgtk-3-0 libnss3 xdg-utils && \
    dpkg-deb -x /tmp/source / && ln -s /opt/Signal/signal-desktop /usr/bin/signal-desktop && \
    cpak-clean-junk
