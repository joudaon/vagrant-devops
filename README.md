# ubuntu-devops

- [ubuntu-devops](#ubuntu-devops)
  - [Summary](#summary)
  - [Requirements](#requirements)
  - [How to deploy](#how-to-deploy)


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

