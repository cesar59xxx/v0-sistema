FROM node:20-alpine

# Install dependencies
RUN apk add --no-cache libc6-compat

WORKDIR /app

# Copy package files
COPY package.json ./

# Install dependencies
RUN npm install --legacy-peer-deps

# Copy all files
COPY . .

# Build the application
ENV NEXT_TELEMETRY_DISABLED=1
ENV NODE_ENV=production

RUN npm run build

# Expose port
EXPOSE 3000

# Start the application
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

CMD ["npm", "start"]
