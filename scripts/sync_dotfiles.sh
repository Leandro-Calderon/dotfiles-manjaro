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

# Copiar archivos reales al repositorio, preservando la estructura de directorios
echo "Iniciando la copia de archivos..."
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        dest="$dotfiles_dir${file#$HOME}"  # Preservar la estructura relativa
        mkdir -p "$(dirname "$dest")"     # Crear directorio si no existe
        cp "$file" "$dest"               # Copiar archivo
        echo "Copiado: $file -> $dest"
    else
        echo "Advertencia: El archivo $file no existe."
    fi
done

# Sincronizar la carpeta scripts, excluyendo subcarpetas específicas
src_scripts_dir="$HOME/scripts"
dest_scripts_dir="$dotfiles_dir/scripts"

echo "Sincronizando la carpeta de scripts..."
rsync -av --exclude 'scripts/' "$src_scripts_dir/" "$dest_scripts_dir/"
echo "Carpeta scripts sincronizada."

# Ir al directorio de dotfiles
echo "Cambiando al directorio de dotfiles: $dotfiles_dir"
cd "$dotfiles_dir" || { echo "Error: No se pudo acceder al directorio de dotfiles."; exit 1; }

# Verificar cambios en Git
if [[ -n $(git status --porcelain) ]]; then
    echo "Se detectaron cambios. Subiendo a GitHub..."
    git add .
    git commit -m "Actualización de archivos de configuración y scripts"
    if git push; then
        echo "Sincronización completada exitosamente."
    else
        echo "Error al realizar el push a GitHub."
    fi
else
    echo "No hay nuevos cambios para sincronizar."
fi

