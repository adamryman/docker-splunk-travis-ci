# Docker image with Splunk for Travis CI

In order to test Splunks SDKs on Travis CI, there must be a docker container with Splunk installed and all required configurations set.

This repository includes a Dockerfile that builds a docker image that is ready to be testing in Travis CI.

It also contains an example .travis.yml file with comments. It should be easy to adapt for other Splunk SDKs.
