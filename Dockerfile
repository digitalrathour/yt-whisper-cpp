FROM python:3.10-slim

# Install build dependencies
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    curl \
    ffmpeg \
    cmake \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip install flask yt-dlp

# Set working directory
WORKDIR /app

# Copy all source code
COPY . .

# Clean up previous whisper.cpp folder if it exists
RUN rm -rf whispercpp/whisper.cpp

# Clone and build whisper.cpp
RUN git clone https://github.com/ggerganov/whisper.cpp.git whispercpp/whisper.cpp && \
    cd whispercpp/whisper.cpp && \
    make

# Download the model
RUN curl -L -o whispercpp/whisper.cpp/models/ggml-base.en.bin https://huggingface.co/ggerganov/whisper.cpp/resolve/main/models/ggml-base.en.bin

# Run app.py
CMD ["python", "app.py"]
