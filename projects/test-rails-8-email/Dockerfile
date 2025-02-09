FROM ruby:3.2
RUN curl -sS https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get update -qq \
  && apt-get install -y nodejs postgresql-client
WORKDIR /myapp
COPY Gemfile* ./
RUN bundle install
COPY . .
CMD ["bin/rails", "s", "-b", "0.0.0.0"]