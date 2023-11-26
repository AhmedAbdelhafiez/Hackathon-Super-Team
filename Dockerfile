# Use the official Ruby image with the specified version
FROM ruby:3.2.2

# Set the working directory in the container
WORKDIR /app

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs npm

# Install Rails
RUN gem install rails -v '7.0.5'

# Copy Gemfile and Gemfile.lock to the container
COPY Gemfile ./

# Install gems
RUN gem install bundler -v 2.4.10 \
  && bundle install

# Copy the application code to the container
COPY . .

# Expose port 3000 to the outside world
EXPOSE 3000

# Start the Rails application
CMD ["rails", "server", "-b", "0.0.0.0"]

