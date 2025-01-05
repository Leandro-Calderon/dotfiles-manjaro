#!/usr/bin/env python3

import subprocess
import sys
import logging

# Configurar logging
logging.basicConfig(
    filename="update_system.log",
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
)

def run_command(cmd):
    """Ejecuta un comando y maneja errores."""
    logging.info(f"Ejecutando: {cmd}")
    print(f"Ejecutando: {cmd}")
    try:
        subprocess.run(cmd, shell=True, check=True)
    except subprocess.CalledProcessError as e:
        logging.error(f"Error al ejecutar '{cmd}': {e}")
        print(f"Error: {e}")
        sys.exit(1)

def is_installed(package):
    """Verifica si un paquete está instalado."""
    try:
        subprocess.run(f"which {package}", shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        return True
    except subprocess.CalledProcessError:
        return False

def has_orphans():
    """Verifica si hay paquetes huérfanos."""
    try:
        result = subprocess.run("pacman -Qdtq", shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        return bool(result.stdout.strip())
    except subprocess.CalledProcessError:
        return False

def update_system():
    """Actualiza el sistema."""
    # Actualizar paquetes oficiales
    run_command("sudo pacman -Syu --noconfirm")

    # Actualizar paquetes AUR (si yay o paru están instalados)
    aur_helpers = ["yay", "paru"]
    for helper in aur_helpers:
        if is_installed(helper):
            run_command(f"{helper} -Syu --noconfirm")
            break
    else:
        logging.warning("No se encontró ningún ayudante de AUR (yay/paru).")
        print("Advertencia: No se encontró ningún ayudante de AUR (yay/paru).")

    # Limpiar caché de paquetes
    run_command("sudo pacman -Sc --noconfirm")

    # Eliminar paquetes huérfanos (opcional)
    if input("¿Deseas eliminar paquetes huérfanos? (s/n): ").lower() == "s":
        if has_orphans():
            run_command("sudo pacman -Rns $(pacman -Qdtq) --noconfirm")
        else:
            print("No hay paquetes huérfanos para eliminar.")

    # Limpiar caché de AUR (si yay o paru están instalados)
    for helper in aur_helpers:
        if is_installed(helper):
            if input(f"¿Deseas limpiar la caché de {helper}? (s/n): ").lower() == "s":
                run_command(f"{helper} -Sc --noconfirm")
            break

if __name__ == "__main__":
    print("Iniciando actualización del sistema...")
    update_system()
    print("Actualización completada.")
