# Builder
FROM node:16-alpine AS builder

RUN mkdir -p /nuxt-app
WORKDIR /nuxt-app
COPY . .

RUN yarn 
RUN yarn cache clean --force
RUN yarn build

# Stage 
FROM keymetrics/pm2:16-alpine

RUN mkdir -p /nuxt-app
WORKDIR /nuxt-app

COPY --from=builder /nuxt-app/.output ./.output
COPY --from=builder /nuxt-app/ecosystem.config.js ./ecosystem.config.js

ENV NUXT_HOST=0.0.0.0
ENV NUXT_PORT=3000

EXPOSE 3000 

ENTRYPOINT ["pm2-runtime", "start", "./ecosystem.config.js"]