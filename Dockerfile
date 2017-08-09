FROM justinxu/docker-images:ubuntu-java
MAINTAINER Justin
USER root

ENV HADOOP_VERSION 2.8.1
ENV HADOOP_DIR hadoop-${HADOOP_VERSION}
ENV HADOOP_HOME /usr/local/hadoop/${HADOOP_DIR}
ENV HADOOP_WEB_PATH http://www-us.apache.org/dist/hadoop/common/hadoop-"${HADOOP_VERSION}"/hadoop-"${HADOOP_VERSION}".tar.gz

RUN wget "${HADOOP_WEB_PATH}" && \
    tar xzvf hadoop-"${HADOOP_VERSION}".tar.gz -C /tmp && \
    mkdir -p /usr/local/hadoop && mv /tmp/"${HADOOP_DIR}" "${HADOOP_HOME}" && \
    rm -rf hadoop-"${HADOOP_VERSION}".tar.gz && \
    sed -i 's#^.*export JAVA_HOME.*$#export JAVA_HOME='"$JAVA_HOME"'#' ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh && \
    apt-get autoclean && apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD /bin/bash
