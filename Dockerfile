FROM ruby:2.2-onbuild
RUN gem install foreman rerun

COPY . /app
WORKDIR /app

CMD foreman start
