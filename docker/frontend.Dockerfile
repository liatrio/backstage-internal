FROM node:14-buster AS build

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN yarn install --verbose
RUN yarn workspace example-app build