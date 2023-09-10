#!/bin/bash -ex

mkdir -p /etc/ecs
echo "ECS_CLUSTER=${ecs_cluster_name}" >> /etc/ecs/ecs.config
echo "ECS_INSTANCE_ATTRIBUTES={\"type\": \"kafka${kafka_num}\"}" >> /etc/ecs/ecs.config
# micro instance 스왑메모리 사용...
sudo dd if=/dev/zero of=/swapfile bs=64M count=32
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
# start ecs