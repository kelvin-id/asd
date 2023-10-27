# asd
⚡ Accelerated Software Development / 🚀 Automated Service Deployment

## 📢 Notice

This is a proof of concept piece of work aiming to prove the viability of developing in containers.

Tested on: 
- Windows 10 + WSL2 + Rancher Desktop 1.9.1
- Ubuntu 22.04 + Docker CE 

## 📋   Requirements

- [docker](https://docs.docker.com/engine/install/) with the docker compose plugin
    - For Windows go with [Rancher Desktop](https://rancherdesktop.io/) and use [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install)
- [make](https://www.gnu.org/software/make/) for project orchestration
    - `sudo apt install make` | `choco install make` | `brew install make`
- commands are to be executed in `bash`, `zsh` or `git-bash`

## 🔧   Configuration

All environment settings or overrides should be in "workspace/config/.env"

- run `make` in your terminal to configure and validate your environment

## 🐳   Launch containers

Assuming the docker engine is running.

- run `make start` and in the browser go to "https://code.localhost"

## 🐞   Issues

- WIP: The browser is unhappy with https!
