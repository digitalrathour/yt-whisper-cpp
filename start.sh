#!/bin/bash

# Clone and build whisper.cpp
bash whispercpp/whispercpp/clone_and_build.sh

# Download model
bash whispercpp/download_model.sh

# Run Flask app
python3 app.py
