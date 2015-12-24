#!/bin/bash

MEM=$(grep -o "Memory:\ [0-9]*" /var/log/Xorg.0.log | grep -Eo "[0-9]+")

let MEM=$MEM/1024
echo $MEM

zenity --width=600 --height=400 --info \
       --title="License" \
	--text "PREMENDO OK ACCETTI LA NOSTRA LICENZA \n 
Developed by:\n Gianmaria Generoso, admin of www.italiaunix.com.\n Alberto Pau - DebInst creator https://github.com/TheGatorade/debinst \n
GNU GPL v3 License - Available at \n https://raw.githubusercontent.com/Kryuko/ue3_linux_opti/master/LICENSE"

let MEMORY=$MEM-128

zenity --width=600 --height=400 --info \
--title="Memoria video" \
--text="La tua memoria video è di $MEM\MB, verrà impostata a $MEMORY\MB per evitare problemi." \
echo $MEMORY 

find ~/.local/share/ -type f -iname *.ini -exec sed -inr "s/^PoolSize=.*/PoolSize=$MEMORY/g" {} \;

zenity --width=600 --height=400 --info --text "Tutti i tuoi giochi UE3 sono stati impostati a $MEMORY MB"
HALFMEMORY=$(($MEM / 4))
echo $HALFMEMORY

find ~/.local/share/ -type f -iname *.ini -exec sed -inr "s/^MemoryMargin=.*/MemoryMargin=$HALFMEMORY/g" {} \;
zenity --width=600 --height=400 --info --text "MemoryMargin impostato a $HALFMEMORY MB"

exit
