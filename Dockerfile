FROM ubuntu:17.04

LABEL authors="Vincent BESANCON <besancon.vincent@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive

# Install requirements
RUN set -x \
      && apt-get update -y \
      && apt-get dist-upgrade -y \
      && apt-get install -y \
            software-properties-common \
            openssh-server \
      && rm -rf /var/lib/apt/lists/*

# Install X2Go server components
RUN set -x \
      && add-apt-repository ppa:x2go/stable \
      && apt-get update -y \
      && apt-get install -y x2goserver \
      && rm -rf /var/lib/apt/lists/*

# SSH runtime
RUN mkdir /var/run/sshd

# Configure default user
RUN adduser --gecos "X2Go User" --disabled-password x2go
RUN echo "x2go:x2go" | chpasswd

# Run it
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
