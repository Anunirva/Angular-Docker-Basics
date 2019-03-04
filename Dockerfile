# Stage 1 setup 
# this will give us the compiled version of our app
# but we need to host it somewhere
# thats why we setup nginx which is a web server to host our application

FROM node:8.11.2-alpine as node

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Stage 2 Run Application
# here we will config the nginx to host our compiled app
# copy from dist folder and place it in nginx html
# replace default nginx configuratuion with our custom configurations

FROM nginx:1.13.12-alpine

COPY --from=node /usr/src/app/dist/angular-docker /usr/share/nginx/html

COPY ./nginx.conf /etc/nginx/conf.d/default.conf

