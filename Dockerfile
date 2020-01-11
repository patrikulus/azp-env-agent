#escape=`
FROM ubuntu:bionic

ARG AGENT_VERSION=2.163.1
ARG COMPOSE_VERSION=1.25.0

ENV WORKDIR="_work"

# Install docker
RUN apt-get update; ` 
    apt-get install -y `
    apt-transport-https `
    ca-certificates `
    curl `
    gnupg-agent `
    software-properties-common

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

RUN add-apt-repository `
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu `
   $(lsb_release -cs) `
   stable"

RUN apt-get update; `
    apt-get install -y docker-ce docker-ce-cli containerd.io

# Install docker-compose
RUN curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose; ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Install Azure DevOps agent
RUN mkdir /azagent
WORKDIR /azagent

RUN curl -fkSL -o vstsagent.tar.gz https://vstsagentpackage.azureedge.net/agent/${AGENT_VERSION}/vsts-agent-linux-x64-${AGENT_VERSION}.tar.gz; `
    tar -zxvf vstsagent.tar.gz;

COPY init.sh .

ENTRYPOINT ["./init.sh"]