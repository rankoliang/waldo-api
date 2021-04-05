FROM ruby:2.7.2-alpine3.13

RUN bundle config without production

RUN apk --update --no-cache add build-base \
      linux-headers \
      tzdata \
      postgresql-dev \
      postgresql-client \
      vips

WORKDIR /waldo_api

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000
