FROM ruby:2.6.3

RUN apt-get update && apt-get install -y build-essential libpq-dev postgresql-client
RUN gem install rails
RUN gem install bundler -v 2.0.2

RUN mkdir /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install
COPY . /myapp