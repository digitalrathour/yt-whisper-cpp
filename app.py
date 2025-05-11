import os
import subprocess
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route("/transcribe", methods=["POST"])
def transcribe():
    data = request.get_json()
    url = data.get("url")

    if not url:
        return jsonify({"error": "URL is required"}), 400

    try:
        # Download using yt-dlp
        subprocess.run(["yt-dlp", "-x", "--audio-format", "mp3", url, "-o", "audio.%(ext)s"], check=True)

        # Run whisper.cpp transcription
        subprocess.run(["./main", "-m", "models/ggml-base.en.bin", "-f", "audio.mp3", "-otxt"], check=True)

        # Return result
        with open("audio.txt", "r") as f:
            transcription = f.read()

        return jsonify({"transcription": transcription})

    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
