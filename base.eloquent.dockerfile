ARG FROM_IMAGE
FROM ${FROM_IMAGE}

ENV ROS_DISTRO=eloquent
ENV PIP=pip

RUN apt-get update && apt-get install -q -y --no-install-recommends \
    python-pip \
    python-setuptools \
    && rm -rf /var/lib/apt/lists/*

RUN echo "deb http://packages.ros.org/ros2/ubuntu bionic main" > /etc/apt/sources.list.d/ros2-latest.list

RUN apt-get update && apt-get install -q -y --no-install-recommends \
    python-rosdep \
    && rm -rf /var/lib/apt/lists/*