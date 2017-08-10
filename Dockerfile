FROM ubuntu
MAINTAINER Justin
USER root
ENV DEBIAN_FRONTEND noninteractive

# Update the repository and install utils
RUN apt-get update && apt-get -y install apt-utils net-tools iputils-ping ca-certificates && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD /bin/bash
