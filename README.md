# Rebuild and Restart a docker container

My first selfmade Github Action from me for me to stop a docker container, build a new image with the updated codebase and start the new container.
The action is made for self-hosted runner. For my case it is made to replace a discord bot on my home server, that I update from time to time.

# Usage

Here is an example workflow how I use the action for my discord bot, when I update its codebase in my self hosted Forgejo instance.
For additional inputs the env-variables can be defined and will be forwarded to the docker container on startup.

```yaml
name: custom action workflow
on:
  push:
    branches:
      - main
jobs:
  CnD:
    runs-on: self-hosted
    steps:
      - name: "Checkout Repository"
        uses: actions/checkout@v4
      - name: "My self made build and deploy"
        uses: rockerle/buildNdeploy-docker@v2
        with:
          imagename: "rockerle/discordbot:latest"
          containername: "rockerbot"
          dnetwork: "examplenetwork"
          label: |
            example-label1
            example-label2
          env: |
            BOT_TOKEN=${{secrets.BOT_TOKEN}}
            cpus='0.75'
```

# Workflow Inputs

| Input         | default value        |
|:--------------|:---------------------|
| imagename     | default-iName:latest |
| containername | default-cName        |
| restartpolicy | unless-stopped       |
| dnetwork(@v2) |                      |
| label(@v2)         |                      |
| env(@v2)           |                      |
