#!/bin/bash
# My first script

MEM=$(grep -o "Memory:\ [0-9]*" /var/log/Xorg.0.log | grep -Eo "[0-9]+")
#MEMORY=$(grep -o ".*Memory: .*" /var/log/Xorg.0.log | cut -d \  -f 9)
let MEM=$MEM/1024
echo $MEM

zenity --info --text "PREMENDO OK ACCETTI LA NOSTRA LICENZA"
       --title="Licenza" \
	#--text="Inserisci la tua memoria video in MB" \
       #--checkbox="I read and accept the terms."

let MEMORY=$MEM-128

zenity --info \
--title="Memoria video" \
--text="La tua memoria video è di $MEM\MB, verrà impostata a $MEMORY\MB per evitare problemi." \
echo $MEMORY 

find ~/.local/share/ -type f -iname *.ini -exec sed -inr "s/^PoolSize=.*/PoolSize=$MEMORY/g" {} \;

zenity --info --text "Tutti i tuoi giochi UE3 sono stati impostati a $MEMORY MB"
HALFMEMORY=$(($MEM / 4))
echo $HALFMEMORY

find ~/.local/share/ -type f -iname *.ini -exec sed -inr "s/^MemoryMargin=.*/MemoryMargin=$HALFMEMORY/g" {} \;
zenity --info --text "MemoryMargin impostato a $HALFMEMORY MB"

exit
