#!/bin/bash

zenity --info --text "PREMENDO OK ACCETTI LA NOSTRA LICENZA \n 
Developed by:\n Gianmaria Generoso, admin of www.italiaunix.com.\n Alberto Pau - DebInst creator https://github.com/TheGatorade/debinst \n
GNU GPL v3 License - Available at \n https://raw.githubusercontent.com/Kryuko/ue3_linux_opti/master/LICENSE"
       --title="Licenza" \

MEM=$(zenity --entry \
--title="Inserisci memoria GPU" \
--text="Inserisci la memoria della tua scheda video, in numero e in MB [ES. 2048]:" \
--entry-text "")
echo $MEM

let MEMORY=$MEM-128

zenity --info \
--title="Memoria video" \
--text="La tua memoria video è di $MEM\MB, verrà impostata a $MEMORY\MB per evitare problemi." \
echo $MEMORY 

find ~/.local/share/ -type f -iname *.ini -exec sed -inr "s/^PoolSize=.*/PoolSize=$MEMORY/g" {} \;

zenity --info --text "Tutti i tuoi giochi UE3 sono stati impostati a $MEMORY MB"
HALFMEMORY=$(($MEM / 10))
echo $HALFMEMORY

find ~/.local/share/ -type f -iname *.ini -exec sed -inr "s/^MemoryMargin=.*/MemoryMargin=$HALFMEMORY/g" {} \;
zenity --info --text "MemoryMargin impostato a $HALFMEMORY MB"

exit
