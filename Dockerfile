FROM ubuntu
MAINTAINER Justin

ENV DEBIAN_FRONTEND noninteractive

# Update the repository and install some tools
RUN apt-get update && apt-get -y install net-tools iputils-ping apt-utils ca-certificates && \
	apt-get -y install openssh-server openssh-client && \
	sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config && \ #Allow root login by ssh
	sed -i "s/^.*StrictHostKeyChecking.*$/StrictHostKeyChecking no/" /etc/ssh/ssh_config && \ #Automatically accept public key
	apt-get autoclean && apt-get --purge -y autoremove

#Clean the temps
RUN	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD /etc/init.d/ssh start && /bin/bash



	
	