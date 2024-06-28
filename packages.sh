#!/bin/bash

export DEBIAN_FRONTEND=noninteractive


## Installing simple package & commands:####
sudo apt-get update && \
sudo apt-get install -f
sudo apt-get install -y apt-utils  build-essential wget python3-venv python3-pip vim   && \
sudo apt-get install -y  default-jre default-jdk htop mysql-server maven openssh-server watch

## Installing tree{ tree comes from apt-repository universe}
sudo add-apt-repository universe
sudo apt-get install -y tree


# Installing postgreSQL client
sudo apt-get update && sudo apt-get install -y postgresql-client-common postgresql-client-14

## Installing Node.js(Node.js v20.x:){ IT COMES WITH npm}
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - &&\
sudo apt-get install -y nodejs

## Install Docker
# https://docs.docker.com/engine/install/ubuntu/
sudo apt-get remove docker docker-engine docker.io containerd runc -y
sudo apt-get update
sudo apt-get install \
        ca-certificates \
        curl \ c6i.8xlarge
        gnupg \
        lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.gpg
sudo apt-get update
sudo apt install docker-ce docker-ce-cli containerd.io -y
sudo systemctl start docker
sudo systemctl enable docker

## chmod the Docker socket. the Docker daemon does not have the necessary permissions to access the Docker socket file located at /var/run/docker.sock
sudo chown root:docker /var/run/docker.sock
sudo chmod 666 /var/run/docker.sock

## Install Docker Coompose
# https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version




## Install Helm 3
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
sudo  chmod 700 get_helm.sh
sudo ./get_helm.sh
sudo helm version


## Install trivy
sudo apt-get -y update
sudo apt-get install wget apt-transport-https -y
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get -y update
sudo apt-get install trivy -y



 ## Install kubectl
sudo curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.9/2020-08-04/bin/linux/amd64/kubectl 
sudo chmod +x ./kubectl 
sudo mv kubectl /usr/local/bin/

## INSTALL KUBECTX AND KUBENS
sudo wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx 
sudo wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens 
sudo chmod +x kubectx kubens 
sudo mv kubens kubectx /usr/local/bin

## Install Packer
# https://developer.hashicorp.com/packer/downloads
sudo wget https://releases.hashicorp.com/packer/1.7.4/packer_1.7.4_linux_amd64.zip -P /tmp
sudo unzip /tmp/packer_1.7.4_linux_amd64.zip -d /usr/local/bin
chmod +x /usr/local/bin/packer
packer --version

## Install ArgoCD agent
wget https://github.com/argoproj/argo-cd/releases/download/v2.8.5/argocd-linux-amd64
chmod +x argocd-linux-amd64
sudo mv argocd-linux-amd64 /usr/local/bin/argocd

pip3 install --upgrade pip
vim ~/.bashrc
echo 'export PATH="$HOME/.local/bin:$PATH"'

# Install sonar-scanner CLI
# https://github.com/SonarSource/sonar-scanner-cli/releases
sonar_scanner_version="5.0.1.3006"                 
wget -q https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${sonar_scanner_version}-linux.zip
unzip sonar-scanner-cli-${sonar_scanner_version}-linux.zip
sudo mv sonar-scanner-${sonar_scanner_version}-linux sonar-scanner
sudo rm -rf  /var/opt/sonar-scanner || true
sudo mv sonar-scanner /var/opt/
sudo rm -rf /usr/local/bin/sonar-scanner || true
sudo ln -s /var/opt/sonar-scanner/bin/sonar-scanner /usr/local/bin/ || true
sonar-scanner -v



## Terraform version 1.0.0
## https://releases.hashicorp.com/terraform/
TERRAFORM_VERSION="1.0.0"
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
mv terraform /usr/local/bin/
terraform --version
rm -rf terraform_${TERRAFORM_VERSION}_linux_amd64.zip

### TERRAGRUNT INSTALLATION
# https://terragrunt.gruntwork.io/docs/getting-started/supported-terraform-versions/
TERRAGRUNT_VERSION="v0.38.0"
sudo wget https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 
sudo mv terragrunt_linux_amd64 terragrunt 
sudo chmod u+x terragrunt 
sudo mv terragrunt /usr/local/bin/terragrunt
terragrunt --version

## Install grype
## https://github.com/anchore/grype/releases
GRYPE_VERSION="0.66.0"
wget https://github.com/anchore/grype/releases/download/v${GRYPE_VERSION}/grype_${GRYPE_VERSION}_linux_amd64.tar.gz
tar -xzf grype_${GRYPE_VERSION}_linux_amd64.tar.gz
chmod +x grype
sudo mv grype /usr/local/bin/
grype version


## Install Gradle
## https://gradle.org/releases/
GRADLE_VERSION="4.10"
sudo apt install openjdk-11-jdk -y
wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
unzip gradle-${GRADLE_VERSION}-bin.zip
mv gradle-${GRADLE_VERSION} /opt/gradle-${GRADLE_VERSION}
/opt/gradle-${GRADLE_VERSION}/bin/gradle --version

## Installing awscli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip
rm -rf aws 

## Installing Ansible
python3 -m pip install --user ansible 
echo 'export PATH="$PATH:/home/ansible/.local/bin"' >> ~/.bashrc
## Reload .bashrc to apply changes immediately
