#!/usr/bin/env bash
ssh -o StrictHostKeyChecking=no \
    -i /var/jenkins_home/.ssh/keys/docker-for-aws.pem \
    docker@$1 \
    docker service create --name spring-petclinic --publish published=9966,target=9966 diligentsoft/spring-petclinic:$2
