#!/usr/bin/env bash
#
# Desarrollado por Carlos Gómez Alvarez
# Contacto desarrollo11@hab.eicma.cu
#
# Define los colores que se utilizaran en el script.

# Obtener los colores del terminal.
if which tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
# supports them.
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    black="$(tput setaf 0)"
    red="$(tput setaf 1)"
    green="$(tput setaf 2)"
    yellow="$(tput setaf 3)"
    blue="$(tput setaf 4)"
    magenta="$(tput setaf 5)"
    cyan="$(tput setaf 6)"
    bold="$(tput smso)"
    offColor="$(tput sgr0)"
else
    black=""
    red=""
    green=""
    yellow=""
    blue=""
    magenta=""
    cyan=""
    bold=""
    offColor=""
fi

txtwht='\e[0;37m' # White
bakylw='\e[43m'   # Yellow

colorW="${txtwht}${bakylw}"
# echo `tput setaf 0`black text`tput sgr0`
# echo `tput setaf 6`cyan text`tput sgr0`
# echo `tput setaf 2`green text`tput sgr0`
# echo `tput setaf 4`blue text`tput sgr0`
# echo `tput setaf 5`magenta text`tput sgr0`
# echo `tput setaf 1`red text`tput sgr0`


