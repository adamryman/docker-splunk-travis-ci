# Docker image with Splunk for Travis CI

In order to test Splunks SDKs on Travis CI, there must be a docker container with Splunk installed and all required configurations set.


## Usage
Currently the build version of this image is located at http://hub.docker.com/r/adamryman/splunk-travis-ci which you can get with 

```
docker pull adamryman/splunk-travis-ci:$SPLUNK_VERSION
```

Current built versions are `6.2.5`, `6.1.9` and `6.0.10`.

## Build a different version

To build this docker image for a different version of Splunk, in the [Dockerfile](https://github.com/adamryman/docker-splunk-travis-ci/blob/master/Dockerfile) change `SPLUNK_VERSION` and `SPLUNK_BUILD` to your choice of version and build respectivly.

## Additonal Information

### [Dockerfile](https://github.com/adamryman/docker-splunk-travis-ci/blob/master/Dockerfile)
This Dockerfile builds an image with the following qualites:
- Splunk installed 
- [SDK App Collection](https://github.com/splunk/sdk-app-collection) installed
- `allowRemoteLogin=true` to allow api access with default password

### [.travis.yml](https://github.com/adamryman/docker-splunk-travis-ci/blob/master/.travis.yml) file
This file is example `.travis.yml` file for [Travis CI](http://travis-ci.org). It:
- Adds a `.splunkrc` file
- Pulls and runs the docker image built from this container
