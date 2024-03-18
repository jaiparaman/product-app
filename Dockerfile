### STAGE 1: Build ###
FROM node:18 AS build
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

### STAGE 2: Run ###
FROM nginx:alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /usr/src/app/dist/product-app /usr/share/nginx/html

EXPOSE 80

CMD nginx -g "daemon off;"
