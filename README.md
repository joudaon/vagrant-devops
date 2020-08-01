# ubuntu-devops

- [ubuntu-devops](#ubuntu-devops)
  - [Summary](#summary)
  - [Requirements](#requirements)
  - [How to deploy](#how-to-deploy)
  - [Packages](#packages)
  - [Vagrant plugins](#vagrant-plugins)
  - [Useful links](#useful-links)
  - [TODO](#todo)

## Summary

The aim of this project is to deploy an Ubuntu Desktop environment with all required DevOps tools installed.

In order to achieve this, the project has been splitted into 2 parts, `packer` and `vagrant` folders. The first one is required to create and empty Ubuntu Desktop `vagrant box`. The second one deployes Ubuntu Desktop environment using the `Vagrantfile`.

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

Packer deployment can take up to ~35 minutes (depending on your internet connection):

```sh
$> packer build -var-file=ubuntu1804-desktop.json ubuntu.json

real    35m56.778s
user    0m31.550s
sys     0m28.679s
```

Then, using `vagrant` we deploy the Ubuntu Desktop box and we install all the required tools:

```sh
$> cd vagrant
$> vagrant up
```

Vagrant deployment can take up to 20 minutes (depending on your internet connection):

```sh
$> time vagrant up

real    19m48.447s
user    0m11.027s
sys     0m25.456s
```

Finally, log in into Ubuntu Desktop with the following credentials: `vagrant/vagrant`.

## Packages

The following packages will be installed on Ubuntu Desktop vm (you can update them on `vagrant/provision/devops_tools.sh`):

- [aws-cli](https://aws.amazon.com/cli/) - The AWS Command Line Interface (CLI) is a unified tool to manage your AWS services.
- [az-cli](https://docs.microsoft.com/en-gb/cli/azure/install-azure-cli) - The Azure command-line interface (Azure CLI) is a set of commands used to create and manage Azure resources.
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

## Vagrant plugins

The `Vagrantfile` is smart enough to run some actions if some plugins are installed or not, but it is highly recommended to install the following plugins:

- [vagrant-cachier](https://github.com/fgrehm/vagrant-cachier)
- [vagrant-disksize](https://github.com/sprotheroe/vagrant-disksize)
- [vagrant-hosts](https://github.com/oscar-stack/vagrant-hosts)
- [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest) 

```sh
$ vagrant plugin install vagrant-cachier vagrant-disksize vagrant-hosts vagrant-vbguest
```

## Useful links

- [Packer templates for Ubuntu](https://github.com/boxcutter/ubuntu)
- [packer-ubuntu-18-bionic](https://github.com/aravindkumarsvg/packer-ubuntu-18-bionic)
- [packer-ubuntu-18.04](https://github.com/heizo/packer-ubuntu-18.04)
- [System Monitor: How to display net speed on panel](https://askubuntu.com/questions/866990/system-monitor-how-to-display-net-speed-on-panel)
- [Using d-i partman recipe strings?](https://unix.stackexchange.com/questions/341253/using-d-i-partman-recipe-strings)
- [Partman y preseed, error de particionamiento](https://www.it-swarm.dev/es/partitioning/partman-y-preseed-error-de-particionamiento/961380979/)
- [preseed-fragment.seed](https://gist.github.com/lorin/5140029)
- [How to automatically resize virtual box disk with vagrant](https://medium.com/@kanrangsan/how-to-automatically-resize-virtual-box-disk-with-vagrant-9f0f48aa46b3)
- [Ubuntu: Extending a virtualized disk when using LVM](https://fabianlee.org/2016/07/26/ubuntu-extending-a-virtualized-disk-when-using-lvm/)
- [Vagrant shared and synced folders](https://stackoverflow.com/questions/18528717/vagrant-shared-and-synced-folders)

## TODO

- fix: `change_keyboard_layout.sh` script, it doesn't work.