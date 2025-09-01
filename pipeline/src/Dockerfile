# Use official Node.js LTS image
FROM node:24-alpine

# Create app directory
WORKDIR /usr/src/app

# Copy package files and install dependencies first (caching)
COPY package*.json ./
RUN npm install --production

# Copy built application
COPY --chown=node:node dist ./dist
COPY --chown=node:node package*.json ./

# Set environment variables (optional)
ENV NODE_ENV=production

# Expose port
EXPOSE 3000

# Run the application
CMD ["node", "dist/index.js"]
