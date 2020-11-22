# azp-env-agent
Azure Pipelines Environment Agent

If you have VM or dedicated server with docker and want to install multiple apps with Azure DevOps, there is a problem with sharing environment agent between projects. While using the "old" way - Deployment Groups - there was possibility to share agent between projects, with the new Environments feature it's not possible. You need to setup separate agent for each projects.

To do this in the most efficient way, I've created this docker repo with Azure DevOps agent configured as environment resource. You can setup multiple agents on single machine and use same machine as resource in multiple projects. But that's only a half of a solution. If you run a deployment job in such environment, all commands will be executed inside the container - but that's not what we want. In order to install the application on the actual VM, we need to map the docker socket. This can be done with a volume while running this container.
