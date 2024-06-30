#!/bin/bash

if [ "$1" == "--date" ] || [ "$1" == "-date" ]; then
    current_date=$(date +"%Y-%m-%d")
    echo "Dzisiejsza data: $current_date"
elif [ "$1" == "--logs" ] || [ "$1" == "-logs" ]; then
    if [ -z "$2" ]; then
        num_logs=100
    else
        num_logs=$2
    fi

    if ! [[ "$num_logs" =~ ^[0-9]+$ ]]; then
        echo "Błąd: Podany argument nie jest liczbą całkowitą."
        exit 1
    fi

    for (( i=1; i<=$num_logs; i++ )); do
        log_file="log$i.txt"
        echo "Nazwa pliku: $log_file" > "$log_file"
        echo "Nazwa skryptu: skrypt.sh" >> "$log_file"
        echo "Data utworzenia: $(date +"%Y-%m-%d %H:%M:%S")" >> "$log_file"
    done
elif [ "$1" == "--help" ]; then
    echo "Dostępne opcje:"
    echo "--date       : Wyświetla dzisiejszą datę."
    echo "--logs [liczba] : Tworzy (domyślnie 100) plików logx.txt z informacjami."
    echo "--help       : Wyświetla pomoc."
else
    echo "Błąd: Nieznana opcja. Użyj --help, aby uzyskać pomoc."
    exit 1
fi