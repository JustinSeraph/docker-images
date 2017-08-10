FROM ubuntu
MAINTAINER Justin
USER root
ENV DEBIAN_FRONTEND noninteractive

# Update the repository and install utils
RUN apt-get update && \
    apt-get install -y \
       apt-utils \
       gnupg \
       ca-certificates \
       net-tools \
       curl \
       wget \
       vim && \
    apt-get clean && \
    apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/*

CMD /bin/bash
