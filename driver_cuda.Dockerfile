ARG IMG_CUDA="11.0.3"
ARG IMG_CUDNN="8"
ARG FROM_IMAGE_NAME=nvidia/cuda:${IMG_CUDA}-cudnn${IMG_CUDNN}-runtime-ubuntu18.04
FROM ${FROM_IMAGE_NAME}

# Can be '+cu92', '+cu101', '+cu110' or ''
ARG TORCH_CUDA_VER="+cu110"

RUN apt-get update && \
    apt-get install -y apt-utils python3 python3-pip cmake \
    libprotobuf-dev protobuf-compiler

ADD driver_cuda_requirements.txt .
RUN pip3 install -r driver_cuda_requirements.txt

# To generate image for CUDA v10.2 change below to 'RUN pip3 install torch torchvision torchaudio'
RUN pip3 install torch==1.7.1${TORCH_CUDA_VER} torchvision==0.8.2${TORCH_CUDA_VER} torchaudio==0.7.2 -f https://download.pytorch.org/whl/torch_stable.html

WORKDIR /code
ADD . .

ENTRYPOINT ["./bench/dlrm_s_criteo_kaggle.sh"]