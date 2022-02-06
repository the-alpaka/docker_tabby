# Docker Tabby
Tabby in Docker for easier deployment

## Usage

There are two ways you can run this container, either with Docker CLI or Docker-Compose. Setting up this container is super simple you just need to be sure to allow container port 80 through to the host, for example `-p 8090:80` with the mappings respectively `<host_port>:<container_port>`. Use any of the preconfigured options below to get the container up and running quickly. After starting the container go to your favorite web browser and type in `http://<HOST_IP>:8090` to access the Web UI.

### Docker CLI

Simply run the following command.

```bash
docker run -d \
--name=tabby \
-p 8090:80 \
--restart unless-stopped \
thealpaka/tabby
```

### Docker-Compose

Create a file named `docker-compose.yml`, then run `docker-compose pull && docker-compose up -d`.

```yaml
version: '3'
services:
  my-mind:
    image: thealpaka/tabby
    container_name: tabby
    ports:
      - 8090:80
    restart: unless-stopped
```

## Credits
All credits to Tabby goes to the devs at [https://github.com/bertvandepoel/tabby](https://github.com/bertvandepoel/tabby). 
Credits for the docker base image go to the devs over at [Linuxserver.io](https://linuxserver.io).
