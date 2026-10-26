FROM wordpress:7.1.3-php8.2-apache

COPY ./setup ./setup

RUN curl -fsSLo /usr/local/bin/wp \
	https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x /usr/local/bin/wp
