# scalyr-docker

To install:

1. Edit the Dockerfile to include your API key
2. Build the Dockerfile
```
docker build --tag scaylr-coreos .
```
3. Run the image
```
docker run --privileged -d --volume /var/log:/var/log/host scaylr-coreos
```
