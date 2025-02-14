# #!/bin/bash

# # Directorio donde están los dotfiles
# dotfiles_dir=~/Public/dotfiles-manjaro

# # Archivos que deseas sincronizar
# files=(
#     "$HOME/.zshrc"
#     "$HOME/.config/nvim/init.vim"
#     "$HOME/.config/ghostty/config"
#     "$HOME/.config/fastfetch/config.jsonc"
# )

# # Crear el directorio de dotfiles si no existe
# mkdir -p "$dotfiles_dir"

# # Copiar archivos reales al repositorio solo si han cambiado
# echo "Verificando y copiando archivos si es necesario..."
# for file in "${files[@]}"; do
#     target_file="$dotfiles_dir/$(basename "$file")"
#     echo "Verificando archivo: $file"
#     if [ -f "$file" ]; then
#         echo "El archivo existe: $file"
#         # Comprobar si los archivos son diferentes
#         if ! cmp -s "$file" "$target_file"; then
#             echo "El archivo ha cambiado: $file"
#             cp -v "$file" "$target_file"
#             echo "Archivo actualizado: $file"
#         else
#             echo "Sin cambios: $file"
#         fi
#     else
#         echo "Advertencia: El archivo $file no existe."
#     fi
# done

# # Sincronizar la carpeta scripts, excluyendo la subcarpeta 'scripts'
# src_scripts_dir="$HOME/scripts"
# dest_scripts_dir="$dotfiles_dir/scripts"

# echo "Sincronizando la carpeta de scripts..."
# mkdir -p "$dest_scripts_dir"
# rsync -av --exclude='scripts/' "$src_scripts_dir/" "$dest_scripts_dir/"
# echo "Carpeta scripts sincronizada (sin entorno virtual)."

# # Ir al directorio de dotfiles
# cd "$dotfiles_dir" || { echo "Error: No se pudo cambiar al directorio $dotfiles_dir"; exit 1; }

# # Agregar y subir cambios a Git
# if [[ -n $(git status --porcelain) ]]; then
#     git add .
#     git commit -m "Actualización de archivos de configuración y scripts"
#     if git push; then
#         echo "Sincronización completada."
#     else
#         echo "Error: No se pudo subir los cambios a GitHub."
#         exit 1
#     fi
# else
#     echo "No hay cambios para sincronizar con GitHub."
# fi
#!/bin/bash
set -e  # Detiene el script ante cualquier error

# Directorio base para dotfiles
dotfiles_dir=~/Public/dotfiles-manjaro

# Archivos/directorios a sincronizar (rutas relativas a $HOME)
files=(
    ".zshrc"
    ".config/nvim/init.vim"
    ".config/ghostty/config"
    ".config/fastfetch/config.jsonc"
)

# Crear directorio principal
mkdir -p "$dotfiles_dir"

# Sincronizar archivos de configuración
echo "🔄 Sincronizando dotfiles..."
for file in "${files[@]}"; do
    source_file="$HOME/$file"
    target_file="$dotfiles_dir/$file"
    
    echo "▸ Verificando: $file"
    
    if [ ! -f "$source_file" ]; then
        echo "  ⚠️  Archivo no encontrado: $source_file"
        continue
    fi

    # Crear directorio destino si no existe
    mkdir -p "$(dirname "$target_file")"

    if ! cmp -s "$source_file" "$target_file"; then
        cp -v "$source_file" "$target_file"
        echo "  ✅ Actualizado: $file"
    else
        echo "  🔄 Sin cambios: $file"
    fi
done

# Sincronizar scripts (excluyendo venv si existe)
echo "\n🔄 Sincronizando scripts..."
rsync -avh --delete \
    --exclude='venv/' \
    --exclude='.git/' \
    "$HOME/scripts/" \
    "$dotfiles_dir/scripts/"

# Commit y push de cambios
echo "\n📌 Actualizando repositorio Git..."
cd "$dotfiles_dir" || exit 1

if git diff --quiet && git diff --cached --quiet; then
    echo "🟢 No hay cambios para commitear."
else
    git add .
    git commit -m "Sync: $(date +'%Y-%m-%d %H:%M:%S')"
    
    if git push origin main; then
        echo "🚀 Cambios subidos correctamente!"
    else
        echo "🔥 Error al subir cambios a GitHub!"
        exit 1
    fi
fi

echo "\n✅ ¡Sincronización completada!"