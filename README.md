### Intro

This project aims to use ansible with docker containers. It allows the user to run ansible command as if they were executed directly from their host, while in fact, they are performed over an ansible docker container.
This is a base environment for practical exercices on Ansible during trainings and coachings.

### Diagram
![high level architecture](https://github.com/continuoustraining/ansible-base-env/blob/master/ansible.png?raw=true)

### Dependencies

* Install docker for your system

* Install pip3 for your system

* Add user to docker group, in order to use Ansible with your current user in order to deploy our stack

```console
user@host:~$ sudo usermod -aG docker $USER
```

* Install ansible on your system

```console
user@host:~$ pip3 install ansible
```
* Install docker-compose using pip3 (needed for docker_compose module we use in our initial playbook)

```console
user@host:~$ pip3 install docker-compose
```

### Deploying our base containers by using an ansible playbook

```console
user@host:~$ ansible-playbook inline_docker_playbook.yml
```

### Sourcing aliases in order to use dockerized ansible in place of localhost ansible

```console
user@host:~$ source ansible/aliases
```

Once the playbook has been played, aliases will be exported to the current user shell session, they will allow the current user to cast docker commands without caring about docker.

### Playbooks

Playbooks must be placed within `ansible/playbooks`

### Inventory

Inventory must be placed within `ansible/inventory`, a default inventory file is already placed, referencing the 'app' container as an host. You don't need IPs, because you are using docker, containers have hostnames.
Any container can be added to this inventory, has long as the pub ssh key is referenced in authorized_keys on the container (as a volume `"{{ playbook_dir }}/ansible/ansible.key.pub:/root/.ssh/authorized_keys"`), and that sshd is started by using an entrypoint.
If your lab requires several hosts, you need to replicate app's entrypoint and volume configurations for these containers.
Please specify a container_name if you add another container to the stack, then edit run checks.

app entrypoint script: we start our ssh server, then we listen to any command:

```bash
#!/bin/sh
set -x
/usr/sbin/sshd -D
exec "$@"
```

### Playing a test playbook

A test playbook has been placed within ansible/playbooks, it will setup nginx on 'app' by using apt-get, and will start the service.

```console
user@host:~$ ansible-playbook -i ansible/inventory/inventory.yml  ansible/playbooks/test.yml
```

### Troubleshooting

```
fatal: [app]: UNREACHABLE! => {"changed": false, "msg": "Failed to connect to the host via ssh: Warning: Permanently added 'app,172.22.0.2' (ECDSA) to the list of known hosts.\r\nPermission denied (publickey,password).", "unreachable": true}
```
Means that your aliases have not been sourced after the initial playbook, app can't be accessed outside of your docker network, please source the aliases.

```console
user@host:~$ source ansible/aliases
```


