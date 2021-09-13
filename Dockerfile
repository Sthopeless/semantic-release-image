FROM node:alpine

# node:alpine doesn't come with certificates or git, so we need to grab those
RUN apk add --no-cache ca-certificates git

# We include:
#  - the core semantic-release
#  - the official and community plugins from https://semantic-release.gitbook.io/semantic-release/extending/plugins-list
#  - the official and community configs from https://semantic-release.gitbook.io/semantic-release/extending/shareable-configurations-list
#
# ... with the exception that any plugins that don't trivially install are
# summarilty commented out.
#
# Also, even though Dockerfile best practices would have this as one giant RUN
# command, we want to take advantage of layer caching, and thus use separate RUN
# commands, with the (hopefully) core/stable components first

RUN npm install -g \
  semantic-release@latest

# core plugins
RUN npm install -g \
  @semantic-release/apm@latest \
  @semantic-release/changelog@latest \
  @semantic-release/exec@latest \
  @semantic-release/git@latest \
  @semantic-release/gitlab@latest \
  @saithodev/semantic-release-gitea

# core configs
RUN npm install -g \
  @semantic-release/apm-config@latest \
  @semantic-release/gitlab-config@latest

# community plugins
RUN npm install -g \
  #@conveyal/maven-semantic-release@latest \
  @qiwi/semantic-release-gh-pages-plugin@latest \
  #gradle-semantic-release-plugin@latest \
  #semantic-release-ado@latest \
  semantic-release-chrome@latest \
  #semantic-release-circleci-orb@latest \
  #semantic-release-docker@latest \
  semantic-release-expo@latest \
  #semantic-release-firefox@latest \
  #semantic-release-gcr@latest \
  semantic-release-gerrit@latest \
  semantic-release-slack-bot@latest \
  semantic-release-verify-deps@latest
  #semantic-release-vsce@latest

# community configs
# RUN npm install -g \
#   @jedmao/semantic-release-npm-github-config@latest

# Consumers of this image should mount their project directory into `/source`,
# which will be the current directory when semantic-release runs.  Docker-based
# CI/CD tools might mount a different directory, but they should also explicitly
# set the working directory such that everything will still work.
WORKDIR /source
VOLUME /source

ENTRYPOINT [ "semantic-release" ]
