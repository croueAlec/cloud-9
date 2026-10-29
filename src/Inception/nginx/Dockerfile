FROM nginx:alpine

USER root

COPY --chmod=444 default.conf /etc/nginx/conf.d/default.conf
COPY cert.conf /etc/nginx/cert.conf

RUN apk update && apk add --no-cache openssl && \
	mkdir -p /etc/ssl/private /etc/ssl/certs && \
	openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
	-keyout /etc/ssl/private/selfsigned.key \
	-out /etc/ssl/certs/selfsigned.crt \
	-config /etc/nginx/cert.conf
