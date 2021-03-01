docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker rmi $(docker images)
docker build -t server .
docker run -p 80:80  -p 22:22 -it server
