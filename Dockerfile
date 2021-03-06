MAINTAINER Justin

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
       openssh-server \
       openssh-client \
       vim && \
    apt-get clean && \
    apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/*

# Install Java 8
ENV JAVA_VERSION 8
ENV JAVA_UPDATE 144
ENV JAVA_BUILD 01
ENV JAVA_SIG 090f390dda5b47b9b721c7dfaa008135
ENV JAVA_DIR jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}
ENV JAVA_HOME /usr/local/java/${JAVA_DIR}
ENV JRE_HOME ${JAVA_HOME}/jre
ENV JAVA_WEB_PATH http://download.oracle.com/otn-pub/java/jdk/"${JAVA_VERSION}"u"${JAVA_UPDATE}"-b"${JAVA_BUILD}"/"${JAVA_SIG}"/server-jre-"${JAVA_VERSION}"u"${JAVA_UPDATE}"-linux-x64.tar.gz

RUN wget --ca-certificate=/etc/ssl/certs/GeoTrust_Global_CA.pem --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    "${JAVA_WEB_PATH}" && \
    tar xzvf server-jre-"${JAVA_VERSION}"u"${JAVA_UPDATE}"-linux-x64.tar.gz -C /tmp && \
    mkdir -p /usr/local/java && mv /tmp/"${JAVA_DIR}" "${JAVA_HOME}" && \
    rm -rf server-jre-"${JAVA_VERSION}"u"${JAVA_UPDATE}"-linux-x64.tar.gz &&\
    update-alternatives --install "/usr/bin/java" "java" "${JRE_HOME}/bin/java" "${JAVA_VERSION}${JAVA_UPDATE}" && \
    update-alternatives --install "/usr/bin/javac" "javac" "${JAVA_HOME}/bin/javac" "${JAVA_VERSION}${JAVA_UPDATE}"

# Install hadoop
ENV HADOOP_VERSION 2.8.1
ENV HADOOP_DIR hadoop-${HADOOP_VERSION}
ENV HADOOP_HOME /usr/local/hadoop/${HADOOP_DIR}
ENV HADOOP_WEB_PATH http://www-us.apache.org/dist/hadoop/common/hadoop-"${HADOOP_VERSION}"/hadoop-"${HADOOP_VERSION}".tar.gz

RUN wget "${HADOOP_WEB_PATH}" && \
    tar xzvf hadoop-"${HADOOP_VERSION}".tar.gz -C /tmp && \
    mkdir -p /usr/local/hadoop && mv /tmp/"${HADOOP_DIR}" "${HADOOP_HOME}" && \
    rm -rf hadoop-"${HADOOP_VERSION}".tar.gz && \
    sed -i 's#^.*export JAVA_HOME.*$#export JAVA_HOME='"$JAVA_HOME"'#' ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh

# Allow root login by ssh
# Automatically accept public key
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config && \
    sed -i "s/^.*StrictHostKeyChecking.*$/StrictHostKeyChecking no/" /etc/ssh/ssh_config

# generate key pair
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 0600 ~/.ssh/authorized_keys

# Setting for Pseudo-Distributed Operation
ADD pseudo/* "${HADOOP_HOME}"/etc/hadoop/

# Setting for Pseudo-Distributed-yarn Operation
ADD pseudo/yarn/* "${HADOOP_HOME}"/etc/hadoop/

CMD echo "root:password"|chpasswd && /etc/init.d/ssh start && /bin/bash
