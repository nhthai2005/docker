# Installing docker in Centos
#!/bin/bash
yum update -y
yum install -y docker
service docker start
chkconfig docker on
curl -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# -v /Docker-Shared/getting-started:/usr/share/nginx/html --> mount volume
# --restart unless-stopped --> auto start docker after boot
# -d --> run deamon
# -p --> port [host_port: container_port]
# /usr/share/nginx/html --> nginx data locate in container
docker run -v /Docker-Shared/getting-started:/usr/share/nginx/html -dp 80:80 --restart unless-stopped docker/getting-started

docker run -v /Docker-Shared/getting-started_pwd:/usr/share/nginx/html -dp 81:80 --restart unless-stopped docker/getting-started:pwd

# Installing network-tools in ubuntu
sudo apt-get update -y
sudo apt-get install -y net-tools

# Run docker os with terminal
docker run -it centos

# Login container
docker exect -it [container ID]

# Build docker from container
docker commit nginx_base # nginx_base: container-name

# Tag image
docker tag <image-ID> <new-image-name>

----
apt-get install docker-ce=5:19.03.12~3-0~ubuntu-focal docker-ce-cli=5:19.03.12~3-0~ubuntu-focal containerd.io


