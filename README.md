# ubuntu-devops

- [ubuntu-devops](#ubuntu-devops)
  - [Summary](#summary)
  - [Requirements](#requirements)
  - [How to deploy](#how-to-deploy)
  - [Packages](#packages)
  - [Useful links](#useful-links)
  - [TODO](#todo)

## Summary

The aim of this project is to deploy an Ubuntu Desktop environment with all required DevOps tools installed.

## Requirements

| Packer version | Virtualbox version               |
| -------------- | -------------------------------- |
| v1.6.0         | Version 6.1.10 r138449 (Qt5.9.5) |

| Vagrant version |
| --------------- |
|  v2.2.9         |

## How to deploy

First we create a clean Ubuntu Desktop box using `packer`:

```sh
$> cd packer
$> packer build -var-file=ubuntu1804-desktop.json ubuntu.json
  ** If it gets stuck try again
```

Then, using `vagrant` we deploy the Ubuntu Desktop box and we install all the required tools:

```sh
$> cd vagrant
$> vagrant up
```

Finally, log in into Ubuntu Desktop with the following credentials: `vagrant/vagrant`.

## Packages

The following packages will be installed (you can update them on `vagrant/provision/devops_tools.sh`):

- [aws-cli](https://aws.amazon.com/cli/?nc1=h_ls) - The AWS Command Line Interface (CLI) is a unified tool to manage your AWS services.
- [az-cli](https://docs.microsoft.com/en-gb/cli/azure/install-azure-cli?view=azure-cli-latest) - The Azure command-line interface (Azure CLI) is a set of commands used to create and manage Azure resources.
- [dbeaver](https://dbeaver.io/) - Free multi-platform database tool for developers, database administrators, analysts and all people who need to work with databases.
- [docker](https://www.docker.com/) - Docker is a set of platform as a service (PaaS) products that use OS-level virtualization to deliver software in packages called containers.
- [docker-compose](https://docs.docker.com/compose/) - Compose is a tool for defining and running multi-container Docker applications. 
- [gradle](https://gradle.org/) - Gradle is an open-source build automation tool focused on flexibility and performance. 
- [helm](https://helm.sh/) - Helm is the best way to find, share, and use software built for Kubernetes.
- [intellij](https://www.jetbrains.com/idea/) - IntelliJ is an integrated development environment (IDE) written in Java for developing computer software. 
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) - kubectl, allows you to run commands against Kubernetes clusters. 
- [maven](https://maven.apache.org/) - Apache Maven is a software project management and comprehension tool.
- [minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/) - Minikube is a tool that runs a single-node Kubernetes cluster in a virtual machine on your personal computer.
- [skaffold](https://skaffold.dev/) - Skaffold handles the workflow for building, pushing and deploying your application, allowing you to focus on what matters most: writing code.
- [vs-code](https://code.visualstudio.com/) - Visual Studio Code is a free source-code editor made by Microsoft for Windows, Linux and macOS.

## Useful links

- [Packer templates for Ubuntu](https://github.com/boxcutter/ubuntu)
- [packer-ubuntu-18-bionic](https://github.com/aravindkumarsvg/packer-ubuntu-18-bionic)
- [packer-ubuntu-18.04](https://github.com/heizo/packer-ubuntu-18.04)
- [System Monitor: How to display net speed on panel](https://askubuntu.com/questions/866990/system-monitor-how-to-display-net-speed-on-panel)

## TODO

- fix: `preseed.cfg` to generate `/dev/sda1` instead of `/dev/mapper/ubuntu--vg--root` to enable disk resize in vagrant.
- fix: `change_keyboard_layout.sh` script, it doesn't work.