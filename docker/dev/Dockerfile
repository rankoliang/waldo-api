FROM ruby:2.7.2-buster

RUN apt update && apt install -y postgresql-client && \
      bundle config set without production

WORKDIR /waldo_api

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000
