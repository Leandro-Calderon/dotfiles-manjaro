#!/bin/bash
set -e  # Detener el script ante cualquier error

# Directorio base para dotfiles
dotfiles_repo=~/Public/dotfiles-manjaro

# Archivos/directorios a respaldar
config_files=(
    ".zshrc"
    ".config/nvim"  # ← antes era init.vim, ahora toda la carpeta
    ".config/ghostty/config"
    ".config/fastfetch/config.jsonc"
)

# Crear directorio principal del repositorio
mkdir -p "$dotfiles_repo"

# Función para copiar/actualizar archivos o carpetas
sync_file() {
    local source="$HOME/$1"
    local target="$dotfiles_repo/$1"
    
    # Verificar si el archivo/directorio fuente existe
    if [ ! -e "$source" ]; then
        echo "  ⚠️  No encontrado: $source"
        return 1
    fi

    # Crear directorio padre en el destino si no existe
    mkdir -p "$(dirname "$target")"

    # Eliminar destino anterior si existe (evita conflictos al copiar carpetas)
    rm -rf "$target"

    # Copiar archivo o carpeta
    cp -vr "$source" "$target"
    echo "  ✅ Copiado/Actualizado: $1"
}

# Sincronizar archivos de configuración
echo "🔄 Copiando archivos locales a $dotfiles_repo..."
for file in "${config_files[@]}"; do
    echo "▸ Procesando: ~/$file"
    sync_file "$file"
done

# Sincronizar scripts (si existen)
if [ -d "$HOME/scripts" ]; then
    echo -e "\n🔄 Copiando scripts..."
    rsync -avh --delete \
        --exclude='venv/' \
        --exclude='.git/' \
        "$HOME/scripts/" \
        "$dotfiles_repo/scripts/"
else
    echo "  ⚠️  No se encontró ~/scripts, omitiendo..."
fi

# Subir cambios a GitHub
echo -e "\n📌 Sincronizando con GitHub..."
cd "$dotfiles_repo" || exit 1

# Evitar configuración global si ya existe
if ! git config --global --get user.name >/dev/null; then
    git config --global user.name "Tu Nombre"
    git config --global user.email "tu@email.com"
fi

# Hacer commit y push si hay cambios
if [ -n "$(git status --porcelain)" ]; then
    git add .
    git commit -m "Sync: $(date +'%d-%m-%Y %H:%M')"
    git push origin main && echo "🚀 ¡Todo sincronizado con GitHub!"
else
    echo "🟢 No hay cambios nuevos para subir."
fi

echo -e "\n✅ ¡Proceso completado!"
