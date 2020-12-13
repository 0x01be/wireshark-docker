FROM 0x01be/wireshark:build as build

FROM 0x01be/xpra

COPY --from=build /wireshark/build/run/ /opt/wireshark/

RUN apk add --no-cache --virtual wireshark-runtime-dependencies \
    qt5-qtbase-x11 \
    qt5-qtmultimedia \
    libpcap \
    libgcrypt \
    c-ares \
    mesa-dri-swrast

USER ${USER}
WORKDIR ${WORKSPACE}
ENV PAT= ${PATH}:/opt/wireshark/ \
    COMMAND=wireshark

