#!/bin/bash

image=$(cat Dockerfile | grep dockerhub | awk '{print $2}')
container=test-$(echo $image | sed 's/\//_/g')

port=$(cat Dockerfile | grep testport | awk '{print $2}')

if [ $(which jq | grep -c 'not found') -gt 0 ] ; then
   echo "jq required for this test"
   exit 1
fi

echo ""
echo "Running image $image as container name $container..."
docker run -d --name=$container $image

ip=$(docker inspect $container | jq -r '.[0] | .NetworkSettings.Networks.bridge.IPAddress')
url="http://$ip:$port"

echo ""
echo "Testing container $container with an HTTP request to $url - output follows:"
echo ""
curl $url
echo ""
echo "===== LOG OUTPUT ====="
docker logs $container
echo ""
echo "Deleting container $container"
docker rm -f $container
echo ""
