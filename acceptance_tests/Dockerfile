FROM ruby:3.1.2-alpine

WORKDIR /usr/src/app

RUN apk --no-cache add \
      wpa_supplicant openssl \
      ruby ruby-rdoc ruby-bundler ruby-ffi mariadb-connector-c-dev \
      ruby-dev make gcc libc-dev

COPY Gemfile Gemfile.lock .ruby-version ./
RUN gem update --system && gem install bundler
RUN bundle check || bundle install

COPY certs certs
COPY . .

CMD ["bundle", "exec", "rspec"]
