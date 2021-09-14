#!/bin/bash

function help_panel() {
    echo -e "\nDictionary offline.\n"
    echo -e "Modo de uso: ${0##/*/} [opcion] Palabra_a_buscar.\n"
    echo -e "\tOpciones:\tDescripcion"
    echo -e "\t-i\t\tUsar el diccionario Ingles."
    echo -e "\t-e\t\tUsar el diccionario Español.\n"
    exit 0
}

function searching() {
    local word=$1
    local dict=$2

    for file in $(ls -1 ./lib/${dict}*.txt); do
        grep -i -E "^$word" $file | sed 's/%/@/1' | sed -E 's/([{}].*)?@/%/' | sed 's/%/ --> /g' | column
    done
}

# ----- Inicio ------
dictionary=""
while getopts ":e:i:" opt; do
    case $opt in
        e) word=$OPTARG; dictionary=b ;;
        i) word=$OPTARG; dictionary=a ;;
        *) help_panel ;;
    esac
done

if [ "$dictionary" = "a" ]; then
    searching $word $dictionary
elif [ "$dictionary" = "b" ]; then
    searching $word $dictionary
elif [ -z $1 ]; then
    help_panel
else
    help_panel
fi
