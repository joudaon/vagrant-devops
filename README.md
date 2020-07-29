# ubuntu-devops

This project is an extension of this one: https://github.com/boxcutter/ubuntu

The aim of this project is to deploy an Ubuntu Desktop with all required DevOps tools installed.

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