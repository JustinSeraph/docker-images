FROM justinxu/java

MAINTAINER Justin

ENV HADOOP_VERSION 2.8.1
ENV HADOOP_DIR hadoop-${HADOOP_VERSION}
ENV HADOOP_HOME /usr/local/hadoop/${HADOOP_DIR}
ENV HADOOP_CONF_DIR ${HADOOP_HOME}/etc/hadoop
ENV HADOOP_WEB_PATH http://www-us.apache.org/dist/hadoop/common/hadoop-"${HADOOP_VERSION}"/hadoop-"${HADOOP_VERSION}".tar.gz

RUN wget "${HADOOP_WEB_PATH}" && \
    tar xzvf hadoop-"${HADOOP_VERSION}".tar.gz -C /tmp && \
    mkdir -p /usr/local/hadoop && mv /tmp/"${HADOOP_DIR}" "${HADOOP_HOME}" && \
    rm -rf hadoop-"${HADOOP_VERSION}".tar.gz && \
    sed -i 's#^.*export JAVA_HOME.*$#export JAVA_HOME='"$JAVA_HOME"'#' "${HADOOP_CONF_DIR}"/hadoop-env.sh && \
    sed -i 's#^.*export HADOOP_CONF_DIR.*$#export HADOOP_CONF_DIR='"$HADOOP_CONF_DIR"'#' "${HADOOP_CONF_DIR}"/hadoop-env.sh

CMD /bin/bash
