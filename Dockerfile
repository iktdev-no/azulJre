FROM debian:bullseye-slim

ARG TARGETARCH

RUN mkdir -p /usr/share/app

COPY dep /dep

COPY installer.sh /installer.sh
RUN chmod +x /installer.sh
# RUN ls -la .

# Runs the java installer and configurer
RUN /installer.sh 


# Create entrypoints
RUN mkdir -p /docker-entrypoint.d/

# Copy entrypoint 
COPY docker-entrypoint.sh /docker-entrypoint.sh
# Makes it executable
RUN chmod +x /docker-entrypoint.sh


ENV AM_I_IN_A_DOCKER_CONTAINER True

RUN rm -r /dep

EXPOSE 8080
EXPOSE 80

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["java", "-jar", "/usr/share/app/app.jar"]