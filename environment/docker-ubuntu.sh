#!/bin/bash
## DOCKER ##
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y &&
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&
sudo sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" &&
sudo apt update &&
sudo apt-cache policy docker-ce &&
sudo apt install docker-ce docker-ce-cli containerd.io -y &&
sudo usermod -aG docker ${USER} &&
docker --version

## Docker Machine
base=https://github.com/docker/machine/releases/download/v0.16.0 &&
  curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
  sudo mv /tmp/docker-machine /usr/local/bin/docker-machine &&
  chmod +x /usr/local/bin/docker-machine

# To enable the docker-machine shell prompt, add $(__docker_machine_ps1) to your PS1 setting in ~/.bashrc.
#PS1='[\u@\h \W$(__docker_machine_ps1)]\$ '

#Bash Completion scripts
base=https://raw.githubusercontent.com/docker/machine/v0.16.0
for i in docker-machine-prompt.bash docker-machine-wrapper.bash docker-machine.bash
do
  sudo wget "$base/contrib/completion/bash/${i}" -P /etc/bash_completion.d
done

# Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose &&
sudo chmod +x /usr/local/bin/docker-compose && 
sudo docker-compose --version
