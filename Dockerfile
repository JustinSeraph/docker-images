FROM justinxu/docker-images:ubuntu-base
MAINTAINER Justin
USER root

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
    update-alternatives --install "/usr/bin/javac" "javac" "${JAVA_HOME}/bin/javac" "${JAVA_VERSION}${JAVA_UPDATE}" \
    apt-get autoclean && apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD /bin/bash
