#!/bin/bash
source ./check-os-fam.sh
case $(get_distro) in
     ubuntu)
        # Installation
        sudo apt update
        # Git Python
        sudo apt-get -y install git python3-pip
        # Ansible
        python3 -m pip install --user ansible
        # Docker
        curl -fsSL get.docker.com -o get-docker.sh
        chmod u+x get-docker.sh
        sudo sh ./get-docker.sh
        # Docker Compose
        sudo wget --output-document=/usr/local/bin/docker-compose "https://github.com/docker/compose/releases/download/$(wget --quiet --output-document=- https://api.github.com/repos/docker/compose/releases/latest | grep --perl-regexp --only-matching '"tag_name": "\K.*?(?=")')/run.sh"
        sudo chmod +x /usr/local/bin/docker-compose
        sudo wget --output-document=/etc/bash_completion.d/docker-compose "https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose"
        printf '\nDocker Compose installed successfully\n\n'
        # Vagrant 
        sudo apt install virtualbox
        wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
        echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
        sudo apt update && sudo apt install vagrant
        ;;
     centos)
        ###
        sudo dnf -y install git-all python3-pip
        python3 -m pip install --user ansible
        ###
        ;;
esac