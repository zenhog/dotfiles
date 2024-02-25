FROM jekyll/jekyll:3.5
WORKDIR /app
COPY . .
RUN bundle install
CMD bundle exec jekyll serve --host 0.0.0.0 --watch --drafts --livereload
EXPOSE 4000
