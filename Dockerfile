FROM ruby:2.5.1-slim

WORKDIR /usr/src/app

COPY fs/ /

RUN apt-get update && \
    apt-get install -y build-essential cron && \
    bundle install && \
    apt-get remove -y build-essential && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
