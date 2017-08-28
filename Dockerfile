FROM justinxu/hadoop
MAINTAINER Justin

# 2 NameNodes IP/Domain
ENV MASTER 172.18.0.111


# 2 DataNodes IP/Domain
ENV SLAVE1 172.18.0.121
ENV SLAVE2 172.18.0.122

# Allow root login by ssh
# Automatically accept public key
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config && \
    sed -i "s/^.*StrictHostKeyChecking.*$/StrictHostKeyChecking no/" /etc/ssh/ssh_config

# generate key pair
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 0600 ~/.ssh/authorized_keys

# Setting for Hadoop Cluster Operation
ADD cluster/* "${HADOOP_HOME}"/etc/hadoop/

# set hostname
RUN echo ${MASTER} master >> /etc/hosts && \
    echo ${SLAVE1} slave1 >> /etc/hosts && \
    echo ${SLAVE2} slave2 >> /etc/hosts

CMD echo "root:password"|chpasswd && /etc/init.d/ssh start && /bin/bash
