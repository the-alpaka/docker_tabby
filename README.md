# Docker Tabby
Tabby in Docker for easier deployment

## To Do
I'll be working on integrating these features into the docker image over the next couple months. Feel free to help contribute I'm still new to building docker containers and completely new with using github actions to automate the docker build process.
- ~~Automatic builds to docker hub without a backend server needed to force updates~~ I'm like 95% sure this works just got to wait for the next update to find out for sure
- ~~Synchronize container tags with tabby build version tags in an automated manner~~

## Usage

There are two ways you can run this container, either with Docker CLI or Docker-Compose. Setting up this container is super simple you just need to be sure to allow container port 80 through to the host, for example `-p 8090:80` with the mappings respectively `<host_port>:<container_port>`. Use any of the preconfigured options below to get the container up and running quickly. After starting the container go to your favorite web browser and type in `http://<HOST_IP>:8090` to access the Web UI.

### Docker CLI

First create a network called `tabby-backend`

```bash
docker network create tabby-backend
```
Simply run the following command to set up the Tabby container.

```bash
docker run -d \
--name=tabby \
--network=tabby-backend \
-p 8090:80 \
--restart unless-stopped \
thealpaka/tabby
```

Then run this command to setup the database, once done you can visit `http://<HOST_IP>:8090` to finish setup for Tabby.

```bash
docker run -d \
  --name=mariadb \
  --network=tabby-backend \
  -e PUID=1000 # Run 'id' in your terminal to get this value \
  -e PGID=1000 # Run 'id' in your terminal to get this value \
  -e MYSQL_ROOT_PASSWORD=ROOT_ACCESS_PASSWORD \
  -e TZ=America/New_York \
  -e MYSQL_DATABASE=tabby \
  -e MYSQL_USER=tabby \
  -e MYSQL_PASSWORD=tabby \
  -p 3306:3306 \
  -v path_to_data:/config \
  --restart unless-stopped \
  linuxserver/mariadb
```

### Docker-Compose

Create a file named `docker-compose.yml`, then run `docker-compose pull && docker-compose up -d`.

```yaml
version: '3'
services:
  tabby:
    image: thealpaka/tabby
    container_name: tabby
    networks:
      - backend
    ports:
      - 8090:80
    restart: unless-stopped
  db:
    image: linuxserver/mariadb
    container_name: tabby-db
    networks:
      - backend
    environment:
      - PUID=1000 # Run 'id' in your terminal to get this value
      - PGID=1000 # Run 'id' in your terminal to get this value
      - MYSQL_ROOT_PASSWORD=ROOT_ACCESS_PASSWORD
      - TZ=America/New_York
      - MYSQL_DATABASE=tabby
      - MYSQL_USER=tabby
      - MYSQL_PASSWORD=tabby
    volumes:
      - ./db:/config
    restart: unless-stopped
networks:
  backend:
    internal: true
```

## License
This project is licensed under the AGPL license - see the [LICENSE](https://github.com/the-alpaka/docker_tabby/blob/main/LICENSE) file for details.

## Credits
All credits to Tabby goes to the devs at [https://github.com/bertvandepoel/tabby](https://github.com/bertvandepoel/tabby). 
Credits for the docker base image go to the devs over at [Linuxserver.io](https://linuxserver.io).
