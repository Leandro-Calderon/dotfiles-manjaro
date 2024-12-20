#!/bin/zsh

# Directorio donde están los dotfiles
dotfiles_dir=~/Public/dotfiles-manjaro

# Archivos que deseas sincronizar
files=(
    "$HOME/.zshrc"
    "$HOME/.config/nvim/init.vim"
    "$HOME/.config/kitty/kitty.conf"
    "$HOME/.config/fastfetch/config.jsonc"
)

# Copiar archivos reales al repositorio solo si han cambiado
echo "Verificando y copiando archivos si es necesario..."
for file in "${files[@]}"; do
    target_file="$dotfiles_dir/$(basename $file)"
    if [ -f "$file" ]; then
        # Comprobar si los archivos son diferentes
        if ! cmp -s "$file" "$target_file"; then
            cp "$file" "$target_file"
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
find "$src_scripts_dir" -maxdepth 1 -mindepth 1 -not -path "$src_scripts_dir/scripts" -exec cp -ru {} "$dest_scripts_dir/" \;
echo "Carpeta scripts sincronizada (sin entorno virtual)."

# Ir al directorio de dotfiles
cd "$dotfiles_dir" || exit

# Agregar y subir cambios a Git
if [[ -n $(git status --porcelain) ]]; then
    git add .
    git commit -m "Actualización de archivos de configuración y scripts"
    git push
    echo "Sincronización completada."
else
    echo "No hay cambios para sincronizar con GitHub."
fi

