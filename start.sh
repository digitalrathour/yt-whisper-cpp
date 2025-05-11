#!/bin/bash

set -e

echo "📥 Cloning whisper.cpp..."
git clone https://github.com/ggerganov/whisper.cpp.git
cd whisper.cpp
make
cd ..

echo "📥 Downloading model..."
mkdir -p models
curl -L -o models/ggml-base.en.bin https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.en.bin

echo "🚀 Starting transcription..."
python3 transcribe.py "$YOUTUBE_URL"
