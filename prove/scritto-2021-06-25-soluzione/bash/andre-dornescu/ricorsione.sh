# Autore:              Andreea Dornescu
# Anno accademico:     2022/23


#!/bin/bash
#file ricorsione
#$1 -> cartella da ispezionare
#$2 -> stringa di cui cercare il numero di occorrenze
#$3 -> estensione file di formato .???
#$4 -> file di output


cd "$1"
for file in * ; do    #per ogni elemento contenuto nella directory corrente:
    if test -f "$file" -a -r "$file" #$file è un file ordinario leggibile
    then
        if [[ "$file" = *$3 ]] #check sull'estensione del file
            then 
            count=`grep -c "$2" "$file"` #numero occorrenze stringa
            if test $count -gt 0; then 
                echo "`pwd`/$file:`ls -l "$file" | awk '{print $5}'`:`stat --format="%G" "$file"`:$count">>"$4"
            fi
        fi
    elif test -d "$file"  #file è una directory
    then
        #echo "Invocazione ricorsiva sulla directory `pwd`/$file"
        "$0" "$file" $2 "$3" "$4"  #invocazione ricorsiva
    fi
done