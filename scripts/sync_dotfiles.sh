#!/bin/zsh
#Prueba
# Directorio donde están los dotfiles
dotfiles_dir=~/Public/dotfiles-manjaro

# Archivos que deseas sincronizar
files=(
    "$HOME/.zshrc"
    "$HOME/.config/nvim/init.vim"
    "$HOME/.config/kitty/kitty.conf"
    "$HOME/.config/fastfetch/config.jsonc"
)

# Copiar archivos reales al repositorio
echo "Iniciando la copia de archivos..."
for file in "${files[@]}"; do
    dest="$dotfiles_dir${file#$HOME}" # Mantener estructura
    mkdir -p "$(dirname "$dest")" # Crear carpeta si no existe
    if [ -f "$file" ]; then
        if ! cmp -s "$file" "$dest"; then
            cp "$file" "$dest"
            echo "Archivo copiado: $file"
        else
            echo "Sin cambios: $file"
        fi
    else
        echo "Advertencia: El archivo $file no existe."
    fi
done

# Sincronizar la carpeta scripts con exclusión
src_scripts_dir="$HOME/scripts"
dest_scripts_dir="$dotfiles_dir/scripts"
echo "Sincronizando la carpeta de scripts..."
rsync -av --exclude 'scripts' "$src_scripts_dir/" "$dest_scripts_dir/"

# Ir al directorio de dotfiles
cd "$dotfiles_dir" || { echo "No se pudo acceder al directorio de dotfiles"; exit 1; }

# Verificar si hay cambios antes de intentar sincronizar
if [[ -n $(git status --porcelain) ]]; then
    echo "Se han detectado cambios, procediendo con el commit y push..."
    git add .
    git commit -m "Actualización de archivos de configuración y scripts"
    git push
    if [ $? -eq 0 ]; then
        echo "Sincronización completada exitosamente."
    else
        echo "Error al sincronizar con GitHub."
    fi
else
    echo "No hay nuevos cambios para sincronizar con GitHub."
fi

