FROM ruby:3.4.3

WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . /app
