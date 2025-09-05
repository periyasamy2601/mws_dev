# ---------- STAGE 1: Build ----------
FROM node:21-slim AS builder

# Set working directory
WORKDIR /home/node/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies (including dev for build)
RUN npm install

# Copy source code
COPY . .

# Build the app (adjust if your project has a build step)
RUN npm run build

# ---------- STAGE 2: Production ----------
FROM node:21-slim

# Set working directory
WORKDIR /home/node/app

# Set environment variables
ENV HOST=0.0.0.0
ENV PORT=3000

# Copy only built files and production dependencies
COPY --from=builder /home/node/app/build ./build
COPY --from=builder /home/node/app/package*.json ./

# Install only production dependencies
RUN npm install --omit=dev

# Expose the port
EXPOSE ${PORT}

# Run the application
CMD ["node", "build/index.js"]
