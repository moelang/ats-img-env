ARG FROM_IMAGE
FROM ${FROM_IMAGE}

ARG VER
ARG SHA

RUN echo ${VER} > /VER
RUN echo ${SHA} > /SHA

ARG REPO

LABEL org.opencontainers.image.source ${REPO}

ENV DEBIAN_FRONTEND=noninteractive

RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata && \
    rm -rf /var/lib/apt/lists/*

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

RUN apt-get update && apt-get install -q -y --no-install-recommends \
    dirmngr \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654