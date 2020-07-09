#!/bin/bash
docker run -d -u root \
--restart always \
-v /var/run/docker.sock:/var/run/docker.sock \
-v $(which docker):/usr/bin/docker \
-v $PWD/jenkins_home/:/var/jenkins_home \
-p 8090:8080 \
-p 5000:5000 \
-p 50000:50000 \
--name ci-jenkins \
jenkins/jenkins

#docker exec -i ci-jenkins cat /var/jenkins_home/secrets/initialAdminPassword

#--env-file=/var/jenkins_home/config/env.file  \