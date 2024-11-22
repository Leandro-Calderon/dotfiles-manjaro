#!/usr/bin/env python3

import os

def update_system():
    commands = [
        "sudo pacman -Syu --noconfirm",  # Actualizar paquetes oficiales
        "yay -Syu --noconfirm",         # Actualizar paquetes AUR (opcional)
        "sudo pacman -Sc --noconfirm",  # Limpiar caché de paquetes
    ]
    for cmd in commands:
        print(f"Ejecutando: {cmd}")
        os.system(cmd)

if __name__ == "__main__":
    update_system()

