FROM debian:bullseye-slim

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV WHISPER_CPP_REPO=https://github.com/ggerganov/whisper.cpp.git

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git build-essential curl ffmpeg python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Clone and build whisper.cpp
RUN git clone --depth 1 $WHISPER_CPP_REPO /app/whisper.cpp && \
    cd /app/whisper.cpp && make

# Copy transcribe script
WORKDIR /app
COPY transcribe.py .

# Install Python requirements
RUN pip3 install yt-dlp

# Run on container start
ENTRYPOINT ["python3", "transcribe.py"]
