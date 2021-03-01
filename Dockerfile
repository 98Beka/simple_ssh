FROM  alpine:latest

RUN apk update && apk upgrade
RUN apk add nginx vim openrc openssh-server

#nginx
RUN mkdir /run/nginx; 
RUN rm /etc/nginx/http.d/default.conf;
RUN echo -e "server {       \n\
    listen      80;         \n\
    listen      [::]:80;    \n\
    server_name localhost;  \n\
}" > /etc/nginx/http.d/default.conf;


# create SSH key ssh
RUN sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
  && echo "root:root" | chpasswd \
  && /usr/bin/ssh-keygen -A \
  && ssh-keygen -t rsa -b 4096 -f  /etc/ssh/ssh_host_key
  
RUN openrc; touch /run/openrc/softlevel;
RUN /etc/init.d/sshd start;
EXPOSE 80 22
ENTRYPOINT   rc-ssh start rc-service nginx start; sh;