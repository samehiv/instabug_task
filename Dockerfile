FROM ruby:2.6.1
RUN apt-get update -qq
RUN mkdir /app
WORKDIR /app
COPY chat_system/Gemfile /app/Gemfile
COPY chat_system/Gemfile.lock /app/Gemfile.lock
RUN bundle install
RUN git clone https://github.com/vishnubob/wait-for-it.git /wait-for-it
COPY chat_system /app/.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]

