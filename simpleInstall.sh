#!/usr/bin/env bash
#
# Desarrollado por Carlos Gómez Alvarez
# Contacto desarrollo11@hab.eicma.cu
#
# Define las funciones utiles.

# cd ~/.local; 
# $(sudo su postgres -c "psql" <<< "\password");
# exit;

# Obtener la ruta absoluta de script.
DIR=$(realpath "$0" | sed 's|\(.*\)/.*|\1|'); 

#region 'Importando funciones y variables'

# importando las variables globales y funciones útiles.
. "$DIR/base/import.sh"
# Importando los scripts
for directory in $(ls -I base "$DIR/") #listado de directorios ignorando base
    do
        if [ -d "$DIR/$directory" ]; then
            # . "$DIR/$file/import.sh"

            for file in $(ls -I base "$DIR/$directory/"); do
                . "$DIR/$directory/$file"
            done
            

        fi
    done;

#endregion

# Funcion principal de Script. (Punto de inicio)
main() {
    head;
    mainMenu=(); #reinicio el arreglo de funciones del menú.
    printMainMenu;
    echo
    total=$((${#mainMenu[@]} - 1));
    read -p "Select a option: " opt
    case "$opt" in
        [0-$total])
            echo -e "case $opt: ${mainMenu[$opt]}"
            ${mainMenu[$opt]}
        ;;
        e|E|exit|EXIT) 
            echo "${cyan}Bye${offColor}";
            exit;
        ;;
        *) # todos los casos
            main
        ;;
    esac
}
main;
