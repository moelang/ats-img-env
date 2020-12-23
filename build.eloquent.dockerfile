ARG FROM_SRC_IMAGE
ARG FROM_IMAGE

FROM ${FROM_SRC_IMAGE} as src
FROM ${FROM_IMAGE} as tmp

COPY --from=src /AutowareArchitectureProposal /AutowareArchitectureProposal

WORKDIR /AutowareArchitectureProposal

RUN rosdep install --simulate --reinstall --ignore-src -y --from-paths src --skip-keys "\
    livox_ros2_driver \
    octomap_msgs \
    osqp_vendor \
    rosbag2_cpp \
    rosidl_runtime_cpp \
    ublox_gps \
    ublox_msgs \
    "| sort > ros-deps && cat ros-deps

FROM ${FROM_IMAGE}

COPY --from=tmp /AutowareArchitectureProposal/ros-deps /tmp/ros-deps

RUN if [ $(dpkg --print-architecture) = amd64 ]; \
    then apt-get update \
    && apt-get install -q -y --no-install-recommends \
    cuda-nvrtc-dev-11-1=11.1.105-1 \
    libcublas-dev-11-1=11.3.0.106-1 \
    libcudnn8-dev=8.0.5.39-1+cuda11.1 \
    libnvinfer-dev=7.2.1-1+cuda11.1 \
    libnvinfer-plugin-dev=7.2.1-1+cuda11.1 \
    libnvonnxparsers-dev=7.2.1-1+cuda11.1 \
    libnvparsers-dev=7.2.1-1+cuda11.1 \
    && rm -rf /var/lib/apt/lists/*; fi