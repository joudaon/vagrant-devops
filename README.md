# ubuntu-devops

- [ubuntu-devops](#ubuntu-devops)
  - [Summary](#summary)
  - [Requirements](#requirements)
  - [How to deploy](#how-to-deploy)
  - [Packages](#packages)

## Summary

This project is an extension of this one: https://github.com/boxcutter/ubuntu

The aim of this project is to deploy an Ubuntu Desktop with all required DevOps tools installed.

## Requirements

| Packer version | Virtualbox version               |
| -------------- | -------------------------------- |
| v1.6.0         | Version 6.1.10 r138449 (Qt5.9.5) |

| Vagrant version |
| --------------- |
|  v2.2.9         |

## How to deploy

First we create a clean Ubuntu Desktop box using packer:

```sh
$> cd packer
$> packer build -var-file=ubuntu1804-desktop.json ubuntu.json
  ** If it gets stuck try again
```

Then, using vagrant we deploy the Ubuntu Desktop box and we configure it:

```sh
$> cd vagrant
$> vagrant up
```

## Packages

The following packages will be installed (you can update them on `vagrant/provision/devops_tools.sh`):

- aws-cli
- dbeaver
- docker
- docker-compose
- gradle
- helm
- kubectl
- maven
- minikube
- skaffold
- vs-code

https://askubuntu.com/questions/866990/system-monitor-how-to-display-net-speed-on-panel