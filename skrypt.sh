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
elif [ "$1" == "--init" ]; then
    echo "Klonowanie repozytorium..."
elif [ "$1" == "--error" ] || [ "$1" == "-error" ] || [ "$1" == "-e" ]; then
    if [ -z "$2" ]; then
        num_errors=100
    else
        num_errors=$2
        shift
    fi

    if ! [[ "$num_errors" =~ ^[0-9]+$ ]]; then
        echo "Błąd: Podany argument nie jest liczbą całkowitą."
        exit 1
    fi

    for (( i=1; i<=$num_errors; i++ )); do
        error_file="error$i/error$i.txt"
        mkdir -p "$(dirname "$error_file")"
        echo "Plik error: $error_file" > "$error_file"
        echo "Nazwa skryptu: skrypt.sh" >> "$error_file"
        echo "Data utworzenia: $(date +"%Y-%m-%d %H:%M:%S")" >> "$error_file"
    done
elif [ "$1" == "--help" ] || [ "$1" == "-help" ]; then
    echo "Dostępne opcje:"
    echo "--date       : Wyświetla dzisiejszą datę."
    echo "--logs [liczba] : Tworzy (domyślnie 100) plików logx.txt z informacjami."
    echo "--help       : Wyświetla pomoc."
    echo
    echo "Nowe flagi (bez mergowania z istniejącym tekstem):"
    echo "--init       : Klonuje całe repozytorium do bieżącego katalogu i ustawia ścieżkę w PATH."
    echo "--error [liczba] : Tworzy [liczba] plików errorx/errorx.txt (domyślnie 100)."
    echo
    echo "Skrócone formy:"
    echo "-e [liczba]  : Skrócona forma dla --error [liczba]."
else
    echo "Błąd: Nieznana opcja. Użyj --help, aby uzyskać pomoc."
    exit 1
fi