FROM ruby:2.7.2-buster
RUN apt update && apt install -y postgresql-client
WORKDIR /waldo-api
COPY Gemfile /waldo-api/Gemfile
RUN bundle install
COPY . /waldo-api

# Run this script every time this container starts
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
