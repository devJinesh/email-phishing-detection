# Use a base image with Python and Node.js support
FROM python:3.11-slim AS base

# Set working directory
WORKDIR /app

# Copy package files for both Python and Node.js
COPY package*.json requirements.txt ./

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install Node.js dependencies
RUN apt-get update && apt-get install -y nodejs npm && \
    npm install && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy the entire project into the container
COPY . .

# Expose the port your app uses (replace with your app's port)
EXPOSE 5000

# Define the command to start the application
CMD ["python", "src/app.py"]