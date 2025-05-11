import os
import subprocess
import sys
import uuid

def download_audio(url):
    out_name = f"{uuid.uuid4()}.wav"
    subprocess.run([
        "yt-dlp",
        "-x", "--audio-format", "wav",
        "--output", out_name,
        url
    ])
    return out_name

def transcribe(audio_path):
    whisper_bin = "/app/whisper.cpp/main"
    model = "models/ggml-base.en.bin"
    subprocess.run([
        whisper_bin,
        "-m", model,
        "-f", audio_path,
        "-otxt"
    ])
    print("\n\n✅ Transcription complete. Check .txt file in project directory.")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("❌ Please provide a YouTube URL")
        sys.exit(1)
    url = sys.argv[1]
    path = download_audio(url)
    transcribe(path)
