# Use lightweight Node base image
FROM node:21-slim

# Set npm warning level
ENV NPM_CONFIG_LOGLEVEL error

# Install pm2 globally
RUN npm install -g pm2

# Use the non-root built-in user `node`
USER node

# Create app directory
RUN mkdir -p /home/node/app
WORKDIR /home/node/app

# Copy package files first (layer caching for npm install)
COPY --chown=node package*.json ./

# Install only production dependencies
RUN npm install --omit=dev

# Copy build artifacts and pm2 config
COPY --chown=node dist ./dist
COPY --chown=node pm2.config.js ./pm2.config.js

# Bind to all interfaces & define default port
ENV HOST=0.0.0.0 PORT=3000

# Expose application port
EXPOSE ${PORT}

# Start app with PM2
CMD [ "pm2-runtime", "start", "pm2.config.js" ]
