#!/bin/bash

# Colores y símbolos
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'
CHECK="✅"
GEAR="⚙️"
PACKAGE="📦"
AUR="🛠️"
FLATPAK="📦"
CLEAN="🧹"

# Lista de paquetes a ignorar por yay
IGNORE_PKGS=("ttf-maple-beta-nf-cn")

# Función para encabezados
print_header() {
    echo -e "\n${BLUE}${GEAR} $1 ${NC}"
}

# Función para éxito
print_success() {
    echo -e "${GREEN}${CHECK} $1 ${NC}"
}

# Función para errores
print_error() {
    echo -e "${RED}✖ $1 ${NC}"
}

# Tiempo inicial
START=$(date +%s)

# Inicio
clear
echo -e "${BLUE}================================================"
echo -e " ${PACKAGE} Actualización Completa del Sistema ${PACKAGE} "
echo -e "================================================${NC}"

# 1. Pacman
print_header "1. Actualizando paquetes oficiales (pacman)..."
sudo pacman -Syu --noconfirm && print_success "Pacman actualizado" || print_error "Error en actualización de pacman"

# 2. Yay (excluyendo paquetes ignorados)
print_header "2. Actualizando paquetes AUR (yay)..."
yay_ignore_args=()
for pkg in "${IGNORE_PKGS[@]}"; do
    yay_ignore_args+=("--ignore" "$pkg")
done
yay -Syu --noconfirm "${yay_ignore_args[@]}" && print_success "AUR actualizado" || print_error "Error en actualización de AUR"

# 3. Flatpak
print_header "3. Actualizando aplicaciones Flatpak..."
flatpak update -y && print_success "Flatpak actualizado" || print_error "Error en actualización de Flatpak"

# 4. Limpieza (opcional)
print_header "4. Limpiando paquetes huérfanos y caché..."
yay -Yc --noconfirm && print_success "Paquetes huérfanos eliminados"
sudo pacman -Sc --noconfirm > /dev/null && print_success "Caché limpiada"

# Duración total
END=$(date +%s)
ELAPSED=$((END - START))
print_success "Actualización completada en $ELAPSED segundos"
