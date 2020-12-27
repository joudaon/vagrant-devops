#!/bin/bash

## This is comment
: '
This script installs some DevOps tools
Tested against: Ubuntu 18.04.5 LTS
Latest update: 2020/12/26
'

echo "----------------------------------------------"
echo "-----> Starting 'devops-tools' script <-------"
echo "----------------------------------------------"

## Help: https://stackoverflow.com/questions/1298066/check-if-an-apt-get-package-is-installed-and-then-install-it-if-its-not-on-linu

## Define here versions and users

DBEAVER_VERSION="7.3.1"
DOCKER_COMPOSE_VERSION="1.27.4"
GRADLE_VERSION="6.5.1"
HELM_VERSION="helm-v3.4.2-linux-amd64.tar.gz"
K9S_VERSION="v0.24.2"
KUBECTL_VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
MINIKUBE_VERSION="v1.16.0"
TERRAFORM_VERSION="0.14.3"
VAGRANT_VERSION="2.2.14"
USER="vagrant"

#####################
###### aws-cli ######
#####################

# Help: https://docs.aws.amazon.com/es_es/cli/latest/userguide/install-cliv2-linux.html

if [ ! -f /usr/local/bin/aws ]; then

  echo "----> Installing aws-cli..."

  cd /tmp \
  && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip \
  && ./aws/install \
  && rm -rf awscliv2.zip \
  && echo "AWS-CLI Version --> $(aws --version)"

  echo "--> aws-cli successfully installed."

else

  echo "--> PACKAGE: 'aws' already installed!"

fi

####################
###### az-cli ######
####################

# Help: https://docs.microsoft.com/es-es/cli/azure/install-azure-cli?view=azure-cli-latest

if ! dpkg -s azure-cli > /dev/null; then

  echo "----> Installing az-cli..."

  curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
  echo "AZ-CLI Version --> $(az --version)"

  echo "--> az-cli successfully installed."

else

  echo "--> PACKAGE: 'azure-cli' already installed!"

fi

#####################
###### dbeaver ######
#####################

if ! dpkg -s dbeaver-ce > /dev/null; then

  echo "----> Installing dbeaver..."

  apt-get -y install default-jdk
  wget https://github.com/dbeaver/dbeaver/releases/download/${DBEAVER_VERSION}/dbeaver-ce_${DBEAVER_VERSION}_amd64.deb
  dpkg -i dbeaver-ce_${DBEAVER_VERSION}_amd64.deb
  rm -rf dbeaver-ce_${DBEAVER_VERSION}_amd64.deb

  echo "--> dbeaver successfully installed."

else

  echo "--> PACKAGE: 'dbeaver-ce' already installed!"

fi

####################
###### docker ######
####################

if ! dpkg -s docker-ce > /dev/null; then

  echo "----> Installing docker."

  # Install docker
  apt-get update && apt-get install -y apt-transport-https ca-certificates gnupg-agent software-properties-common \
  && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
  && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  && apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io \
  && sudo usermod -aG docker ${USER}

  echo "--> docker successfully installed."

else

  echo "--> PACKAGE: 'docker-ce' already installed!"

fi

############################
###### docker-compose ######
############################

if [ ! -f /usr/local/bin/docker-compose ]; then

  echo "----> Installing docker-compose"

  curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
  && chmod +x /usr/local/bin/docker-compose

  echo "--> docker-compose successfully installed."

else

  echo "--> PACKAGE: 'docker-compose' already installed!"

fi

##################
##### gradle #####
##################

# Download page: https://gradle.org/install/

if [ ! -d /opt/gradle ]; then

  echo "----> Installing gradle"

  mkdir /opt/gradle
  cd /opt/gradle
  wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
  unzip -d /opt/gradle gradle-${GRADLE_VERSION}-bin.zip
  rm -rf gradle-${GRADLE_VERSION}-bin.zip
  # Permanently add gradle to path
  runuser -l vagrant -c "echo "PATH="$PATH:/opt/gradle/gradle-${GRADLE_VERSION}/bin"" >> /home/vagrant/.profile"
  gradle -v

  echo "--> gradle successfully installed."

else

  echo "--> PACKAGE: 'gradle' already installed!"

fi

####################
####### helm #######
####################

# Download page: https://github.com/helm/helm/releases

if [ ! -f /usr/local/bin/helm ]; then

  echo "----> Installing helm."

  cd /tmp
  wget https://get.helm.sh/$HELM_VERSION
  tar -zxvf $HELM_VERSION
  cp linux-amd64/helm /usr/local/bin/helm
  rm -rf $HELM_VERSION linux-amd64/
  echo "Helm Version --> $(helm version)"

  echo "--> helm successfully installed."

else

  echo "--> PACKAGE: 'helm' already installed!"

fi

####################
##### intellij #####
####################

# Download page: https://www.jetbrains.com/idea/download/other.html

intellij_version="2020.2"

echo "----> Installing intellij."

snap install intellij-idea-community --classic

echo "--> intellij successfully installed."

#################
###### k9s ######
#################

if [ ! -f /usr/local/bin/k9s ]; then

  cd /tmp
  wget https://github.com/derailed/k9s/releases/download/$K9S_VERSION/k9s_Linux_x86_64.tar.gz
  tar -zxvf k9s_Linux_x86_64.tar.gz
  cp k9s /usr/local/bin/k9s

  rm -rf k9s_Linux_x86_64.tar.gz k9s LICENCE README.md
  echo "k9s Version --> $(k9s version)"

  echo "--> k9s successfully installed."

else

  echo "--> PACKAGE: 'k9s' already installed!"

fi

#####################
###### kubectl ######
#####################

# Download page: https://github.com/kubernetes/kubectl/releases

if [ ! -f /usr/local/bin/kubectl ]; then

  echo "----> Installing kubectl."

  cd /tmp
  curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl
  chmod +x kubectl
  sudo mv ./kubectl /usr/local/bin/kubectl
  kubectl version
  echo "kubectl Version --> $(kubectl version)"

  echo "--> kubectl successfully installed."

else

  echo "--> PACKAGE: 'kubectl' already installed!"

fi

###################
###### maven ######
###################

if ! dpkg -s maven > /dev/null; then

  echo "----> Installing mvn."

  apt-get update
  apt-get install -y maven
  echo "maven Version --> $(mvn -version)"

  echo "--> mvn successfully installed."

else

  echo "--> PACKAGE: 'maven' already installed!"

fi

######################
###### minikube ######
######################

# Download page: https://github.com/kubernetes/minikube/releases/

if [ ! -f /usr/local/bin/minikube ]; then

  echo "----> Installing minikube."

  cd /tmp
  curl -Lo minikube https://github.com/kubernetes/minikube/releases/download/$MINIKUBE_VERSION/minikube-linux-amd64
  chmod +x minikube
  cp minikube /usr/local/bin && rm minikube
  echo "Minikube Version --> $(minikube version)"

  echo "--> Minikube successfully installed."

else

  echo "--> PACKAGE: 'minikube' already installed!"

fi

######################
###### skaffold ######
######################

# Download page: https://skaffold.dev/docs/install/

if [ ! -f /usr/local/bin/skaffold ]; then

  echo "--> Installing skaffold."

  cd /tmp
  curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64
  install skaffold /usr/local/bin/
  rm skaffold
  echo "skaffold Version --> $(skaffold version)"

  echo "--> skaffold successfully installed."

else

  echo "--> PACKAGE: 'skaffold' already installed!"

fi

#####################
#### terraform ######
#####################

if [ ! -f /usr/local/bin/terraform ]; then

  cd /tmp 
  wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
  unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
  rm -rf terraform_${TERRAFORM_VERSION}_linux_amd64.zip
  mv terraform /usr/local/bin/terraform
  echo "--> Terraform version: $(terraform version)"

else

  echo "--> PACKAGE: 'terraform' already installed!"

fi

#####################
###### vagrant ######
#####################

if ! dpkg -s vagrant > /dev/null; then

  echo "----> Installing vagrant..."

  wget https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_x86_64.deb
  dpkg -i vagrant_${VAGRANT_VERSION}_x86_64.deb
  rm -rf vagrant_${VAGRANT_VERSION}_x86_64.deb

  echo "Vagrant version --> $(vagrant -v)"
  echo "--> vagrant successfully installed."

else

  echo "--> PACKAGE: 'vagrant' already installed!"

fi

#####################
###### vs-code ######
#####################

if ! dpkg -s code > /dev/null; then

  echo "----> Installing vs-code..."

  # Download and install vs-code
  apt-get update
  apt-get install -y software-properties-common apt-transport-https wget
  wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -
  add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
  apt-get update
  apt-get install -y code

  # Fix: https://askubuntu.com/questions/760896/how-can-i-fix-apt-error-w-target-packages-is-configured-multiple-times
  rm -rf /etc/apt/sources.list.d/vscode.list

  # Install plugins from cli - https://code.visualstudio.com/docs/editor/extension-gallery
  plugins=( "donjayamanne.githistory" "eamodio.gitlens" "hashicorp.terraform" "ivory-lab.jenkinsfile-support" "korekontrol.saltstack" "marcostazi.VS-code-vagrantfile" "mhutchie.git-graph" "mhutchie.git-graph" "ms-azuretools.vscode-docker" "ms-kubernetes-tools.vscode-kubernetes-tools" "ms-python.python" "redhat.vscode-yaml" "vscode-icons-team.vscode-icons" "vscoss.vscode-ansible" "wholroyd.jinja" "yzhang.markdown-all-in-one" "zhangciwu.swig-tpl")

  for i in "${plugins[@]}"
  do
  echo "--> Installing plugin $i"
  runuser -l ${USER} -c "code --install-extension $i"
  done

  echo "--> vs-code successfully installed."

else

  echo "--> PACKAGE: 'vs-code' already installed!"

fi

########################
###### favourites ######
########################

# # Help: https://itectec.com/ubuntu/ubuntu-add-app-to-favorites-from-command-line/

# echo "----> Updating favourites..."
# gsettings set org.gnome.shell favorite-apps "['firefox.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Software.desktop', 'code.desktop', 'org.gnome.Terminal.desktop', 'dbeaver.desktop']"