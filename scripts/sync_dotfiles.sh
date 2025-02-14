#!/bin/bash
set -e  # Detiene el script ante cualquier error

# Directorio base para dotfiles (donde se guardarán)
dotfiles_repo=~/Public/dotfiles-manjaro

# Archivos/directorios a respaldar (rutas relativas a $HOME)
config_files=(
    ".zshrc"
    ".config/nvim/init.vim"
    ".config/ghostty/config"
    ".config/fastfetch/config.jsonc"
)

# Crear directorio principal del repositorio
mkdir -p "$dotfiles_repo"

# Función para copiar/actualizar archivos
sync_file() {
    local source_file="$HOME/$1"
    local target_file="$dotfiles_repo/$1"
    
    # Verificar si el archivo fuente existe
    if [ ! -f "$source_file" ]; then
        echo "  ⚠️  Archivo fuente no encontrado: $source_file"
        return 1
    fi

    # Crear directorio padre en el destino si no existe
    mkdir -p "$(dirname "$target_file")"

    # Copiar solo si el archivo es nuevo o ha cambiado
    if ! cmp -s "$source_file" "$target_file"; then
        cp -v "$source_file" "$target_file"
        echo "  ✅ Copiado/Actualizado: $1"
    else
        echo "  🔄 Sin cambios: $1"
    fi
}

# Sincronizar archivos de configuración
echo "🔄 Copiando archivos locales a $dotfiles_repo..."
for file in "${config_files[@]}"; do
    echo "▸ Procesando: ~/$file"
    sync_file "$file"
done

# Sincronizar scripts (excluyendo venv y .git)
echo "\n🔄 Copiando scripts..."
rsync -avh --delete \
    --exclude='venv/' \
    --exclude='.git/' \
    "$HOME/scripts/" \
    "$dotfiles_repo/scripts/"

# Subir cambios a GitHub
echo "\n📌 Sincronizando con GitHub..."
cd "$dotfiles_repo" || exit 1

# Configurar usuario de Git (¡personaliza estos datos!)
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"

# Hacer commit y push
git add .
if git commit -m "Sync: $(date +'%d-%m-%Y %H:%M')"; then
    git push origin main && echo "🚀 ¡Todo sincronizado con GitHub!"
else
    echo "🟢 No hay cambios nuevos para subir."
fi

echo "\n✅ ¡Proceso completado!"