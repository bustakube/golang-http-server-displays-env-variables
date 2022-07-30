#!/bin/bash

docker build -t $(cat Dockerfile | grep dockerhub | awk '{print $2}') .
