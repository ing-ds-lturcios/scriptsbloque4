#!/bin/bash
ruta="/workspaces/scriptsbloque4"
tmptop=$(echo $ruta/top10.txt)
reporte=$(echo $ruta/reporte.txt)
declare -A NombreMes VentasMes Categorias Productos Clientes Departamentos 

obtenerNombreMes(){
    case $1 in 
        "01") respuesta="Enero     "
            ;;
        "02") respuesta="Febrero   "
        ;;
        "03") respuesta="Marzo     "
            ;;
        "04") respuesta="Abril     "
            ;;
        "05") respuesta="Mayo      "
            ;;
        "06") respuesta="Junio     "
            ;;
        "07") respuesta="Julio     "
            ;;
        "08") respuesta="Agosto    "
            ;;
        "09") respuesta="Septiembre"
            ;;
        "10") respuesta="Octubre   "
            ;;
        "11") respuesta="Noviembre "
            ;;
        "12")respuesta="Diciembre "
            ;;
    esac
    printf "%s" "$respuesta"
}

obtenerTextoFecha(){
    echo $(date +%d) de $(obtenerNombreMes $(date +%m)) de $(date +%Y)
}

crearSuperiorDeCaja(){
    echo -e "┌────────────────────────────────────┐" >> "$reporte"
}

crearInferiorDeCaja(){
    echo -e "└────────────────────────────────────┘" >> "$reporte"
}

VentasMes[01]=0
VentasMes[02]=0
VentasMes[03]=0
VentasMes[04]=0
VentasMes[05]=0
VentasMes[06]=0
VentasMes[07]=0
VentasMes[08]=0
VentasMes[09]=0
VentasMes[10]=0
VentasMes[11]=0
VentasMes[12]=0

obtenerMes() {  
    echo $1 | cut -d "-" -f 2
}

while IFS="," read -r fecha departamento categoria producto cantidad valor cliente; do

mes=$(obtenerMes "$fecha")  

Productos[$producto]=$(( ${Productos[$producto]} + cantidad ))

Categorias[$categoria]=$(( ${Categorias[$categoria]} + valor ))

VentasMes[$mes]=$(( ${VentasMes[$mes]} + valor ))

Clientes[$cliente]=$(( ${Clientes[$cliente]} + valor ))

Departamentos[$departamento]=$(( ${Departamentos[$departamento]} + valor ))

done < "ventas.csv"

if [ -f "$reporte" ]; then
    rm "$reporte"
    touch "$reporte"
fi

crearSuperiorDeCaja
printf "│%-36s│\n" " Fecha: $(obtenerTextoFecha)" >> "$reporte"
printf "│%-36s│\n" " Hora : $(date +%H:%M)" >> "$reporte"
crearInferiorDeCaja

crearSuperiorDeCaja
echo -e "│      Total de Ingresos por Mes     │" >> "$reporte"
crearInferiorDeCaja

for elemento in "${!VentasMes[@]}"; do
    printf "\t%s-%s $ %s\n" "$elemento" "$(obtenerNombreMes $elemento)" "${VentasMes[$elemento]}"
done | sort >> "$reporte"


crearSuperiorDeCaja
echo -e "│   Total de Ingresos por Categoria  │" >> "$reporte"
crearInferiorDeCaja

for cate in "${!Categorias[@]}"; do
    printf "\t%s $ %s\n"  "$cate" "${Categorias[$cate]}"
done | sort >> "$reporte"


crearSuperiorDeCaja
echo -e "│ Total de Ingresos por Departamento │" >> "$reporte"
crearInferiorDeCaja

for depa in "${!Departamentos[@]}"; do 
    printf "\t%s $ %s\n" "$depa" "${Departamentos[$depa]}"
done | sort >> "$reporte"


crearSuperiorDeCaja
echo -e "│    Total de Ingresos por Cliente   │" >> "$reporte"
crearInferiorDeCaja

for client in "${!Clientes[@]}"; do
    printf "\t%s $ %s\n" "$client" "${Clientes[$client]}"
done | sort >> "$reporte"


crearSuperiorDeCaja
echo -e "│   Top10 de Productos Mas Vendidos  │" >> "$reporte"
echo -e "├────┬───────────────────────────────┘" >> "$reporte"

for produ in "${!Productos[@]}"; do
    printf "%s,%s\n" "${Productos[$produ]}" "$produ"
done | sort -nr | head > "$tmptop"

contar=0
while IFS="," read -r cnt produc; do
    ((contar+=1))
    printf "│%4s│ %s %s\n" "$contar " "$produc" "$cnt"
done < "$tmptop" >> "$reporte"
echo -e "└────┘" >> "$reporte"
rm "$tmptop"