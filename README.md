# efm1.0.0.0-docker
Edge Flow Manager Docker Instance

Inline `code` has `back-ticks around` it.

## H2 Edge Flow Manager UI

This docker instance will launch a EFM UI.  git clone this repo

1.  Git Clone
2.  Build a docker image
docker build --no-cache -t efm .
... `docker build --no-cache -t efm .`
3.  Run the image
... `docker run --name efm -p 10080:10080 -d efm:latest`
