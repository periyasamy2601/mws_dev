# ---------- STAGE 1: Build ----------
FROM node:21-slim AS builder

# Set working directory
WORKDIR /home/node/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install all dependencies (including dev)
RUN npm install

# Copy source code
COPY . .

# Build TypeScript -> dist/
RUN npm run build

# ---------- STAGE 2: Production ----------
FROM node:21-slim

# Set working directory
WORKDIR /home/node/app

# Set environment variables
ENV HOST=0.0.0.0
ENV PORT=3000

# Copy compiled app from builder
COPY --from=builder /home/node/app/dist ./dist

# Copy public folder
COPY --from=builder /home/node/app/public ./public

# Copy package.json and package-lock.json
COPY --from=builder /home/node/app/package*.json ./

# Install only production dependencies
RUN npm install --omit=dev

# Expose the port
EXPOSE ${PORT}

# Start the app
CMD ["node", "dist/index.js"]

