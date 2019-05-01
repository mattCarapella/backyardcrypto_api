FROM ruby:2.5

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

# Define where application will live inside the image 
ENV RAILS_ROOT /Users/matt/rails/backyard_api_vers_2/byc_api

# Create application home. App server needs the pids directory.
RUN mkdir -p $RAILS_ROOT/tmp/pids

# set working directory inside the image
WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["./your-daemon-or-script.rb"]