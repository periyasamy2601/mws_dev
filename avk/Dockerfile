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

# Build the app (TypeScript -> dist/)
RUN npm run build

# ---------- STAGE 2: Production ----------
FROM node:21-slim

# Set working directory
WORKDIR /home/node/app

# Set environment variables
ENV HOST=0.0.0.0
ENV PORT=3000

# Copy only built files and production dependencies
COPY --from=builder /home/node/app/dist ./dist
COPY --from=builder /home/node/app/package*.json ./

# Install only production dependencies
RUN npm install --omit=dev

# Expose the port
EXPOSE ${PORT}

# Run the application
CMD ["node", "dist/index.js"]
