# Cloud-9 (because I am always happy !)


## Introduction
The purpose of this project is to setup and deploy a project on machines using [**Ansible**](#ansible), an Infra-as-code tool.

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

Inception is a 42common-core project. It's goal is to use Docker to setup and deploy a basic Wordpress stack using Wordpress, nginx, mariadb, and PhpMyAdmin.

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

## Ansible

**Ansible** uses an expansive lexicon to describe it's many concepts. I will explain them to the best of my ability in a decreasing matter of importance. The keywords will be written in **bold**.

### inventories

An **inventory** is a declaration of target **hosts** (also called **nodes**).
**nodes** can belong to one or multiple **groups**. **groups** themselves can belong to other groups.
```
---
all:
  vars:
    ansible_user: ansible
    ansible_python_interpreter: /usr/bin/python3.12

  children:
    control:
      hosts:
        control-node:
          ansible_host: 10.10.20.10

    webservers:
      hosts:
        web1:
          ansible_host: 10.10.20.21
        web2:
          ansible_host: 10.10.20.22

    dbservers:
      hosts:
        db1:
          ansible_host: 10.10.20.31

    datacenter:
      children:
        webservers:
        dbservers:
```

### playbooks

A **playbook** is a set of actions comprised of **plays**.

**plays** target groups using **tasks**. They can also be executed individually.

**tasks** are a set of instructions, they represent the core of a **playbook**. They can be *inline* or *imported* as **roles**.

**roles** are way to _factorize_ multiple **tasks** to make them reusable and make the **playbook** cleaner.

**tasks**, whether _imported_ or _inline_ are composed of **modules**. **modules** can be built-in by ansible or made by the community (ansible galaxy).

**modules** are encapsulation of regular linux commands such as `copy`, `apt` or encapsulation of specific jobs such as with the `user` **module**. It can create a user with a specific group, password, home...

#### Example

I will use a Restaurant as an example for how a **playbook** works :

The **playbook** is the full 3-course menu and the organisation it requires (cooking, serving, dish-washing...).

We will have multiple plays :
- dressing tables
- prepping the kitchen
- entree
- main course
- dessert
- cleaning
- dish-washing

```yml
# inventory
---
all:
    children:

      cooks:
        hosts: [...]

      tables:
        hosts:
          table1: [...]
          table2: [...]
          table3: [...]

      dish-washers:
        hosts: [...]
```

```yml
# playbook
---
- name: Dressing tables
  hosts: tables
  vars:
    tablecloth_color: "red"
  tasks:  # imported task
    - name: Set table
      import_role:
        name: set_table

- name: Prepping the kitchen
  hosts: cooks
  tasks:
    - name: Clean kitchen
      import_role:
        name: clean_kitchen
    - name: Meal prep
      import_role:
        name: meal_prep

- name: Entree
  hosts: table1
  vars_files:
    - "./secret_recipe.yml"
  vars:
    clients: "table1"
  tasks:
    - name: Entree
      import_role:
        name: entree_course
    - name: serve tables # the serve_tables role is reused in each course
      import_role:
        name: serve_tables


- name: Main course
  hosts: tables
  vars_files:
    - "./secret_recipe.yml"
  tasks:
    - name: Main course
      import_role:
        name: main_course
    - name: serve tables
      import_role:
        name: serve_tables

- name: Dessert
  hosts: "table2, table3"
  vars_files:
    - "./secret_recipe.yml"
  tasks:
    - name: Dessert
      import_role:
        name: dessert_course
    - name: serve tables
      import_role:
        name: dessert_course

- name: Cleanup
  hosts: tables
  vars:
    tablecloth_color: "red"
  tasks:   # this is an inline task
    - name: Clean tables
    ansible.builtin.clean_tables:   # this is a module, it has
      change_tablecloth: yes
      set_tables: yes

- name : Dish-washing 
  hosts: dishwashers
  tasks:  # inline task
    - name: Dish washing
    washing.community.wash:
      soap: paic
      air-dry: true
```

Here the tables are set, the kitchen is prepped, table1 receives an entree, tables 1, 2, and 3 receive a main course and tables 2 and 3 receive a dessert.
The `serve_table` **role** is reused across all three courses.
Hosts target the tables, the cooks, and the dish-washers depending on the required job. A specific host can be targeted by itself.
