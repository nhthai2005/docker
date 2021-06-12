# Docker căn bản và nâng cao
## Bài 25: Docker 1 / DevOps Docker là gì? cài docker và docker-compose trên EC2/AWS và Windowscompose trên EC2/AWS
```
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user
```
- Cài docker-compose
```
sudo curl -L "https://github.com/docker/compose/rel... -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```
## Bài 26: Docker 2/DevOps triển khai tạo Image, Container&Docker Hub cho khách hàng và đội lập trình
```
Các lệnh với image
- Tìm image để cài đặt
`docker search centos`
- List các image đang có
`docker image ls`
- Xóa image
`sudo docker rmi [Image ID]`
Chú ý: Các image mà có container đang chạy thì sẽ không xóa được mà phải xóa container liên quan tới nó trước
- Pull image về
`docker pull centos:7`

Làm việc với container

- Chạy 1 container từ image
```
docker run --privileged -d -p 80:80 [Image Name] /sbin/init
docker run --privileged -d -p 80:80 centos:7 /sbin/init
```
- Vào container để chạy lệnh
`docker exec -it [Container ID] /bin/bash `

- Cài đặt apache
```
yum -y install httpd
systemctl start httpd
systemctl enable httpd

echo "Hello Tin Hoc That La Don Gian" > /var/www/html/index.html
```
- Thoát ra khỏi container
`exit`

- Tạo image để triển khai cho máy khác
```
docker commit -m "Comment" -a "Tác giả"  [Container ID] [Image Name]
docker commit -m "Centos Project01" -a "Nguyen Quoc Bao" d452f1a1b69d tinhocthatladongian/project01:v1
```
- Đăng nhập vào docker/hub
`docker login`

- Đưa image lên docker hup để mọi người cùng sử dụng
```
docker push [Tên image]
docker push tinhocthatladongian/project01:v1
 ```
- Check các container đang chạy
`sudo docker ps -a`

- Xem trạng thái container
`docker container ls -a`

- Xóa containner
`sudo docker rm [Container ID]`

- Stop container
`docker container stop [Container ID]`

- Restart container
`docker container restart [Container ID]`

- Pause container
`docker container pause  [Container ID]`

- Truy cập vào các container đang chạy
`docker container attach [Container ID]`


- Lệnh stop toàn bộ container
`docker stop $(docker ps -a -q)`

- Lệnh xóa toàn bộ container
`docker rm $(docker ps -a -q)`

- Lệnh xóa toàn bộ image
`docker rmi -f $(docker images -a -q)`


## Bài 27:DevOps Docker 3 / Dockerfile đây chính là lý do tăng lương, tăng vị trí cho các bạn developer
--------------------------------------------------------------
1. Tạo Dockerfile
```
# Get base image
FROM centos:7

# Author
MAINTAINER "Nguyen Quoc Bao"

#Cai dat apache
RUN yum update -y
RUN yum install -y sudo
RUN yum install -y epel-release
RUN yum install -y https://www.youtube.com/redirect?q=http%3A%2F%2Frpms.famillecollet.com%2Fenterprise%2Fremi-release-7.rpm&v=ldWzwIdt6Bo&event=video_description&redir_token=QUFFLUhqbEpVLXRNaEZIQWZLWXhFOVN5MGtZd1NUM1lYZ3xBQ3Jtc0tsVjJqR1ZkX1p6azBTWXhQRGltMTA2T1ctMERESEhuR0FqQmxDSkdpMEh3Q2luTGpQd29lQXBENEFUa1oxc2psQUJXRFRrMkttend0ZVY0anZpZ1pIek1ielpPazMyQ3A0WkxyRW5DWkhJNWxkUHVQZw%3D%3D
RUN yum clean all
RUN yum -y install wget
RUN yum -y install httpd
RUN yum -y install --enablerepo=remi,remi-php71 php php-devel php-mbstring php-pdo php-gd php-xml php-mcrypt php-pgsql
 
#Thiet lap thu muc lam viec 
WORKDIR /var/www/html

#copy code tu thu muc code vao image
ADD ./code /var/www/html

# start httpd
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

EXPOSE 80

```
2. Build image
`docker build -t httpd_sample .`

3. Tạo và chạy container
`docker run -d -p 80:80 httpd_sample`



Bài 28: DevOps Docker 4 / Docker-compose docker nâng cao
--------------------------------------------------
Script
http://tinhocthatladongian.com/download/aws_bai28.txt
1. Cài EC2
```
#!/bin/bash
yum update -y
yum install -y docker
service docker start
chkconfig docker on
curl -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```


Sample

1. Tạo file Dockerfile
```
FROM centos:7
RUN yum -y update && \
    yum -y install httpd php
WORKDIR /var/www/html
ADD ./code /var/www/html
EXPOSE 80
```
2.Tạo file `docker-compose.yml`
```
version: '3'
services:                                                                                       
  web:                                                                                          
    build: .
    command: ["/usr/sbin/httpd","-D","FOREGROUND"] 
    volumes:
      - ./code:/var/www/html	
    ports:                                                                                      
      - "80:80"
```	  
	  
- Build image
`$ docker-compose build`

- Chạy container
`$ docker-compose up`

- Stop
`$ docker-compose stop`

- Start lại container
`$ docker-compose start`

- Stop và xóa container
`$ docker-compose down`



Sample
https://github.com/dockersamples/example-voting-app.git

Dockerfile là gì
Là file config dùng để build các image mới dựa trên một image có sẵn
```
Các lệnh trong `Dockerfile`
FROM: Lấy 1 image trên docker hub
LABEL: Thông tin người bảo trì dockerfile
ENV: thiết lập một biến môi trường
RUN: Chỉ chạy khi build image, được sử dụng để cài đặt các package vào container
COPY: Sao chép các file và thư mục vào container
ADD: Sao chép các file và thư mục vào container
CMD: trong 1 Dockerfile chỉ có 1 CMD, chỉ chạy khi thực hiện lện docker run để tạo ra 1 container
WORKDIR: Thiết lập thư mục làm việc cho các chỉ thị khác như: RUN, CMD, ENTRYPOINT, COPY, ADD,…
ARG: Định nghĩa giá trị biến được dùng trong lúc build image
ENTRYPOINT: cung cấp lệnh và đối số cho một container thực thi
EXPOSE: khai báo port lắng nghe của image
VOLUME: tạo một điểm gắn thư mục để truy cập và lưu trữ data.
```

Bài 29: DevOps Docker 5 / Docker Volume, Networks docker nâng cao
------------------------------------------------------------
http://tinhocthatladongian.com/download/Aws_Bai29.txt
Các lệnh xóa đồng loạt
```
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker rmi -f $(docker images -a -q)
docker-compose up -d
```


1. Volume
```
# docker volume create       Tạo mạng mới
# docker volume inspect      Xem chi tiết mạng
# docker volume ls           Hiển thị những mạng đang có
# docker volume rm           Xóa volume
# docker volume prune        Xóa toàn bộ volumn

Ví dụ
docker volume create project01_code
docker run --name project01 -p 8081:80 -v project01_code:/usr/local/apache2/htdocs -d httpd

Ví dụ 2
docker container run --name mysql -e MYSQL_ROOT_PASSWORD=pass -p 3306:3306 -d mysql:5.7

docker volume create pj01_data
docker container run --name mysql -v pj01_data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=pass -p 3306:3306 -d mysql:5.7
```

2. Networks
```
Ví dụ 1
Tạo 1 mạng lớp C
docker network create --subnet 192.168.1.0/24 network1

Tạo ra 2 container kết nối với mạng này
docker run -itd --name=container1  --network network1 busybox
docker run -itd --name=container2  --network network1 busybox

Kiểm tra kết nối giữa 2 mạng
docker attach container1

Ví dụ 2
# docker run --name mysql --network network1 -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:5.7
# docker run --name wordpress --network network1 -e WORDPRESS_DB_PASSWORD=my-secret-pw -p 8080:80 -d wordpress
```




```
Sampe 1 tạo DB MYSQL
sample-project/
             ├ docker/
             |       └ mysql/
             |              ├ conf.d/
             |              |       └ my.cnf
             |              ├ initdb.d/
             |              |         ├ schema.sql
             |              |         └ testdata.sql
             |              └ Dockerfile
			 ├ log/mysql
			 |
			 |
			 |
             └ docker-compose.yml
			 
			 
mkdir pj03
cd pj03
mkdir -p docker/mysql/conf.d
mkdir -p docker/mysql/initdb.d
mkdir -p docker/mysql/conf.d
mkdir -p log/mysql
chmod -Rf 777 log

vi docker/mysql/conf.d/my.cnf
[mysqld]
character-set-server=utf8mb4
explicit-defaults-for-timestamp=1
general-log=1
general-log-file=/var/log/mysql/mysqld.log

[client]
default-character-set=utf8mb4



vi docker/mysql/initdb.d/schema.sql
CREATE TABLE users (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(32) NOT NULL,
    email VARCHAR(32) NOT NULL,
    PRIMARY KEY (id)
);

vi docker/mysql/initdb.d/testdata.sql
INSERT INTO users (id,name,email) VALUES (1, 'Tuc Anh Ach','achsan@tinhocthatladongian.com');



vi docker/mysql/Dockerfile
FROM mysql:5.7
RUN touch /var/log/mysql/mysqld.log


vi docker-compose.yml
version: '3'
services:
  db:
    build: ./docker/mysql
    image: mysql:5.7
    restart: always
    environment:
      MYSQL_DATABASE: sample_db
      MYSQL_USER: user
      MYSQL_PASSWORD: password
      MYSQL_ROOT_PASSWORD: rootpassword
    ports:
      - "3314:3306"
    volumes:
      - ./docker/mysql/initdb.d:/docker-entrypoint-initdb.d
      - ./docker/mysql/conf.d:/etc/mysql/conf.d
      - ./log/mysql:/var/log/mysql
      - mysql_data:/var/lib/mysql
volumes:
  mysql_data:

	  
- Build container
docker-compose up -d 

- Truy cập vào container để chạy lệnh
docker exec -it sampleproject_db_1 bash

$ mysql -u user -p

INSERT INTO users (id,name,email) VALUES (2, 'BAo','bao@mail.co.jp');



truy cập vào từ ngoài bằng Navicat
mysql --host 127.0.0.1 --port 3314 -u user -p 
```



```
Sample 2
mkdir { my-wordpress-dir-name }
cd { my-wordpress-dir-name } 


docker-compose.yml

version: "2"
services:
  wordpress:
    image: wordpress:latest
    container_name: pj10_wordpress
    volumes:
      - "$PWD:/var/www/html"
      - "$PWD/.docker/backup:/tmp/backup"
      - "$PWD/.docker/log:/tmp/log"
    ports:
      - 8080:80
    depends_on:
      - db
    environment:
      WORDPRESS_DB_HOST: "db:3306"
    networks:
      - pj10_network
    env_file: .env

  db:
    image: mysql:5.7
    container_name: pj10_mysql
    volumes:
      - "db-data:/var/lib/mysql"
    networks:
      - pj10_network
    env_file: .env

volumes:
  db-data:

networks:
  pj10_network:
  
  
  
File .env
WORDPRESS_DB_NAME=wordpress
WORDPRESS_DB_USER=admin
WORDPRESS_DB_PASSWORD=pass

MYSQL_RANDOM_ROOT_PASSWORD=yes
MYSQL_DATABASE=wordpress
MYSQL_USER=admin
MYSQL_PASSWORD=pass
```






1. Docker volume
Là một nơi lưu trữ data nằm ngoài container, mục đích không làm mất data khi xóa container

Sử dụng Volume khi nào 
- Khi chia sẻ dữ liệu giữa nhiều container đang chạy.
- Lưu dữ liệu tới một server remote hoặc cloud.
- Khi cần backup, restore hoặc migrate dữ liệu từ Docker Host này sang Docker Host khác.

Lệnh liên quan tới volume
```
# docker volume create        Tạo mạng mới
# docker volume inspect       Xem chi tiết mạng
# docker volume ls             Hiển thị những mạng đang có
# docker volume rm             Xóa volume
# docker volume prune         Xóa toàn bộ volume
```
2. Docker networks
Để kết nối các container trong cùng mạng hoặc khác mạng với nhau.
```
Các câu lệnh thao tác với mạng
# docker network create        Tạo mạng mới
# docker network inspect       Xem chi tiết mạng
# docker network ls             Hiển thị những mạng đang có
# docker network rm            Xóa mạng
# docker network prune         Xóa đồng loạt các mạng không sử dụng
# docker network connect       Tạo kết nối mạng
# docker network disconnect    Ngắt kết nối mạng


Danh sách đầy đủ các khóa học như AWS, DevOps, FullStack, Dockers, Jenkins, Tin học Văn phòng, Quản lý dự án, Agile Scrum, AI Machine Learning, Big Data...
<https://www.youtube.com/channel/UCylBvJVCgY3AP_iU2BzDSpA/playlists>


⚙️Dịch vụ Freelance
- Tư vấn & triển khai giải pháp hệ thống cho doanh nghiệp
- Phát triển phần mềm Website, Mobile App, PC App

📞 Vui lòng liên hệ
Mr. Bảo
Phone/Zalo: 0933.73.93.56
```
---
Trên là tài liệu mình sưu tầm được từ nguồn internet có bổ sung chút ít theo ý cá nhân mang tính chất sưu tầm làm tài liệu cá nhân và chia sẻ cho những người bạn. Nên mình giữa nguyên thông tin của tác giả.
