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

# Copiar archivos reales al repositorio
echo "Iniciando la copia de archivos..."
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        cp "$file" "$dotfiles_dir/$(basename $file)"
        echo "Archivo copiado: $file"
    else
        echo "Advertencia: El archivo $file no existe."
    fi
done

# Sincronizar la carpeta scripts, excluyendo la subcarpeta 'scripts'
src_scripts_dir="$HOME/scripts"
dest_scripts_dir="$dotfiles_dir/scripts"

# Excluir la subcarpeta 'scripts' y copiar solo el contenido necesario
echo "Sincronizando la carpeta de scripts..."
find "$src_scripts_dir" -maxdepth 1 -mindepth 1 -not -path "$src_scripts_dir/scripts" -exec cp -r {} "$dest_scripts_dir/" \;
echo "Carpeta scripts sincronizada (sin entorno virtual)."

# Ir al directorio de dotfiles
cd "$dotfiles_dir" || { echo "No se pudo acceder al directorio de dotfiles"; exit 1; }

# Verificar si hay cambios antes de intentar sincronizar
if [[ -n $(git status --porcelain) ]]; then
    # Hay cambios, proceder con la sincronización
    echo "Se han detectado cambios, procediendo con el commit y push..."

    # Solicitar la passphrase de la clave SSH (solo una vez)
    ssh-agent bash -c 'ssh-add ~/.ssh/id_rsa; git add .; git commit -m "Actualización de archivos de configuración y scripts"; git push'

    if [ $? -eq 0 ]; then
        echo "Sincronización completada exitosamente."
    else
        echo "Error al sincronizar con GitHub."
    fi
else
    # No hay cambios, abortar sincronización
    echo "No hay nuevos cambios para sincronizar con GitHub."
fi
