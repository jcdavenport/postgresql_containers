#!/bin/bash


#setting up the java/postgresql environment:
clear
printf "\nBuilding the lab environment...\n"

sleep 1

#container manager
#172.17.0.2:80
printf "\n-> starting container manager\n"
docker run -it --rm --name boss \
           --expose=80 \
           -d rancher/server

sleep 2

#172.17.0.3:5432
printf "\n-> starting postgresql server\n"
docker run -it --rm --name pgsdb1 \
           -v pgsdb1:/bitnami \
           -e POSTGRESQL_PASSWORD=toor \
           -d bitnami/postgresql:latest

sleep 2

#172.17.0.4:5050
printf "\n-> starting pgAdmin4\n"
docker run --rm --name pgadmn1 \
           --link pgsdb1:postgres \
           --expose=5050 \
           -d fenglc/pgadmin4

#           -e DEFAULT_USER=pgadmin1 \    default 'pgadmin4@pgadmin.org'
#           -e DEFAULT_PASS=pgpass1 \     default 'admin'


sleep 2

#vnc: localhost:5900
printf "\n-> starting ubuntu vnc at localhost:5900\n"
docker run -it --rm -p 5900:5900 \
           -v ubuntu_vnc:/appdata \
           --name ubuzr --hostname ubuzr \
           --link pgadmn1:pgadmin \
           -d dorowu/ubuntu-desktop-lxde-vnc

#docker run -it --rm -p 5666:5900 \
#       -v $HOST_VOL1:$CONT_VOL1 \
#       -v $HOST_VOL2:$CONT_VOL2 \
#       --name jxdx_labs --hostname jxdx-labs \
#       -e RESOLUTION=1536x864  \
#      -d jxdx_labs:latest

sleep 1
printf "\n\n...done\n\nCONNECT WITH VNC VIEWER AT [localhost:5900]\n"


