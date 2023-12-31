#!/bin/bash -ex

function waitForJenkins() {
    echo "Waiting for Jenkins to launch on 8080..."
    while ! nc -z localhost 8080; do
        sleep 0.1
    done
    echo "Jenkins launched"
}

function waitForPasswordFile() {
    echo "Waiting for Jenkins to generate password..."
    while [ ! -f /var/lib/jenkins/secrets/initialAdminPassword ]; do
        sleep 2
    done
    echo "Password created"
}

sudo apt update
sudo apt install -y openjdk-11-jdk jq git awscli nmap nfs-common net-tools docker.io 
# dockerd --experimental=true
# export DOCKER_BUILDKIT=1


export JENKINS_HOME=/var/lib/jenkins
sudo mkdir -p $JENKINS_HOME

# Replace ${efs_dns_name} with your actual EFS DNS name
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${efs_dns_name}:/ $JENKINS_HOME

# wget https://pkg.jenkins.io/debian-stable/binary/jenkins_2.414.2_all.deb
# sudo dpkg -i jenkins_2.414.2_all.deb
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update
sudo apt-get install jenkins
sudo sed -i 's/Djava.awt.headless=true/Djava.awt.headless=true -Xmx2G -Xms2G -Dorg.apache.commons.jelly.tags.fmt.timeZone=Asia\/Seoul/g' /etc/default/jenkins



sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl restart docker
sudo usermod -aG docker jenkins
sudo service jenkins restart
sudo -u jenkins -H sh -c "aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin ${aws_account_id}.dkr.ecr.ap-northeast-2.amazonaws.com"
#!/bin/bash -ex

# Create a script to perform docker login
echo "sudo -u jenkins -H sh -c 'aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin ${aws_account_id}.dkr.ecr.ap-northeast-2.amazonaws.com'" > /home/ubuntu/docker_login.sh
# Give execute permissions to the script
chmod +x /home/ubuntu/docker_login.sh
# Add a cron job to run the script
echo "0 * * * * ubuntu /home/ubuntu/docker_login.sh" | sudo tee -a /etc/crontab


sudo chown -R jenkins:jenkins /var/lib/jenkins
sudo mv jenkins.war jenkins.war.old

sudo systemctl start jenkins

sudo systemctl restart jenkins


waitForJenkins
waitForPasswordFile

echo "Jenkins installation and configuration completed."
