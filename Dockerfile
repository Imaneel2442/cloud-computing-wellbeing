FROM ruby:3.2

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

ENV BUNDLE_PATH=/usr/local/bundle
ENV PATH="/usr/local/bundle/bin:${PATH}"

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["bash", "-lc", "bundle exec rails db:migrate && bundle exec rails server -b 0.0.0.0 -p 3000"]
