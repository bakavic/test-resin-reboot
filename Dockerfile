FROM resin/armv7hf-debian:jessie

ENV INITSYSTEM on

RUN apt-get update && apt-get install -y --no-install-recommends postgresql-9.4 postgresql-client-9.4 postgresql-contrib-9.4 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Prep Db conf
RUN sed -i '/^data_directory*/ s|/var/lib/postgresql/9.4/main|/data/db/|' /etc/postgresql/9.4/main/postgresql.conf && \
    sed -i 's/ssl = true/ssl = false/g' /etc/postgresql/9.4/main/postgresql.conf

RUN systemctl enable postgresql.service

CMD ["bash", "-c", "while true; do echo 'wait'; sleep 10; done"]
