# Single-stage build for AI DIAL Chat UI
FROM node:22-alpine

WORKDIR /app

# Copy all files
COPY . .

# Install dependencies
RUN npm ci

# Expose port
EXPOSE 3000

# Set environment variables
ENV NODE_ENV=development

# Start the application in development mode
CMD ["npm", "run", "nx", "serve", "chat", "--", "--host=0.0.0.0", "--port=3000"]
