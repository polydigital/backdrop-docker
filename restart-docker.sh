#!/bin/bash
# I just use this to help me quickly restart my docker
# whilst I am developing - we should look at better ways
docker-compose down
rm -rf build/ composer.lock mysql/ vendor/ .drush

#update host IP in environment vars to write to docker
#container hosts files https://github.com/polydigital/backdrop-civicrm-docker/issues/15
source .env
newhostip=`ip -4 addr show scope global dev docker0 | grep inet | awk '{print \$2}' | cut -d / -f 1`
sed -i "s@\b${HOST_MACHINE_IP}\b@${newhostip}@g" .env

docker-compose up
docker logs -f backdrop
