# start from base
FROM ubuntu:20.04
LABEL maintainer="Jesper Mikkelsen"
RUN apt-get update -y && DEBIAN_FRONTEND=noninteractive apt-get install -y python3 python3-pip libssl-dev curl

COPY requirements.txt /core/requirements.txt

WORKDIR /core

RUN pip3 install -r requirements.txt

COPY data-configuration.yml /core/data-configuration.yml

RUN opentaxii-sync-data /core/data-configuration.yml

CMD gunicorn opentaxii.http:app --bind 0.0.0.0:80 --config python:opentaxii.http



EXPOSE 80

