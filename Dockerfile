#escape=`
FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ARG AGENT_VERSION=2.195.2
ARG COMPOSE_VERSION=1.27.4

ENV WORKDIR="_work"
ENV AGENT_ALLOW_RUNASROOT="1"

# Install docker-cli
RUN apt-get update; ` 
    apt-get install -y `
    apt-transport-https `
    ca-certificates `
    curl `
    gnupg-agent `
    software-properties-common `
    git

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

RUN add-apt-repository `
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu `
   $(lsb_release -cs) `
   stable"

RUN apt-get update; `
    apt-get install -y docker-ce-cli

# Install docker-compose
RUN curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose; ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Install Azure DevOps agent
RUN mkdir /azagent && chmod -R 755 /azagent
WORKDIR /azagent
COPY init.sh .
RUN chmod +x ./init.sh

RUN curl -fkSL -o vstsagent.tar.gz https://vstsagentpackage.azureedge.net/agent/${AGENT_VERSION}/vsts-agent-linux-x64-${AGENT_VERSION}.tar.gz; `
    tar -zxvf vstsagent.tar.gz;

ENTRYPOINT ["./init.sh"]
