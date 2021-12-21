ARG IMAGE=jetbrains/youtrack:2021.4.35732
FROM $IMAGE

USER 0

ADD ssl/ca/ca.crt /tmp/ca.crt

RUN /opt/youtrack/internal/java/linux-x64/bin/keytool \
  -importcert \
  -keystore /opt/youtrack/internal/java/linux-x64/lib/security/cacerts \
  -storepass changeit \
  -file /tmp/ca.crt \
  -alias "myroot" \
  -noprompt \
  && rm -f /tmp/ca.crt

USER 13001
