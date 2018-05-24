FROM ruby:2.5.1-slim

RUN apt-get update && \
    apt-get install -y build-essential cron && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY backup/ /backup/
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
