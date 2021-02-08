ARG FROM_IMAGE_NAME=nvidia/cuda:9.2-cudnn7-runtime-ubuntu18.04
FROM ${FROM_IMAGE_NAME}

RUN apt-get update && \
    apt-get install -y apt-utils python3 python3-pip cmake \
    libprotobuf-dev protobuf-compiler

ADD custome_requirements.txt .
RUN pip3 install -r custome_requirements.txt

RUN pip3 install torch==1.7.1+cu92 torchvision==0.8.2+cu92 torchaudio==0.7.2 -f https://download.pytorch.org/whl/torch_stable.html

WORKDIR /code
ADD . .

ENTRYPOINT ["./test/dlrm_s_test.sh"]