ARG TRAEFIK_IMAGE_TAG=v2.8.4

FROM traefik:$TRAEFIK_IMAGE_TAG

WORKDIR /app

COPY ./proxy/ ./
RUN chmod +x ./start.sh

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["./start.sh"]
CMD []
