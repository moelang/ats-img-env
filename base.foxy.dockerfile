ARG FROM_IMAGE
FROM ${FROM_IMAGE}

ENV ROS_DISTRO=foxy
ENV PIP=pip3

RUN apt-get update && apt-get install -q -y --no-install-recommends \
    python3-pip \
    python3-setuptools \
    && rm -rf /var/lib/apt/lists/*

RUN echo "deb http://packages.ros.org/ros2/ubuntu focal main" > /etc/apt/sources.list.d/ros2-latest.list

RUN apt-get update && apt-get install -q -y --no-install-recommends \
    python3-rosdep \
    && rm -rf /var/lib/apt/lists/*