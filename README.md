# docker-qtum
Docker Image for Qtum Core

### Quick Start
Create a qtum-data volume to persist the qtum blockchain data, should exit immediately. The qtum-data container will store the blockchain when the node container is recreated (software upgrade, reboot, etc):
```
docker volume create --name=qtum-data
```
Create a qtum.conf file and put your configurations
```
mkdir -p .qtumdocker
nano /home/$USER/.qtumdocker/qtum.conf
```

Run the docker image
```
docker run -v qtum-data:/qtum --name=qtum-node -d \
      -p 3888:3888 \
      -p 3889:3889 \
      -v /home/$USER/.qtumdocker/qtum.conf:/qtum/.qtum/qtum.conf \
      bitsler/docker-qtum
```

Check Logs
```
docker logs -f qtum-node
```


