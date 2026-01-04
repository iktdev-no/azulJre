FROM debian:bullseye-slim

ARG JRE

COPY azul.tar.gz /tmp/java.tar.gz

RUN mkdir -p /opt/java/java${JRE} \
    && tar -xzf /tmp/java.tar.gz --strip-components=1 -C /opt/java/java${JRE} \
    && rm /tmp/java.tar.gz \
    && chmod +x /opt/java/java${JRE}/bin/java \
    && update-alternatives --install /usr/bin/java java /opt/java/java${JRE}/bin/java 100

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 8080
EXPOSE 80

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["java", "-jar", "/usr/share/app/app.jar"]
