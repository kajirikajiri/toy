FROM ruby:3.2
RUN curl -sS https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get update -qq \
  && apt-get install -y nodejs sqlite3 libsqlite3-dev
WORKDIR /rails
COPY Gemfile* ./
RUN bundle install
COPY . .
CMD ["bin/rails", "s", "-b", "0.0.0.0"]