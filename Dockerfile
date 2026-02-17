# Use Node.js LTS image
FROM node:20.5.1

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json ./
RUN npm install

# Copy the rest of the project
COPY . .

# Run tests by default
CMD ["npm", "test"]
