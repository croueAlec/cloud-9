# Cloud-9 (because I am always happy !)


## Introduction
The purpose of this project is to setup and deploy a project on machines using **Ansible**, an Infra-as-code tool.

Ansible uses control-nodes to deploy on remote nodes. It uses a set of Yaml instructions to produce an **idempotent** state.

### Testing

For testing purposes I made a vagrant file that creates remote nodes to apply a configuration to.

```sh
make basic_test
```
The basic test starts a single node using a Vagrantfile.

```sh
make advanced_test
```
The advanced test starts a network of 3 nodes using a Vagrantfile.

Both of those tests can be targeted using Ansible.
