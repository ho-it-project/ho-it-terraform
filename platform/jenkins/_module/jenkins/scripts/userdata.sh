#!/bin/bash -ex

function waitForJenkins() {
    echo "Waiting jenkins to launch on 8080..."

    while ! nc -z localhost 8080; do
      sleep 0.1
    done

    echo "Jenkins launched"
}

function waitForPasswordFile() {
    echo "Waiting jenkins to generate password..."

    while [ ! -f /var/lib/jenkins/secrets/initialAdminPassword ]; do
      sleep 2
    done

    echo "Password created"
}

sudo apt update
sudo apt install -y openjdk-8-jdk jq git awscli nmap nfs-common

export JENKINS_HOME=/var/lib/jenkins
sudo mkdir -p $JENKINS_HOME

sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${efs_dns_name}:/ $JENKINS_HOME

wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
echo "deb http://pkg.jenkins.io/debian-stable binary/" | sudo tee -a /etc/apt/sources.list

sudo apt update
sudo apt install -y jenkins

sudo sed -i 's/Djava.awt.headless=true/Djava.awt.headless=true -Xmx2G -Xms2G -Dorg.apache.commons.jelly.tags.fmt.timeZone=Asia\/Seoul/g' /etc/default/jenkins

sudo systemctl start jenkins
