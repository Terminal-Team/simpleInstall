#!/usr/bin/env bash
#
# Desarrollado por Carlos Gómez Alvarez
# Contacto desarrollo11@hab.eicma.cu
#
# Define funciones globales que serán utilezadas en el programa.

# Muestra el titulo del programa.
title() {
    clear;
    printf "${green}"
    echo '                           __          ________           _______     __   __ '
    echo '  _____ __ ___ ___  ____  / / ______  /__   __/_   _ ____/__  __/____/ /  / / '
    echo ' / ___// / __ `__ \/ __ \/ / / ____/    / /  /  \/ // ___/ / // __  / /  / /  '
    echo '(__  )/ / / / / / / /_/ / /_/ __]_   __/ /__/ /\  /(__  ) / // /_/ / /__/ /__ '
    echo '/___//_/_/ /_/ /_/ \___/____/____/  /______/_/ /_//____/ /_//_,-,_/____/____/ '
    echo '                /_/                          ...the installation is now easy!'
    echo ''
    echo ''
    printf "${offColor}"
}
# Muestra una alerta sobre los permisos de root.
alertRootPermisse() {
    case $EUID in
        0)
        ;;
        *)
        echo -e "${colorW}
You are running this script without admin privilages, some option may not work properly 
sudo password will be required                                                          
${offColor}";;
    esac
#     Usted está corriendo este script sin privilegios de adinistración, algunas opciones pueden no trabajar correctamente.
# por lo que se le requerirá ingresar la contraseña de root.
}
#  Muestra el encabezado del script.
head() {
    title;
    alertRootPermisse;
}
# Muestra un mensage en la consola.
# Modo de uso: showAlert [-s|-i|-w|-e] <mensaje>
showAlert() {
    flag='Info';
    color="${blue}";
    message='';
    while [[ "$#" -gt 0 ]]
    do
        case $1 in
            -i|--info)
                flag='Info';color="${blue}";;
            -w|--warning)
                flag='Warning';color="${yellow}";;
            -e|--error)
                flag='Error';color="${red}";;
            -s|--success)
                flag='Ok';color="${green}";;
            *)
                message="$@";;
        esac
        shift
    done
    echo -e "[${color}$flag${offColor}] ${color}$message${offColor}";
}
# Muestra una notificacion con el mensaje pasado como argumento.
# Modo de uso: notify <message>
notify() {
    libnotify=$( dpkg -l | grep libnotify-bin )
    if [[ -n "$libnotify" ]]; then
        notify-send "$@" -t 5000
    fi
}
# Muestra el banner del script que se está ejecutando.
banner(){
    echo
    echo "${cyan}##### $@ #####${offColor}"
    echo
}
# Actualiza la lista de paquetes del repositorio.
update(){
    sudo apt update;
}
# Actualiza la lista y luego todos los paquetes instalados.
upgrade(){
    sudo apt update && sudo apt full-upgrade -y;
}
# Lista los ficheros scripts de la carpeta correspondiente.
# Modo de uso: listoptions <dirname> 
listoptions() {
    # for file in $(ls ./"$@")
    for file in $(ls "$@")
    do
        if [ $file != import.sh ]
        then
            # Agregar la funcion del fichero al menú principal
            mainMenu+=("$file") 
            # Imprimir en consola la opción del menú principal
            echo "$((${#mainMenu[@]} - 1)) ) $($file -d)"
        fi
    done;
}
# Muestra el listado de opciones del menú principal.
printMainMenu() {
    for file in $(ls -I base "$DIR/") #listado de directorios ignorando base
    do
        if [ -d "$DIR/$file" ]; then
            echo -e "${yellow}---------- ${file^} ----------${offColor}"
            listoptions "$DIR/$file"
        fi
    done;
    # Agregando la option de salir del programa.
    echo
    echo
    echo "${red}--------------------------------${offColor}"
    echo "e) Exit"
}
continueOrExit(){
    local item 

    echo #separador
    read -p "Continue [Y|n]: " tecla
    if [[ "$tecla" =~ (^[N|n][o|O]?$) ]]; then
        main
        echo "${cyan}Bye${offColor}";
        exit
    else
        main
    fi
}

# Custom `select` implementation with support for a default choice
# that the user can make by pressing just ENTER.
# Pass the choices as individual arguments; e.g. `selectWithDefault Yes No``
# The first choice is the default choice, unless you designate
# one of the choices as the default with a leading '!', e.g.
# `selectWithDefault Yes !No`
# The default choice is printed with a trailing ' [default]'
# Output is the 1-based *index* of the selected choice, as shown
# in the UI.
# Example:
#    choice=$(selectWithDefault 'Yes|No|!Abort' )
selectWithDefault() {

  local item i=0 numItems=$# defaultIndex=0

  # Print numbered menu items, based on the arguments passed.
  for item; do         # Short for: for item in "$@"; do
    [[ "$item" == !* ]] && defaultIndex=$(( $i + 1)) && item="${item:1} [default]"
    printf '%s\n' "$((++i))) $item"
  done >&2 # Print to stderr, as `select` does.

  # Prompt the user for the index of the desired item.
  while :; do
    printf %s "${PS3-#? }" >&2 # Print the prompt string to stderr, as `select` does.
    read -r index
    # Make sure that the input is either empty or that a valid index was entered.
    [[ -z $index ]] && index=$defaultIndex && break  # empty input == default choice  
    (( index >= 1 && index <= numItems )) 2>/dev/null || { echo "Invalid selection. Please try again." >&2; continue; }
    break
  done

  # Output the selected *index* (1-based).
  printf $index

}

# usage: isNumber <string>
# Returns true if specified string matches a number, false otherwise.
function isNumber() {
  [[ "$1" =~ ^[[:digit:]]+$ ]]
}
