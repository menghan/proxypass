FROM ubuntu:18.04

RUN apt-get update && apt-get install -y openssh-server && \
	mkdir /var/run/sshd && \
	sed -i 's/^.*PermitRootLogin .*$/PermitRootLogin no/' /etc/ssh/sshd_config && \
	sed -i 's/^.*PasswordAuthentication.*$/PasswordAuthentication no/' /etc/ssh/sshd_config && \
	sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
	rm -rf /var/lib/apt/lists/*

RUN echo 'user:x:1000:1000:,,,:/home/user:/bin/bash' >> /etc/passwd && mkdir -p /home/user/.ssh && chown -R user /home/user && chmod -R og-rwx /home/*/.ssh/

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
