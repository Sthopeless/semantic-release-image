# semantic-release-image

[semantic-release](https://github.com/semantic-release/semantic-release), encapsulated in a Docker image

The hope is that this can be driven by GitHub Actions... a recurring (cron) job can look for updates to semantic-release itself, and can in turn kick off the build of an updated image.  Ideally, no manual intervention would be needed at all!
