FROM alpine
LABEL MAiNTAINER milo@codefor.nl

RUN apk add --no-cache postgresql-client

ENV POSTGRES_USER postgres
ENV POSTGRES_HOST localhost
ENV POSTGRES_PASSWORD postgres
ENV POSTGRES_PORT 5432
ENV POSTGRES_DATABASE postgres
ENV SOURCE_DATABASE mydb
ENV TARGET_DATABASE mydb_copy

COPY copy.sh /
RUN chmod a+x /copy.sh

COPY entrypoint.sh /
RUN chmod a+x /entrypoint.sh

RUN touch /var/log/cron.log

RUN echo '0   2   *   *   * /copy.sh' > /etc/crontabs/root
CMD ["sh", "entrypoint.sh"]
