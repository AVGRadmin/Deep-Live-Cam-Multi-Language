FROM nvidia/cuda:12.2.2-cudnn8-runtime-ubuntu22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/cuda/lib:$LD_LIBRARY_PATH
ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH=/app

RUN apt-get update && \
    apt-get install -y \
    python3.10 \
    python3.10-venv \
    python3.10-dev \
    python3-pip \
    build-essential \
    cmake \
    ffmpeg \
    git \
    libglib2.0-0 \
    libgl1-mesa-glx \
    libgl1-mesa-dri \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgomp1 \
    python3-tk \
    curl \
    libcufft10 && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip

COPY app/requirements_linux.txt /app/requirements.txt

RUN pip install --no-cache-dir -r /app/requirements.txt

RUN chmod -R +x /app

WORKDIR /app


ENTRYPOINT ["/bin/bash", "docker_script.sh"]
