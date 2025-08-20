# Introduction

The goal is to deploy your site and the neccessary docker infrastructure on an instance provided by a cloud provider.
[...]
This complete web server must be able to run several services in parallels such as **Wordpress**, **PHPmyadmin** and a database.

# Chapter II
...

# Chapter III
Mandatory Part

The deployment of your application must be fully automated. We suggest you use **Ansible** but you are free to use another tool if you wish. It is imperative to provide a functional site equivalent to the one obtained with Inception just using your script.
    You must install a simple WordPress site on an instance. You must ensure that :
- Your site can restart automatically if the server is rebooted. *handled by inception*
- In the case of reboot all the data on the site are persisted (images, user accounts, articles...) *handled by inception*
- It is possible to deploy your site on several servers in parallel. *handled by cloud provider*
- Your script must be able to function in an automated way with for only assumption an ubuntu 20.04 LTS like OS of the target instance running an SSH daemon and with Python installed. *faire un docker*
- Your applications will run in separate containers that can communicate with each other (1 process == 1 container) *handled by inception*
- Public access to your server must be limited and secure (for example, it is not possible to connect directly to your database from the internet). *handled by the cloud provider*
- The services will be the different components of a WordPress to install by yourself. For example Phpmyadmin, MySAL, ... *handled by inception*
- You must have a docker-compose.yml. *handled by inception*
- You will need to ensure that your SQL database works with WordPress and PHP-MyAdmin. *handled by inception*
- Your server should be able, when possible, to use TLS. *handled by the cloud provider, see Chapter V*
- You will need to make sure that, depending on the URL requested, your server redirects to the correct site. *cloud1, cloud2, cloud3*


# Notes
- regarder inventaires dynamiques
- activer le no-sudo pour docker
- creer un nouvel utilisateur dans le docker
- installer openssh pour se connecter sur la machine distante
- ajouter un password pour le vault dans le .env
- ajouter un vault avec user user_password et root_password

# Notes ansible
- si vault_password dans le .env manquant alors -> error
- creer un utilisateur distant
- installer docker
- parametrer le port ssh + "PermitRootLogin no" et activer un UFW
- copier Inception sur la machine distante
- lancer le docker
