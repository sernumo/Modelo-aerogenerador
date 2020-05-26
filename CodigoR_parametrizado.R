library(lubridate)
library(ggplot2)
library(tidyverse)

ruta <- "~/Proyecto_Energia/"

#Este archivo sirve de base para cualquier estado
#Aquí inserta el nombre del archivo, asegurate que el codigo de R se encuentre en la misma carpeta
#del archivo a modificar
#El archivo debe tener la columna velocidad con el nombre Wind_speed
#El archivo debe tener la columna fecha con el nombre Fecha_hora

estado <- "Tamaulipas"
Nombre_archivo <- "Tam_windspeeddata.csv"

#Estos nombres se generan automaticamente 
ruta_completa <- str_c(ruta,Nombre_archivo)
file_estado <- str_c(estado,"csv", sep = ".")
main_histograma <- str_c("Histograma de velocidades en ", estado)
main_boxPlot <- str_c("Distribución de Velocidades en ", estado)
wind_mes <- str_c('wind_mes', estado, sep ="_")
file_mes <- str_c(wind_mes,"csv", sep =".")
Serie_tiempo <- str_c("Serie_De_Tiempo_", estado)
imagen_serie_tiempo <- str_c(Serie_tiempo, "jpeg", sep = ".")
Histograma_BoxPlot <- str_c("Histograma_BoxPlot", estado, sep = "_")
imagen_Histograma_BoxPlot <- str_c(Histograma_BoxPlot, "jpeg", sep = ".")
imagen_wind_mes <- str_c(wind_mes, "jpeg", sep = ".")

#LLamado del archivo base
estado<- read.csv(ruta_completa)

#Muestra la estructura de los datos
#str(estado)

#Convierte todos los datos a datos tipo caracter
estado[] <- lapply(estado, as.character)

#Muestra la estructura de los datos (deben ser caracteres)
#str(estado)

#Cuenta los datos nulos por columna
#sapply(estado, function(x) sum(is.na(x)))

#Elimina filas con NA
estado <- na.omit(estado)

#Cuenta los datos nulos por columna
#sapply(estado, function(x) sum(is.na(x)))

#Muestra el archivo generado (estado)
head(estado)

#Convierte la variable Fecha_hora a tipo fecha y Avg.wind.speed a dato numÃ©rico
estado$Fecha_hora <- parse_date_time(estado$Fecha_hora,"dmy HM")
estado$Wind_speed <- as.numeric(estado$Wind_speed)

#Crea las variables de: fecha, mes, dÃ�a, aÃ±o, hora y minuto por separado
estado$fecha <- date(estado$Fecha_hora)
estado$mes <- month(estado$Fecha_hora)
estado$dia <- day(estado$Fecha_hora)
estado$anio <- year(estado$Fecha_hora)
estado$hora <- hour(estado$Fecha_hora)
estado$minuto <- minute(estado$Fecha_hora)

#Elimina filas con NA
estado <- na.omit(estado)

#Cuenta los datos nulos por columna
sapply(estado, function(x) sum(is.na(x)))

#Defino donde voy a guardar mi archivo de respaldo
setwd("~/Proyecto_Energia")

##Guardamos nuestro nuevo archivo ya con los datos en las variables correctas
write.csv(estado, file_estado, row.names = F)


#Muestra un resumen con las estadisticas basicas de cada variable
summary(estado$Wind_speed)


jpeg(imagen_serie_tiempo)

#Genera un archivo nuevo y grafica los datos para ver un primer comportamiento
wind_prueba <- estado %>% select(1:2)
plot(wind_prueba)

dev.off()



jpeg(imagen_Histograma_BoxPlot)

#Parte la pantalla en 2 filas y una columna ademÃ¡s de definir los margenes
par(mfrow = c(2,1), mar = c(2,2,2,2))
#La primera fila sera el histograma anual de velocidades
hist(wind_prueba$Wind_speed, main=main_histograma, xlab="Velocidad del viento a 130m", ylab = "Frecuencia" , col="#74D2B3", xlim=c(0,25))
          
#La segunda fila es el diagrama de caja de las velocidades anuales a la misma escala
boxplot(estado$Wind_speed, ylim= c(0,25), col="#74D2B3", horizontal = T, main = main_boxPlot, xlab = "Velocidades a 130 m (m/s)", boxwex = 0.5)
          
dev.off()




#Genera un archivo llamado wind_mes que agrupa los datos por mes y obtiene: minimo, promedio, media y mÃ¡ximo por mes
wind_mes <- estado %>%
group_by(mes =estado$mes)%>%
summarise(minim = min(Wind_speed,na.rm=T),mean = mean(Wind_speed,na.rm=T), mediana = median(Wind_speed,na.rm=T),max = max(Wind_speed,na.rm=T))
#Muestra en pantalla los datos obtenidos para wind_mes
show(wind_mes)
          
#Guardo el resumen de cada mes eliminando el nÃºmer de dila al guardar
write.csv(wind_mes, file= file_mes, row.names = F)
          
          
jpeg(imagen_wind_mes)

#Grafica las velocidades agrupandolas por mes
ggplot(data = estado, aes(x = Wind_speed, fill = mes)) +
geom_bar() +
facet_wrap(~mes, scales = 'free_y')+
theme(axis.text.x = element_text(angle=65, vjust=0.6),legend.position = "none") +
xlab('Velocidades a 130m (m/s)')+
ylab('frecuencia')+
ggtitle('GrÃ¡fica de velocidades para cada uno de los 12 meses (2019)')

dev.off()
          
#Grafica de box plot para wind 1
boxplot(estado$Wind_speed, ylim= c(0,25), col="#74D2B3", horizontal = T, main = "DistribuciÃ³n de Velocidades en Tamaulipas", xlab = "Velocidades a 130 m (m/s)", boxwex = 0.5)
#Este cÃ³digo da los resultados en pantalla del diagrama de caja
boxplot(estado$Wind_speed, ylim= c(0,25), col="#74D2B3", horizontal = T, main = "DistribuciÃ³n de Velocidades en Tamaulipas", xlab = "Velocidades a 130 m (m/s)", boxwex = 0.5, plot = F)
#[1,]  0.1 inicio 1er cuartil
#[2,]  5.0  inicio 2do cuartil
#[3,]  7.5  media
#[4,] 10.3  final 3er cuartil
#[5,] 18.2  final 4to cuartil
          

#outlier mÃ¡ximo 22.2 
          
#De acuerdo al resumen obtenido por mes y a las grÃ¡ficas febrero(mes 2) 
#y diciembre(mes 12) son los que tienen velocidades de viento mÃ¡s bajas
#por lo que buscaremos las velocidades de viento por horario para ver si hay 
#horarios en los que sea mejor trabajar 
          
          
#Genera un archivo llamado wind_feb que agrupa los datos por hora y obtiene: minimo, promedio, media y mÃ¡ximo por mes
wind_feb <- filter(estado, estado$mes == 2)
          
wind_feb <- wind_feb %>%
group_by(hora = wind_feb$hora)%>%
summarise(minim = min(Wind_speed,na.rm=T),mean = mean(Wind_speed,na.rm=T), mediana = median(Wind_speed,na.rm=T),max = max(Wind_speed,na.rm=T))
#Muestra en pantalla los datos obtenidos para wind_mes
show(wind_feb)
          
#Genera un archivo llamado wind_dic que agrupa los datos por hora y obtiene: minimo, promedio, media y mÃ¡ximo por mes
wind_dic <- filter(estado, estado$mes == 12)
          
wind_dic <- wind_dic %>%
group_by(hora = wind_dic$hora)%>%
summarise(minim = min(Wind_speed,na.rm=T),mean = mean(Wind_speed,na.rm=T), mediana = median(Wind_speed,na.rm=T),max = max(Wind_speed,na.rm=T))
#Muestra en pantalla los datos obtenidos para wind_mes
show(wind_dic)
          

#Ya vi los archivos agrupados por hora pero no veo un patrÃ³n que relacione la hora con una variacion de la velocidad del viento notable
