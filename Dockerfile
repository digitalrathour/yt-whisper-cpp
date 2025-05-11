FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    curl \
    ffmpeg

# Set working directory
WORKDIR /app

# Copy all files into container
COPY . .

# Make all required shell scripts executable
RUN chmod +x whispercpp/whispercpp/clone_and_build.sh whispercpp/download_model.sh start.sh

# Install yt-dlp
RUN pip install yt-dlp

# Run start script
CMD ["./start.sh"]
