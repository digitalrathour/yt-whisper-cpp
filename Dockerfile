FROM python:3.10-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    curl \
    ffmpeg

# Set working directory
WORKDIR /app

# Copy files
COPY . .

# Make script executable
RUN chmod +x start.sh

# Install yt-dlp
RUN pip install yt-dlp

# Run the start script
CMD ["./start.sh"]
RUN pip install flask
EXPOSE 8000
CMD ["python", "app.py"]
