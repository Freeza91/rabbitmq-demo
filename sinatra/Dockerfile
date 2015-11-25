FROM ruby
MAINTAINER freeza91 <useyes91@gmail.com>
RUN mkdir /consumer
WORKDIR /consumer
ADD Gemfile /consumer/Gemfile
ADD Gemfile.lock /consumer/Gemfile.lock
RUN bundle install
ADD . /consumer