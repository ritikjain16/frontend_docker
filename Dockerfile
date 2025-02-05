FROM node:alpine3.18 as build

# Declare build time environment variables
ARG VITE_NODE_ENV
ARG VITE_API_URL

# Set default values for environment variables
ENV VITE_NODE_ENV=$VITE_NODE_ENV
ENV VITE_API_URL=$VITE_API_URL

# Build App
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Serve with Nginx
FROM nginx:1.23-alpine
# WORKDIR /usr/share/nginx/html
# RUN rm -rf *
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]