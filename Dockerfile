#Download node dependencies and install them
#Copy from the base image
FROM node:alpine as build-stage
# 
WORKDIR '/app'
COPY package.json .
RUN npm install
# Copy the project files to image file system
COPY . .
# Builds in WORKDIR in location /app/build
RUN npm run build

#Deploy and start the applicatio in nginx
FROM nginx
EXPOSE 80
COPY --from=build-stage /app/build/ /usr/share/nginx/html


