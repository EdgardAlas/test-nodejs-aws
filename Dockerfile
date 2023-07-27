FROM ubuntu:20.04

WORKDIR /app

# install nodejs

RUN apt-get update && apt-get install -y curl

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -

RUN apt-get install -y nodejs


# Install nginx

RUN apt-get install -y nginx

# Copy default nginx configuration

RUN rm /etc/nginx/sites-enabled/default
COPY nginx/nginx.conf /etc/nginx/nginx.conf


# Copy package.json and package-lock.json

COPY src/package*.json ./

# Install dependencies

RUN npm install

# Copy source code

COPY ./src .

# expose

EXPOSE 80
EXPOSE 3000

# start nginx and nodejs

CMD ["sh", "-c", "service nginx start && node index.js"]