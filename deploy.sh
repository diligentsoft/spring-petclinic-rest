ssh -o StrictHostKeyChecking=no \
    -i /var/jenkins_home/.ssh/keys/docker-for-aws.pem \
    docker@$1 \
    /home/docker/deploy.sh diligentsoft/spring-petclinic $2 spring-petclinic 9966
