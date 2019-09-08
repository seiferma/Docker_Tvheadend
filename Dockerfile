FROM alpine:latest

WORKDIR /home/tvh

RUN VERSION=4.2.8-r0 && \
    apk --no-cache add tvheadend=${VERSION} && \
    VERSION=

ENV RECORDINGS_VOLUME=/recordings
ENV CONFIG_VOLUME=/config

RUN USERNAME=tvh && \
    addgroup -g 2001 ${USERNAME} && \
    adduser -u 2001 -G ${USERNAME} -h . -s /bin/false -D ${USERNAME} && \
    chown -R ${USERNAME}:${USERNAME} . && \
    mkdir -p ${RECORDINGS_VOLUME} && \
    mkdir -p ${CONFIG_VOLUME} && \
    chown -R ${USERNAME}:${USERNAME} ${CONFIG_VOLUME} && \
    chown -R ${USERNAME}:${USERNAME} ${RECORDINGS_VOLUME} && \
    USERNAME=

USER tvh

VOLUME ["${RECORDINGS_VOLUME}", "${CONFIG_VOLUME}"]

EXPOSE 9981
EXPOSE 9982

COPY ["start.sh", "./"]
ENTRYPOINT ["./start.sh"]
