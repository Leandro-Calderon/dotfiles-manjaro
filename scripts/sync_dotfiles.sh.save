#!/bin/zsh

# Directorio donde están los dotfiles
dotfiles_dir=~/Public/dotfiles-manjaro

# Archivos que deseas sincronizar
files=(
    "$HOME/.zshrc"
    "$HOME/.config/nvim/init.vim"
    "$HOME/.config/kitty/kitty.conf"
)

# Copiar archivos reales al repositorio
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        cp "$file" "$dotfiles_dir/$(basename $file)"
        echo "Copiado: $file"
    else
        echo "Advertencia: El archivo $file no existe."
    fi
done

# Sincronizar la carpeta scripts, excluyendo la subcarpeta 'scripts'
src_scripts_dir="$HOME/scripts"
dest_scripts_dir="$dotfiles_dir/scripts"

# Excluir la subcarpeta 'scripts' y copiar solo el contenido necesario
find "$src_scripts_dir" -maxdepth 1 -mindepth 1 -not -path "$src_scripts_dir/scripts" -exec cp -r {} "$dest_scripts_dir/" \;

echo "Carpeta scripts sincronizada (sin entorno virtual)."

# Ir al directorio de dotfiles
cd "$dotfiles_dir" || exit

# Agregar y subir cambios a Git
git add .
git commit -m "Actualización de archivos de configuración y scripts"
git push

echo "Sincronización completada."

