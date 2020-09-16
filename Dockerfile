FROM 0x01be/wireshark:build as build

FROM 0x01be/xpra

COPY --from=build /wireshark/build/run/ /opt/wireshark/

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

