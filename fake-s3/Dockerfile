FROM nginx:alpine

COPY default.conf /etc/nginx/conf.d/default.conf
COPY clients.conf /usr/share/nginx/clients.conf

# For testing purposes, we don't need this CA
RUN touch /usr/share/nginx/comodoCA.pem

COPY .certs/ca.pem /usr/share/nginx/ca.pem
COPY .certs/server.pem /usr/share/nginx/server.pem
COPY .certs/server.key /usr/share/nginx/server.key
