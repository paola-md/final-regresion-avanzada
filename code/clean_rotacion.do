clear
import excel "/Users/Karla_Alfaro_Pizana/Documents/ITAM/Ciencia_de_Datos/Reg_avanzada/Proyecto_final/final-regresion-avanzada/data/Target_rotacionV2.xlsx", sheet("QUERY_FOR_TABLA3_0000") firstrow case(lower)
sort f_alta
drop in 1/13838
rename target rotacion

*rotacion*
replace rotacion ="1" if rotacion =="C"
replace rotacion ="0" if rotacion =="N"
destring rotacion, replace

*genero*
replace genero ="1" if genero =="M"
replace genero ="0" if genero =="F"
destring genero, replace

*missings*
replace sucursal ="NA" if sucursal==""
replace escolaridad ="NA" if escolaridad==""
replace edo_civil ="NA" if edo_civil ==""
replace experiencia ="NA" if experiencia ==""
replace div ="NA" if div ==""

*div*
replace div="1" if div=="NORTE"
replace div="2" if div=="SUR"
replace div="." if div=="NA"
destring div, replace

*dependientes*
gen dependientes="1" if edo_civil=="CASADO/ UNION LIBRE CON HIJOS"
replace dependientes="1" if edo_civil=="SOLTERO CON HIJOS"
replace dependientes="2" if edo_civil=="CASADO/ UNION LIBRE SIN HIJOS"
replace dependientes="2" if edo_civil=="CASADO/ UNION LIBRE SIN HIJOS"
replace dependientes ="3" if edo_civil=="CON DEPENDIENTES ECONOMICOS"
replace dependientes="." if dependientes==""
destring dependientes, replace

*edo_civil*
replace edo_civil="1" if edo_civil=="CASADO/ UNION LIBRE CON HIJOS"
replace edo_civil="1" if edo_civil=="CASADO/ UNION LIBRE SIN HIJOS"
replace edo_civil="2" if edo_civil=="CON DEPENDIENTES ECONOMICOS"
replace edo_civil="2" if edo_civil=="SOLTERO CON HIJOS"
replace edo_civil="2" if edo_civil=="SOLTERO SIN HIJOS"
replace edo_civil="." if edo_civil=="NA"
destring edo_civil, replace

*experiencia*
replace experiencia="1" if experiencia=="SIN EXPERIENCIA"
replace experiencia="1" if experiencia=="1 AÑO EN VENTAS"
replace experiencia="2" if experiencia=="2 O MAS AÑOS EN VENTAS"
replace experiencia="." if experiencia=="NA"
destring experiencia, replace

*escolaridad*
replace escolaridad="1" if escolaridad=="BACHILLERATO CONCLUIDO"
replace escolaridad="1" if escolaridad=="CARRERA TEC/COM NO ADMVA"
replace escolaridad="1" if escolaridad=="CARRERA TECNICA ADMVA"
replace escolaridad="2" if escolaridad=="LICENCIATURA CONCLUIDA"
replace escolaridad="2" if escolaridad=="LICENCIATURA TRUNCA"
replace escolaridad="2" if escolaridad=="LICENCIATURA TRUNCA + 70%"
replace escolaridad="2" if escolaridad=="LICENCIATURA TRUNCA - 70%"
replace escolaridad="3" if escolaridad=="MAESTRIA"
replace escolaridad="." if escolaridad=="NA"
destring escolaridad, replace

*salario_diario_ant*
replace salario_diario_ant = salario_diario_ant*30.4

*incremento*
gen incremento= sueldo_prom/salario_diario_ant

*num_trabajos_previos*
replace num_trabajos_previos =round(num_trabajos_previos, 1)
