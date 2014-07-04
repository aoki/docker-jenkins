FROM ringo/scientific:6.5

MAINTAINER Yoshiki Aoki <ringohub@gmail.com>

ENV LANG en_US.UTF-8

# Add EPEL repository
RUN rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt
RUN rpm -ivh http://ftp.riken.jp/Linux/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm

RUN yum -y update
RUN yum -y upgrade && yum clean all

# Install supervisor
RUN yum install -y supervisor.noarch && yum clean all
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Install java
RUN yum install -y java-1.7.0-openjdk-devel.x86_64 && yum clean all

# Install Jenkins
RUN wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
RUN rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
RUN yum install -y jenkins && yum clean all

# Install ssh
RUN yum install -y openssh-server openssh-clients && yum clean all
RUN mkdir -p /var/run/sshd
RUN ssh-keygen -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ""
RUN ssh-keygen -t dsa -b 1024 -f /etc/ssh/ssh_host_dsa_key -N ""

# Change root password
RUN echo "root:root" | chpasswd

EXPOSE 22 8080
ENTRYPOINT /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
