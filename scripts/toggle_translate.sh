#!/usr/bin/env bash

# Ruta al entorno virtual
VENV_PATH=~/scripts/scripts/venv

# Activar entorno virtual
source "$VENV_PATH/bin/activate"

# Obtén el texto del portapapeles
TEXT=$(xclip -o)

if [ -n "$TEXT" ]; then
    # Detecta el idioma usando Python y langdetect
    TEMP_FILE=$(mktemp)
    echo "$TEXT" > "$TEMP_FILE"

    LANG_DETECTED=$(python3 -c "
from langdetect import detect
try:
    with open('$TEMP_FILE', 'r') as f:
        text = f.read().strip()
    lang = detect(text)
    print(lang)
except Exception as e:
    print(f'error: {e}')
")

    # Elimina el archivo temporal
    rm "$TEMP_FILE"

    # Depuración: muestra el idioma detectado
    echo "Idioma detectado: $LANG_DETECTED"

    case "$LANG_DETECTED" in
        "es")
            TARGET_LANG="en"
            ;;
        "en")
            TARGET_LANG="es"
            ;;
        *)
            yad --error --title="Error" --text="Idioma no soportado o detectado: $LANG_DETECTED"
            deactivate
            exit 1
            ;;
    esac
    
    # Traduce el texto
    TRANSLATION=$(trans -b :"$TARGET_LANG" "$TEXT")
    
    # Muestra la traducción
    yad --info --title="Traducción" --text="$TRANSLATION"
else
    yad --error --title="Error" --text="No hay texto en el portapapeles para traducir."
fi

# Desactivar entorno virtual
deactivate
