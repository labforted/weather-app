FROM node AS source
RUN mkdir -p /node/weather-app
ADD src/ /node/weather-app
WORKDIR /node/weather-app
RUN npm install

FROM node:alpine
ARG APP_VERSION=v1.1
LABEL org.label-schema.version=$APP_VERSION
ENV NODE_ENV="production"
ENV PORT 3000
COPY --from=source /node/weather-app /node/weather-app
WORKDIR /node/weather-app
EXPOSE $PORT
ENTRYPOINT ["./bin/www"]
