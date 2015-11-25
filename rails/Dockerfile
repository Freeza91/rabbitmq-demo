FROM rails
MAINTAINER freeza91 <useyes91@gmail.com>
RUN mkdir /producter
WORKDIR /producter
ADD Gemfile /producter/Gemfile
ADD Gemfile.lock /producter/Gemfile.lock
RUN bundle install
ADD . /producter