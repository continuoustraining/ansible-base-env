### Intro

This project aims to use ansible with docker containers. It allows the user to run ansible command as if they were executed directly from their host, while in fact, they are performed over an ansible docker container.
This is a base environment for practical exercices on Ansible during trainings and coachings.

### Diagram
![high level architecture](https://github.com/continuoustraining/ansible-base-env/blob/master/ansible.png?raw=true)

### Dependencies

```console
user@host:~$ pip3 install ansible
```

```console
user@host:~$ pip3 install docker-compose
```

### Deploying our base containers by using an ansible playbook

```console
user@host:~$ source ansible/aliases
```

```console
user@host:~$ ansible-playbook inline_docker_playbook.yml
```

Once the playbook has been played, aliases will be exported to the current user shell session, they will allow the current user to cast docker commands without caring about docker.

### Playbooks

Playbooks must be placed within `ansible/playbooks`

### Inventory

Inventory must be placed within `ansible/inventory`, a default inventory file is already placed, referencing the 'app' container as an host. You don't need IPs, because you are using docker, containers have hostnames.
Any container can be added to this inventory, has long as the pub ssh key is referenced in authorized_keys on the container (as a volume `"{{ playbook_dir }}/ansible/ansible.key.pub:/root/.ssh/authorized_keys"`), and that sshd is started by using an entrypoint.
If your lab requires several hosts, you need to replicate app's entrypoint and volume configurations for these containers.

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

