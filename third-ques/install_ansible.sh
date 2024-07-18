#!/bin/bash

sudo apt update
sudo apt install ansible -y

ssh-keygen -t rsa
ssh-copy-id user@10.12.13.14
ssh-copy-id user@10.13.12.14
ssh-copy-id user@13.10.12.15
