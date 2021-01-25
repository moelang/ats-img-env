ARG FROM_IMAGE
FROM ${FROM_IMAGE}

RUN apt-get update && apt-get install -q -y --no-install-recommends \
    build-essential \
    geographiclib-tools \
    git \
    maven \
    openjdk-8-jdk-headless \
    python3-colcon-common-extensions \
    python3-colcon-mixin \
    python3-pip \
    python3-vcstool \
    && rm -rf /var/lib/apt/lists/*

RUN $PIP install wheel gdown future

RUN geographiclib-get-geoids egm2008-1

RUN git clone -b v2.3.0 --depth 1 --recursive https://github.com/Livox-SDK/Livox-SDK.git /livox_sdk \
    && mkdir -p /livox_sdk/build \
    && cd /livox_sdk/build \
    && cmake .. \
    && make install \
    && rm -rf /livox_sdk

RUN apt-get update \
    && cat /tmp/ros-deps \
    && sh /tmp/ros-deps \
    && rm -rf /var/lib/apt/lists/*

RUN ${PIP} install gdown

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain nightly

RUN git clone -b ros2 --depth 1 --recursive https://github.com/moelang/cyclocut.git /cyclocut \
    && mkdir -p /cyclocut/build \
    && cd /cyclocut/build \
    && cmake .. \
    && make install \
    && rm -rf /cyclocut

RUN git clone -b foxy --depth 1 --recursive https://github.com/moelang/zenoh-plugin-dds.git /zenoh-plugin-dds
    # && cd /zenoh-plugin-dds \
    # && rustup install nightly \
    # && cargo +nightly install --release --all-targets --path .