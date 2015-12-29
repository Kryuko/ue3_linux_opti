#!/bin/bash

language=$(echo $LANG | cut -c -5)

if [ $language == "it_IT" ]; then
    zenity --info --title="Licenza" \
    --text "PREMENDO OK ACCETTI LA NOSTRA LICENZA \n 
    Developed by:\n Gianmaria Generoso, admin of www.italiaunix.com.\n Alberto Pau - DebInst creator https://github.com/TheGatorade/debinst \n Davide Guidotti \n
    GNU GPL v3 License - Available at \n https://raw.githubusercontent.com/Kryuko/ue3_linux_opti/master/LICENSE"
else
    zenity --info --title="License" \
    --text "By pressing the OK button you declare to accept our license. \n 
    Developed by:\n Gianmaria Generoso, admin of www.italiaunix.com.\n Alberto Pau - also debinst creator https://github.com/TheGatorade/debinst \n Davide Guidotti \n
    GNU GPL v3 License - Available at \n https://raw.githubusercontent.com/Kryuko/ue3_linux_opti/master/LICENSE"
fi

MEM=$(grep -o "Memory:\ [0-9]*" /var/log/Xorg.0.log | grep -Eo "[0-9]+")

if [ "$MEM" == "" ]; then 
    menu=(256 512 1024 2048 4056 6104 8192 12248 16384)
        
    if [ $language == "it_IT" ]; then
        MEM=$(zenity --entry \
        --title="Inserisci memoria GPU" \
        --text="Inserisci la memoria della tua scheda video" \
        --entry-text "${menu[@]}")
    else
        MEM=$(zenity --entry \
        --title="Insert GPU Memory" \
        --text="Insert your GPU memory" \
        --entry-text "${menu[@]}")
    fi
else let MEM=$MEM/1024
fi


let MEMORY=$MEM-128

if [ $language == "it_IT" ]; then
    zenity --info \
    --title="Memoria video" \
    --text="La tua memoria video è di $MEM\MB, verrà impostata a $MEMORY\MB per evitare problemi."
else
    zenity --info \
    --title="GPU Memory" \
    --text="Your detected GPU memory is $MEM\MB, but it will be set to $MEMORY\MB to avoid issues."
fi

find ~/.local/share/ -type f -iname *.ini -exec sed -inr "s/^PoolSize=.*/PoolSize=$MEMORY/g" {} \;

if [ $language == "it_IT" ]; then
    zenity --info --text "Tutti i tuoi giochi UE3 sono stati impostati a $MEMORY MB"
else
    zenity --info --text "All your UE3 Games are optimized for $MEMORY\MB GPU."
fi
HALFMEMORY=$(($MEM / 10))

find ~/.local/share/ -type f -iname *.ini -exec sed -inr "s/^MemoryMargin=.*/MemoryMargin=$HALFMEMORY/g" {} \;
if [ $language == "it" ]; then
    zenity --info --text "MemoryMargin impostato a $HALFMEMORY MB"
else
    zenity --info --text "MemoryMargin has been set to $HALFMEMORY MB"
fi

exit
