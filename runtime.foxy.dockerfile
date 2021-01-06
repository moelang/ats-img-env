ARG FROM_IMAGE
FROM ${FROM_IMAGE}

RUN echo 'deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64 /' > \
    /etc/apt/sources.list.d/nvidia-ml.list

ENV TENSORRT_VERSION=7.2.1-1+cuda11.1
ENV CUDNN_VERSION=8.0.5.39-1+cuda11.1

RUN if [ $(dpkg --print-architecture) = amd64 ]; then \
    apt-get update \
    && apt-get install -q -y --no-install-recommends \
    cuda-nvrtc-11-1 \
    libcublas-11-1 \
    libcudnn8=$CUDNN_VERSION \
    libnvinfer-plugin7=$TENSORRT_VERSION \
    libnvinfer7=$TENSORRT_VERSION \
    libnvonnxparsers7=$TENSORRT_VERSION \
    libnvparsers7=$TENSORRT_VERSION \
    && rm -rf /var/lib/apt/lists/*; fi