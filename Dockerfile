FROM python:3.10-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    curl \
    ffmpeg

# Set working directory
WORKDIR /app

# Copy everything
COPY . .

# Make scripts executable
RUN chmod +x whispercpp/clone_and_build.sh whispercpp/download_model.sh start.sh

# Run setup scripts
RUN bash whispercpp/clone_and_build.sh && \
    bash whispercpp/download_model.sh

# Install yt-dlp
RUN pip install yt-dlp

# Start the app
CMD ["./start.sh"]
