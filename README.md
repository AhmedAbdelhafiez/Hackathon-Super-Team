# Hackathon-Super-Team
# Chatbot Backend with OpenAI Integration

## Overview

This Ruby on Rails application serves as the backend for a chatbot that leverages OpenAI for collecting data from clients. The application is designed to run on Docker and uses Ruby version 3.2.2 and Rails version 7.0.5, with PostgreSQL as the database.

## Prerequisites

Make sure you have the following installed on your system:

- [Docker](https://www.docker.com/)
- [Ruby 3.2.2](https://www.ruby-lang.org/)
- [Rails 7.0.5](https://rubyonrails.org/)
- [PostgreSQL](https://www.postgresql.org/)

## Getting Started

1. Clone the repository:
    ```bash
    git clone <repository_url>
    ```

## Normal Way

2. Install rbenv 

3. Install specific ruby version 
    ```bash
    rbenv install 3.0.0
    ```
4. Do bundle install
    ```bash
    bundle install
    ```
5. Setup postgres db
    ```bash
    docker run -d -p 5432:5432 -e POSTGRES_PASSWORD=postgres --name postgres_db ankane/pgvector
    ```
6. Initilize db
    ```bash
    rake db:create
    rake db:migrate
    ```
	
## Docker

2. Build and run the Docker container:
    ```bash
    docker-compose up --build
    ```
    
   
