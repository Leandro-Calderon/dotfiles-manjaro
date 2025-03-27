#!/bin/bash

# Colores y símbolos
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color
CHECK="✅"
GEAR="⚙️"
PACKAGE="📦"
FLATPAK="📦"
AUR="🛠️"
CLEAN="🧹"
REBOOT="🔄"

# Función para mostrar encabezados
print_header() {
    echo -e "\n${BLUE}${GEAR} $1 ${NC}"
}

# Función para mostrar éxito
print_success() {
    echo -e "${GREEN}${CHECK} $1 ${NC}"
}

# Inicio del script
clear
echo -e "${BLUE}================================================"
echo -e " ${PACKAGE} Actualización Completa del Sistema ${PACKAGE} "
echo -e "================================================${NC}"

# 1. Actualizar repositorios oficiales (pacman)
print_header "1. Actualizando paquetes oficiales (pacman)..."
sudo pacman -Syu --noconfirm && print_success "Pacman actualizado" || echo -e "${RED}Error en actualización de pacman${NC}"

# 2. Actualizar paquetes AUR (yay)
print_header "2. Actualizando paquetes AUR (yay)..."
yay -Syu --noconfirm && print_success "AUR actualizado" || echo -e "${RED}Error en actualización de AUR${NC}"

# 3. Actualizar Flatpak
print_header "3. Actualizando aplicaciones Flatpak..."
flatpak update -y && print_success "Flatpak actualizado" || echo -e "${RED}Error en actualización de Flatpak${NC}"


# Finalización
echo -e "\n${GREEN}${CHECK} ${CHECK} ${CHECK} Actualización completada ${CHECK} ${CHECK} ${CHECK}${NC}"
