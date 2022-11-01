FROM mambaorg/micromamba:0.27.0

ARG CAMERATRAPS_SHA=0b310aa7aeb35d958285cdb1b172b1cc220ba0f7
ARG AI4EUTILS_SHA=9260e6b876fd40e9aecac31d38a86fe8ade52dfd
ARG YOLOV5_SHA=c23a441c9df7ca9b1f275e8c8719c949269160d1

RUN mkdir -p /home/workspace
WORKDIR /home/workspace

USER root

RUN apt-get update && \
    apt-get install -y git libgl1

USER mambauser

RUN git clone https://github.com/Microsoft/cameratraps /home/workspace/cameratraps && \
    cd /home/workspace/cameratraps && git checkout ${CAMERATRAPS_SHA}

RUN git clone https://github.com/Microsoft/ai4eutils /home/workspace/ai4eutils && \
    cd /home/workspace/ai4eutils && git checkout ${AI4EUTILS_SHA}

RUN git clone https://github.com/ultralytics/yolov5/ /home/workspace/yolov5 && \
    cd /home/workspace/yolov5 && git checkout ${YOLOV5_SHA}

RUN micromamba install -y -n base -f /home/workspace/cameratraps/environment-detector.yml && \
    micromamba install -y -n base -c conda-forge onnx=1.12.0 && \
    micromamba clean --all --yes

ENV PYTHONPATH="$PYTHONPATH:/home/workspace/cameratraps:/home/workspace/ai4eutils:/home/workspace/git/yolov5"

CMD ["python", "-m", "yolov5.export"]