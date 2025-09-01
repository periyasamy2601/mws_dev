# Check out https://hub.docker.com/_/node to select a new base image
FROM node:21-slim

# Set npm warning level
ENV NPM_CONFIG_LOGLEVEL error

# Install pm2
RUN npm install pm2 -g

# Set to a non-root built-in user `node`
USER node

# Create app directory (with user `node`)
RUN mkdir -p /home/node/app
WORKDIR /home/node/app

# Copy package files first (for npm install layer caching)
COPY --chown=node src/package*.json ./

# Install production dependencies
RUN npm install --omit=dev

# Copy build artifacts
COPY --chown=node src/dist ./dist

# Bind to all network interfaces so that it can be mapped to the host OS
ENV HOST=0.0.0.0 PORT=3000

# Expose application port
EXPOSE ${PORT}

# Start using PM2
CMD [ "pm2-runtime", "start", "pm2.config.js" ]
