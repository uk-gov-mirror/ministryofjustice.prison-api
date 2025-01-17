#!/bin/sh
exec java ${JAVA_OPTS} \
  -Dcom.sun.management.jmxremote.local.only=false \
  -Djava.security.egd=file:/dev/./urandom \
  -Doracle.jdbc.J2EE13Compliant=true \
  -Dcom.zaxxer.hikari.housekeeping.periodMs=${CONNECTION_POOL_STATS_PERIOD:-360000} \
  -javaagent:/app/agent.jar \
  -jar /app/app.jar
