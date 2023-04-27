FROM ruby:3.2.2-alpine

WORKDIR /usr/src/app

RUN apk --no-cache add \
      wpa_supplicant openssl \
      ruby ruby-rdoc ruby-bundler ruby-ffi mariadb-connector-c-dev \
      ruby-dev make gcc libc-dev

COPY Gemfile Gemfile.lock .ruby-version ./

RUN bundle install

COPY certs certs
COPY . .

CMD ["bundle", "exec", "rspec"]
