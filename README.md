# semantic-release<small>(-image)</small>

A generally-up-to-date image containing [semantic-release](https://semantic-release.gitbook.io/semantic-release/) and most official and community plugins, good for use in containerized CI/CD pipelines!

## Usage

The image is constructed with `semantic-release` as the ENTRYPOINT, so you can easily verify things are working with:

```shell
docker run --rm -ti jaredreisinger/semantic-image --help
```

... and you should see the regular help output from semantic-image.

#### In a CI/CD pipeline

Using [Drone](https://drone.io) as an example, you can create a release step as simply as:

```yaml
# . . .
steps:
  # . . .
  - name: release
    image: jaredreisinger/semantic-release
```

If you have a `.releaserc` file, your chosen plugins and configuration will magically be used.

## Notes

Given the sheer number of plugins, I've decided to simply include everything as "latest".

Even though normal Dockerfile practice is to combine RUN commands to reduce the number of layers, we take advantage of caching by separating these out, and attempting to put the more-stable and less-often-updated components first.
