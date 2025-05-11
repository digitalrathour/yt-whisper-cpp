#!/bin/bash

# Clone and build whisper.cpp
bash whispercpp/whispercpp/clone_and_build.sh

# Download model
bash whispercpp/download_model.sh

# Start the app server
python3 app.py
