#!/bin/bash

# Nombre del archivo de salida
output_file="bibliotecas.txt"

# Limpiar el archivo de salida si ya existe
> "$output_file"

# Obtener paquetes oficiales (Pacman) instalados manualmente
echo "### Paquetes oficiales (Pacman) instalados manualmente ###" >> "$output_file"
pacman -Qqe | grep -v "$(pacman -Qqm)" >> "$output_file"

# Obtener paquetes de AUR (YAY) instalados manualmente
echo -e "\n### Paquetes de AUR (YAY) instalados manualmente ###" >> "$output_file"
pacman -Qqm >> "$output_file"

# Obtener paquetes Flatpak instalados manualmente
echo -e "\n### Paquetes Flatpak instalados manualmente ###" >> "$output_file"
flatpak list --app --columns=application | tail -n +1 >> "$output_file"

# Obtener paquetes Snap instalados manualmente (si los hay)
if command -v snap &> /dev/null; then
    echo -e "\n### Paquetes Snap instalados manualmente ###" >> "$output_file"
    snap list | awk '{if(NR>1)print $1}' >> "$output_file"
fi

# Mensaje de finalización
echo -e "\nLa lista de bibliotecas instaladas manualmente se ha guardado en $output_file"