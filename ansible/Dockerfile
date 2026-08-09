FROM ubuntu:24.04


ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update \
  && apt-get install -y ansible sudo

RUN useradd -m -s /bin/bash lkmliz \
  && echo "lkmliz ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers


USER lkmliz

WORKDIR /home/lkmliz
