FROM python:3.10-slim

ARG YOLOV5_REF=v7.0
ARG TORCH_VERSION=2.2.2
ARG TORCHVISION_VERSION=0.17.2

RUN mkdir -p /home/workspace
WORKDIR /home/workspace

RUN apt-get update && \
    apt-get install -y --no-install-recommends git libgl1 libglib2.0-0 && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/ultralytics/yolov5 /home/workspace/yolov5 && \
    cd /home/workspace/yolov5 && git checkout "${YOLOV5_REF}"

RUN python -m pip install --no-cache-dir --upgrade pip && \
    python -m pip install --no-cache-dir \
        --index-url https://download.pytorch.org/whl/cpu \
        "torch==${TORCH_VERSION}+cpu" \
        "torchvision==${TORCHVISION_VERSION}+cpu" && \
    python -m pip install --no-cache-dir \
        "numpy<1.24" \
        "Pillow<10" \
        "matplotlib>=3.2.2" \
        "opencv-python-headless>=4.1.1,<4.10" \
        "pandas>=1.1.4" \
        "PyYAML>=5.3.1" \
        "requests>=2.23.0" \
        "scipy>=1.4.1" \
        "seaborn>=0.11.0" \
        "tensorboard>=2.4.1" \
        "ipython" \
        "dill" \
        "tqdm>=4.41.0" \
        "protobuf<=3.20.1" \
        "psutil" \
        "thop" \
        "onnx==1.12.0"

ENV PYTHONPATH="/home/workspace/yolov5"

CMD ["python", "/home/workspace/yolov5/export.py"]
