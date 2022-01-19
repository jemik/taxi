# start from base
FROM ubuntu:20.04
LABEL maintainer="Jesper Mikkelsen"
RUN apt-get update -y && DEBIAN_FRONTEND=noninteractive apt-get install -y python3 python3-pip libssl-dev curl nginx

COPY requirements.txt /core/requirements.txt
WORKDIR /core

RUN pip3 install -r requirements.txt

COPY data-configuration.yml /core/data-configuration.yml

COPY cert.pem /core/cert.pem
COPY key.pem /core/key.pem
COPY ngix.conf /core/ngix.conf

RUN opentaxii-sync-data /core/data-configuration.yml

CMD nginx -c /core/ngix.conf && gunicorn opentaxii.http:app --bind 0.0.0.0:9000 --config python:opentaxii.http



EXPOSE 443

