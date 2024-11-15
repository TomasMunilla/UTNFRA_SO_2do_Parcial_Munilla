cd /home/repogit/UTN-FRA_SO_Examenes/202406/docker
sudo vim Dockerfile
FROM nginx

COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80
-------------------------------------------------------------------
docker build -t web1-munilla
