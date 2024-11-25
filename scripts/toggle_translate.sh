#!/bin/zsh

# Obtén el texto copiado al portapapeles
TEXT=$(xclip -o)

# Verifica si el portapapeles tiene contenido
if [ -n "$TEXT" ]; then
    # Detecta el idioma del texto y almacena la salida en una variable
    DETECTION=$(trans -id "$TEXT")

    # Extrae el idioma detectado de la salida
    LANG_DETECTED=$(echo "$DETECTION" | grep -oP '(?<=Detected: )\w+')

    echo "DETECTION OUTPUT: $DETECTION" >> ~/debug_translate.log
    echo "LANG_DETECTED: $LANG_DETECTED" >> ~/debug_translate.log

    # Si no se detecta el idioma, muestra un error
    if [ -z "$LANG_DETECTED" ]; then
        yad --error --title="Error" --text="No se pudo detectar el idioma. Verifica tu conexión a internet."
        exit 1
    fi

    # Define el idioma de destino basado en el idioma detectado
    if [[ "$LANG_DETECTED" == "Spanish" ]]; then
        TARGET_LANG="en"  # Si el idioma es español, traduce al inglés
    elif [[ "$LANG_DETECTED" == "English" ]]; then
        TARGET_LANG="es"  # Si el idioma es inglés, traduce al español
    else
        yad --error --title="Error" --text="Idioma no soportado: $LANG_DETECTED"
        exit 1
    fi

    # Traduce al idioma de destino
    RESULT=$(trans -b :"$TARGET_LANG" "$TEXT")

    # Muestra el resultado en una ventana emergente
    yad --info --title="Traducción" --text="$RESULT"
else
    # Muestra un mensaje si no hay texto en el portapapeles
    yad --error --title="Error" --text="No hay texto en el portapapeles para traducir."
fi
