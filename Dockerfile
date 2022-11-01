FROM continuumio/miniconda3:4.12.0

ARG CAMERATRAPS_SHA=0b310aa7aeb35d958285cdb1b172b1cc220ba0f7
ARG AI4EUTILS_SHA=9260e6b876fd40e9aecac31d38a86fe8ade52dfd
ARG YOLOV5_SHA=c23a441c9df7ca9b1f275e8c8719c949269160d1

# ARG YOLO_SHA=

RUN mkdir /workspace
WORKDIR /workspace

RUN apt-get update && apt-get install -y git

RUN mkdir /workspace
RUN git clone https://github.com/Microsoft/cameratraps /workspace/cameratraps && \
    cd /workspace/cameratraps && git checkout ${CAMERATRAPS_SHA}

RUN git clone https://github.com/Microsoft/ai4eutils /ai4eutils && \
    cd /workspace/cameratraps && git checkout ${AI4EUTILS_SHA}

RUN git clone https://github.com/ultralytics/yolov5/ /workspace/yolov5 && \
    cd /workspace/yolov5 && git checkout c23a441c9df7ca9b1f275e8c8719c949269160d1

RUN cd /workspace/cameratraps && conda env create --file environment-detector.yml
ENV PYTHONPATH="$PYTHONPATH:/workspace/cameratraps:/workspace/ai4eutils:/workspace/git/yolov5"

ADD build.sh /workspace/build.sh
# RUN conda activate cameratraps-detector