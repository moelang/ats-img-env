ARG FROM_SRC_IMAGE
ARG FROM_IMAGE

FROM ${FROM_SRC_IMAGE} as src
FROM ${FROM_IMAGE} as tmp

COPY --from=src /AutowareArchitectureProposal /AutowareArchitectureProposal

WORKDIR /AutowareArchitectureProposal

RUN rosdep install --simulate --reinstall --ignore-src -y --from-paths src | \
    sort > ros-deps && cat ros-deps

FROM ${FROM_IMAGE}

COPY --from=tmp /AutowareArchitectureProposal/ros-deps /tmp/ros-deps

RUN if [ $(dpkg --print-architecture) = amd64 ]; \
    then apt-get update \
    && apt-get install -q -y --no-install-recommends \
    cuda-nvrtc-dev-11-1 \
    libcublas-dev-11-1 \
    libcudnn8-dev=$CUDNN_VERSION \
    libnvinfer-dev=$TENSORRT_VERSION \
    libnvinfer-plugin-dev=$TENSORRT_VERSION \
    libnvonnxparsers-dev=$TENSORRT_VERSION \
    libnvparsers-dev=$TENSORRT_VERSION \
    && rm -rf /var/lib/apt/lists/*; fi