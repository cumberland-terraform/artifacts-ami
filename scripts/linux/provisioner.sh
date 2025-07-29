#!/bin/bash
set -e # Exit immediately if a command fails

# 1. Apply all system updates
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get upgrade -y

# 2. Install Git
sudo apt-get install -y git

# 3. Install Docker Engine
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker ubuntu
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# 4. Install the SSM Agent
sudo snap wait system seed.loaded
sudo snap install amazon-ssm-agent --classic
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent