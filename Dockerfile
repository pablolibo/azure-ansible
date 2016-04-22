# Latest Ubuntu LTS Azure-Cli + Ansible

FROM ubuntu:14.04 
MAINTAINER Pablo J Villarruel <pablolibo@gmail.com>
RUN sudo apt-get install software-properties-common -y
RUN sudo apt-add-repository ppa:ansible/ansible -y
RUN sudo apt-get update
RUN sudo apt-get install ansible -y

ENV AZURE_CLI_VERSION "0.9.20" 
ENV NODEJS_APT_ROOT "node_4.x" 
ENV NODEJS_VERSION "4.2.4" 
RUN apt-get update -qq && \
    apt-get install -qqy --no-install-recommends\
      apt-transport-https \
      build-essential \
      curl \
      ca-certificates \
      git \
      lsb-release \
      python-all \
      rlwrap \
      vim \
      nano \
      jq && \
    rm -rf /var/lib/apt/lists/* && \
    curl https://deb.nodesource.com/${NODEJS_APT_ROOT}/pool/main/n/nodejs/nodejs_${NODEJS_VERSION}-1nodesource1~trusty1_amd64.deb > node.deb && \
      dpkg -i node.deb && \
      rm node.deb && \
      npm install --global azure-cli@${AZURE_CLI_VERSION} && \
      azure --completion >> ~/azure.completion.sh && \
      echo 'source ~/azure.completion.sh' >> ~/.bashrc && \
      azure
RUN azure config mode arm
ENV EDITOR vim
