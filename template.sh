#!/bin/bash
#
# Desarrollado por Carlos Gómez Alvarez
# Contacto desarrollo11@hab.eicma.cu
#
# Plantilla para agregar nuevos script al programa.


# la función debe llamarce igual que el nombre del fichero (script)
template.sh() {
    description=''; # Escriba aquí la descripción del script.

    #region '(NO MODIFICAR).'
    # Descripción del método que será utilizado para en el menú principal
    if [[ "$#" -gt 0 ]] && [[ "$1" = "-d" ]]; then
        echo "$description"; exit;
    fi
    # Encabezado del script en ejecución.
    head;
    banner "$description"
    #endregion
      
    # TODO: 'Agrege aquí su código del script'

    continueOrExit;   
}