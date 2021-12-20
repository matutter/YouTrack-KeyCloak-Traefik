ARG IMAGE=jetbrains/youtrack:2021.4.35732
FROM $IMAGE

USER 0

RUN apt-get update -y && apt-get install -y -q ca-certificates

ADD ssl/ca/ca.crt /usr/local/share/ca-certificates/ca.crt

RUN update-ca-certificates

USER 13001
