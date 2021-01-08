# semantic-release<small>(-image)</small>

A generally-up-to-date image containing [semantic-release](https://semantic-release.gitbook.io/semantic-release/) and most official and community plugins, good for use in containerized CI/CD pipelines!

## Usage

The image assumes that `/source` is the working directory, and has `semantic-release` as the default ENTRYPOINT, so you can verify things are working with:

```shell
docker run --rm -ti -v .:/source -e GITHUB_TOKEN=YOUR-TOKEN-HERE jaredreisinger/semantic-release --dry-run
```

(with _your_ token in place of `YOUR-TOKEN-HERE`, of course)... and you should see the regular dry-run output from semantic-release. Depending on the plugins your `.releaserc` specifies, you may need other environment variables defined.

#### In a CI/CD pipeline

Using [Drone](https://drone.io) as an example, you can create a release step as simply as:

```yaml
# . . .
steps:
  # . . .
  - name: release
    image: jaredreisinger/semantic-release
    environment:
      GITHUB_TOKEN:
        from_secret: github_token
```

(Assuming here that `github_token` has already been set up as a Drone repository or organization secret.) If you have a `.releaserc` file, your chosen plugins and configuration will magically be used. Also note that Drone binds the source directory to the image and sets that directory as the current working one, so there's no need to specifically mount into `/source`. This should be true of any Docker-based CI/CD.

## Notes

Given the sheer number of plugins, I've decided to simply include everything as "latest".

Even though normal Dockerfile practice is to combine RUN commands to reduce the number of layers, we take advantage of caching by separating these out, and attempting to put the more-stable and less-often-updated components first.
