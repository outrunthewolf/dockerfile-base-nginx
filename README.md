dockerfile-nginx
================

Docker Container for a basic nginx, php5, mysql setup

### Requiries

Docker >= 0.6.x

### Usage

Clone, pull or download the repository. At the same level as the dockerfile build your container with whatever name you'd like:

```shell
sudo docker build -t base/nginx .
```

Once you've got a completed image, you can run the container outright:

#### Daemon
```shell
# Daemon
sudo docker run -d base/nginx 

#### Interactive
sudo docker run -i -t base/nginx /bin/bash

#### Dockerfile
Or you can couple the built container as a base for another application within its Dockerfile

```shell
# Dockerfile example

# Set the new application to inherit this container
FROM base/nginx

...
```
