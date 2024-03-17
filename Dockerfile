# Use the official Node.js image as the base image
FROM node:18 as build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy the entire project to the container
COPY . .

# Build the Angular app for production
RUN npm run build

# Use a smaller, production-ready image as the final image
FROM nginx:alpine

# Copy the production-ready Angular app to the Nginx webserver's root directory
COPY --from=build /app/dist/product-app /usr/share/nginx/html

# # Start Nginx
# # CMD ["nginx", "-g", "daemon off;"]
# CMD ["ng", "serve", "--host", "0.0.0.0"]
