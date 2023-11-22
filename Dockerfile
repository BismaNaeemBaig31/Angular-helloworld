# Build Stage
FROM node:14-alpine as build

WORKDIR /app

COPY package*.json ./

RUN npm install

RUN npm install -g @angular/cli@15.0.5


COPY . .

RUN  ng build --configuration=production --aot=true --optimization=true --source-map

# Production Stage
FROM nginx:alpine

COPY --from=build /app/dist/angular-hello-world/  /usr/share/nginx/html/


EXPOSE 80
