#!/bin/bash

docker push $(cat Dockerfile | grep dockerhub | awk '{print $2}') 
