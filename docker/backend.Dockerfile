FROM node:14-buster

WORKDIR /usr/src/app

RUN apt update

# Copy repo skeleton first, to avoid unnecessary docker cache invalidation.
# The skeleton contains the package.json of each package in the monorepo,
# and along with yarn.lock and the root package.json, that's enough to run yarn install.
ADD yarn.lock package.json ./

RUN yarn install --frozen-lockfile --production

# This will copy the contents of the dist-workspace when running the build-image command.
# Do not use this Dockerfile outside of that command, as it will copy in the source code instead.
COPY app-config.yaml .
COPY packages/ packages/
COPY plugins/ plugins/

# CMD ["node", "packages/backend", "--config", "app-config.yaml"]

CMD ["yarn", "workspace", "example-backend", "start"]
# docker build -f backend.Dockerfile
# docker build -f frontend.Dockerfile