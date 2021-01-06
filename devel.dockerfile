ARG FROM_IMAGE
FROM ${FROM_IMAGE}

RUN apt-get update && apt-get install -q -y --no-install-recommends \
    nano \
    openssh-client \
    proxychains4 \
    ros-${ROS_DISTRO}-desktop \
    && rm -rf /var/lib/apt/lists/*