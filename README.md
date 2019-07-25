### Intro

This project aims to use ansible with docker containers. It allows the user to run ansible command as if they were executed directly from their host, while in fact, they are performed over an ansible docker container.
This is a base environment for practical exercices on Ansible during trainings and coachings.

### Diagram


### Dependencies
* `pip3 install ansible`
* `pip3 install docker-compose`

### Deploying our base containers by using an ansible playbook
* `$ source ansible/aliases`
* `$ ansible-playbook inline_docker_playbook.yml`

Once the playbook has been played, aliases will be exported to the current user shell session, they will allow the current user to cast docker commands without caring about docker.

### Playbooks

Playbooks must be placed within `ansible/playbooks`

### Inventory

Inventory must be placed within `ansible/inventory`, a default inventory file is already placed, referencing the 'app' container as an host. You don't need IPs, because you are using docker, containers have hostnames.

### Playing a test playbook

A test playbook has been placed within ansible/playbooks, it will setup nginx on 'app' by using apt-get, and will start the service.

`$ ansible-playbook -i ansible/inventory/inventory.yml  ansible/playbooks/test.yml`

