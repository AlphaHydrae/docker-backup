FROM ruby:2.5.8-slim-stretch

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock /usr/src/app/

RUN apt-get update && \
    apt-get install -y build-essential cron && \
    gem install bundler -v "~> 2.0" && \
    bundle install && \
    apt-get remove -y build-essential && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

COPY fs/ /

ENV BACKUP_DATA_PATH="/var/lib/backups" \
    BACKUP_TMP_PATH="/tmp/backup"

STOPSIGNAL SIGKILL

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
