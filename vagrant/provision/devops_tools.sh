#!/bin/bash

echo "----------------------------------------------"
echo "-----> Starting 'devops-tools' script <-------"
echo "----------------------------------------------"

#####################
###### dbeaver ######
#####################

echo "----> Installing dbeaver..."

dbeaver_version="7.1.3"

apt-get -y install default-jdk
wget https://github.com/dbeaver/dbeaver/releases/download/${dbeaver_version}/dbeaver-ce_${dbeaver_version}_amd64.deb
dpkg -i dbeaver-ce_${dbeaver_version}_amd64.deb
rm -rf dbeaver-ce_${dbeaver_version}_amd64.deb

echo "--> dbeaver successfully installed."

####################
###### docker ######
####################

echo "----> Installing docker."

# Install docker
apt-get update && apt-get install -y apt-transport-https ca-certificates gnupg-agent software-properties-common \
&& curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
&& add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
&& apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io \
&& sudo usermod -aG docker vagrant

echo "--> docker successfully installed."

############################
###### docker-compose ######
############################

echo "----> Installing docker-compose"

curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
&& chmod +x /usr/local/bin/docker-compose

echo "--> docker-compose successfully installed."

##################
##### gradle #####
##################

# Download page: https://gradle.org/install/

gradle_version="6.5.1"

echo "----> Installing gradle"

mkdir /opt/gradle
cd /opt/gradle
wget https://services.gradle.org/distributions/gradle-${gradle_version}-bin.zip
unzip -d /opt/gradle gradle-${gradle_version}-bin.zip
rm -rf gradle-${gradle_version}-bin.zip
# Permanently add gradle to path
runuser -l vagrant -c "echo "PATH="$PATH:/opt/gradle/gradle-${gradle_version}/bin"" >> /home/vagrant/.profile"
gradle -v

echo "--> gradle successfully installed."

####################
####### helm #######
####################

# Download page: https://github.com/helm/helm/releases

helm_version="helm-v3.1.2-linux-amd64.tar.gz"

echo "----> Installing helm."

cd /tmp
wget https://get.helm.sh/$helm_version
tar -zxvf $helm_version
cp linux-amd64/helm /usr/local/bin/helm
rm -rf $helm_version linux-amd64/
echo "Helm Version --> $(helm version)"

echo "--> helm successfully installed."

#####################
###### kubectl ######
#####################

# Download page: https://github.com/kubernetes/kubectl/releases

kubectl_version="v1.17.4"

echo "----> Installing kubectl."

cd /tmp
curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/$kubectl_version/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
kubectl version
echo "kubectl Version --> $(kubectl version)"

echo "--> kubectl successfully installed."

######################
###### minikube ######
######################

# Download page: https://github.com/kubernetes/minikube/releases/

minikube_version="v1.12.1"

echo "----> Installing minikube."

cd /tmp
curl -Lo minikube https://github.com/kubernetes/minikube/releases/download/$minikube_version/minikube-linux-amd64
chmod +x minikube
cp minikube /usr/local/bin && rm minikube
echo "Minikube Version --> $(minikube version)"

echo "--> Minikube successfully installed."

######################
###### skaffold ######
######################

# Download page: https://skaffold.dev/docs/install/

echo "--> Installing skaffold."

cd /tmp
curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64
install skaffold /usr/local/bin/
rm skaffold
echo "skaffold Version --> $(skaffold version)"

echo "--> skaffold successfully installed."

#####################
###### vs-code ######
#####################

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
plugins=( "donjayamanne.githistory" "eamodio.gitlens" "hashicorp.terraform" "ivory-lab.jenkinsfile-support" "korekontrol.saltstack" "marcostazi.VS-code-vagrantfile" "mhutchie.git-graph" "mhutchie.git-graph" "ms-kubernetes-tools.vscode-kubernetes-tools" "ms-python.python" "redhat.vscode-yaml" "vscode-icons-team.vscode-icons" "vscoss.vscode-ansible" "wholroyd.jinja" "yzhang.markdown-all-in-one" "zhangciwu.swig-tpl")

for i in "${plugins[@]}"
do
  echo "--> Installing plugin $i"
  runuser -l vagrant -c "code --install-extension $i"
done

echo "--> vs-code successfully installed."

########################
###### favourites ######
########################

# # Help: https://itectec.com/ubuntu/ubuntu-add-app-to-favorites-from-command-line/

# echo "----> Updating favourites..."
# gsettings set org.gnome.shell favorite-apps "['firefox.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Software.desktop', 'code.desktop', 'org.gnome.Terminal.desktop', 'dbeaver.desktop']"