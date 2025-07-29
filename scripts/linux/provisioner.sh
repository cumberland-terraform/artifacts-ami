#!/bin/bash
set -e # Exit immediately if a command fails

# 1. Remove the problematic command-not-found utility
export DEBIAN_FRONTEND=noninteractive
sudo apt-get remove -y command-not-found
sudo apt-get autoremove -y

# 2. Apply all system updates
sudo apt-get update
sudo apt-get upgrade -y

# 3. Install Git
sudo apt-get install -y git

# 4. Install Docker Engine
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker ubuntu
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# 5. Install the SSM Agent
sudo snap wait system seed.loaded
sudo snap install amazon-ssm-agent --classic
sudo systemctl enable snap.amazon-ssm-agent.amazon-ssm-agent.service
sudo systemctl start snap.amazon-ssm-agent.amazon-ssm-agent.service