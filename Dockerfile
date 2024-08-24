FROM node:20-alpine AS deps

USER node
WORKDIR /usr/app

COPY --chown=node:node package*.json .

RUN npm install

FROM node:20-alpine As build

USER node
WORKDIR /usr/app

COPY --chown=node:node . .
COPY --chown=node:node package*.json .
COPY --chown=node:node --from=deps /usr/app/node_modules ./node_modules

RUN npm run build

RUN npm install --only=production && npm cache clean --force

FROM node:20-alpine As production

USER node
WORKDIR /usr/app

COPY --chown=node:node --from=build /usr/app/dist ./dist
COPY --chown=node:node --from=build /usr/app/node_modules ./node_modules

CMD [ "node", "dist/index.js" ]