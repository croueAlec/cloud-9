# Cloud-9 (because I am always happy !)


## Introduction
The purpose of this project is to setup and deploy a project on machines using **Ansible**, an Infra-as-code tool.

Ansible uses control-nodes to deploy on remote nodes. It uses a set of Yaml instructions to produce an **idempotent** state.

### Testing

For testing purposes I made a vagrant file that creates remote nodes to apply a configuration to.
It's purpose is to create automatically a Virtual Machine.

```sh
make basic_test
```
The basic test starts a single node using a Vagrantfile.

```sh
make advanced_test
```
The advanced test starts a network of 3 nodes using a Vagrantfile.

Both of those tests can be targeted using Ansible.


## Inception

Inception is a 42common-core project. It's goal is to use Docker to setup and deploy a basic Wordpress stack using Wordpress, nginx, and mariadb.

All username and passwords used here are specified in [secrets.yml](./src/secrets.yml).

### Mariadb

Mariadb is the database our website uses to store it's data.

It is possible to interact with it using the following commands
```sh
docker exec -it mariadb  /bin/sh
mariadb -h 127.0.0.1 -P 3306 -u <mariadb user> -p
<mariadb password>

# Inside mariadb
show databases;
use <database>;

create table <table> (
	name VARCHAR(50),
	yob CHAR(4),
	lastname VARCHAR(50)
	);
show tables;
describe <table>;

insert into <table> (name, lastname, yob)
values('john', 'doe', '1970');
select * from <table>;

quit
```
