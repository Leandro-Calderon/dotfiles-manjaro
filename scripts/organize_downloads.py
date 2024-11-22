#!/usr/bin/env python3

import os
import shutil

DOWNLOADS_DIR = os.path.expanduser("~/Downloads")

EXTENSION_MAP = {
    "Imágenes": [".jpg", ".jpeg", ".png", ".gif", ".svg"],
    "Documentos": [".pdf", ".docx", ".xlsx", ".pptx", ".txt"],
    "Audio": [".mp3", ".wav", ".flac"],
    "Vídeos": [".mp4", ".mkv", ".avi"],
    "Comprimidos": [".zip", ".tar", ".gz", ".7z"],
}

def organize_downloads():
    for folder, extensions in EXTENSION_MAP.items():
        folder_path = os.path.join(DOWNLOADS_DIR, folder)
        os.makedirs(folder_path, exist_ok=True)

        for file in os.listdir(DOWNLOADS_DIR):
            file_path = os.path.join(DOWNLOADS_DIR, file)
            if os.path.isfile(file_path) and file.endswith(tuple(extensions)):
                shutil.move(file_path, folder_path)
                print(f"Movido: {file} → {folder}")

if __name__ == "__main__":
    organize_downloads()

