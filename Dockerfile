FROM ubuntu:17.04

ENV DEBIAN_FRONTEND noninteractive

# Upgrade packages
RUN apt-get update -y && apt-get upgrade -y

# Install requirements
RUN apt-get install -y \
        software-properties-common \
        openssh-server

# Install X2Go server components
RUN add-apt-repository ppa:x2go/stable
RUN apt-get update -y
RUN apt-get install -y x2goserver

# SSH runtime
RUN mkdir /var/run/sshd

# Configure default user
RUN adduser --gecos "X2Go User" --disabled-password x2go
RUN echo "x2go:x2go" | chpasswd

# Run it
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
