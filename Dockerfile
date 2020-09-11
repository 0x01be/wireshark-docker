FROM 0x01be/ninja as builder

RUN apk add --no-cache --virtual wireshark-build-dependencies \
    git \
    build-base \
    cmake \
    ccache \
    bison \
    perl \
    glib-dev \
    libgcrypt-dev \
    c-ares-dev \
    flex-dev \
    libpcap-dev \
    elogind-dev \
    python3-dev \
    qt5-qtbase-dev \
    qt5-qttools-dev \
    qt5-qtmultimedia-dev \
    qt5-qtbase-x11

RUN git clone --depth 1 https://gitlab.com/wireshark/wireshark.git /wireshark

WORKDIR /wireshark/build/

RUN cmake -G Ninja ..
RUN ninja

FROM 0x01be/xpra

COPY --from=builder /wireshark/build/run/ /opt/wireshark/

ENV PATH $PATH:/opt/wireshark/

USER root
RUN apk add --no-cache --virtual wireshark-runtime-dependencies \
    qt5-qtbase-x11 \
    qt5-qtmultimedia \
    libpcap \
    libgcrypt \
    c-ares \
    mesa-dri-swrast

USER xpra

WORKDIR /workspace

ENV COMMAND "wireshark"

