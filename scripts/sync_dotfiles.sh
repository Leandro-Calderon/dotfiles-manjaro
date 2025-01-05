#!/bin/bash

# Directorio donde están los dotfiles
dotfiles_dir=~/Public/dotfiles-manjaro

# Archivos que deseas sincronizar
files=(
    "$HOME/.zshrc"
    "$HOME/.config/nvim/init.vim"
    "$HOME/.config/kitty/kitty.conf"
    "$HOME/.config/fastfetch/config.jsonc"
)

# Función para verificar si hay cambios
has_changes() {
    [[ -n $(git -C "$dotfiles_dir" status --porcelain) ]]
}

# Copiar archivos reales al repositorio solo si han cambiado
echo "Verificando y copiando archivos si es necesario..."
for file in "${files[@]}"; do
    target_file="$dotfiles_dir/$(basename "$file")"
    if [ -f "$file" ]; then
        # Comprobar si los archivos son diferentes
        if ! cmp -s "$file" "$target_file"; then
            cp -v "$file" "$target_file"
            echo "Archivo actualizado: $file"
        else
            echo "Sin cambios: $file"
        fi
    else
        echo "Advertencia: El archivo $file no existe."
    fi
done

# Sincronizar la carpeta scripts, excluyendo la subcarpeta 'scripts'
src_scripts_dir="$HOME/scripts"
dest_scripts_dir="$dotfiles_dir/scripts"

echo "Sincronizando la carpeta de scripts..."
mkdir -p "$dest_scripts_dir"
rsync -av --exclude='scripts/' "$src_scripts_dir/" "$dest_scripts_dir/"
echo "Carpeta scripts sincronizada (sin entorno virtual)."

# Ir al directorio de dotfiles
cd "$dotfiles_dir" || { echo "Error: No se pudo cambiar al directorio $dotfiles_dir"; exit 1; }

# Agregar y subir cambios a Git
if has_changes; then
    echo "Detectados cambios en los dotfiles."
    git add .
    git commit -m "Actualización de archivos de configuración y scripts"
    if git push; then
        echo "Sincronización completada."
    else
        echo "Error: No se pudo subir los cambios a GitHub."
        exit 1
    fi
else
    echo "No hay cambios para sincronizar con GitHub."
fi
