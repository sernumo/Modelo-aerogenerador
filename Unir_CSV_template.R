library("tidyverse")
library("ggplot2")
library("dplyr")
library("lubridate")
library("EDAWR")

setwd("C:\\Users\\USUARIO\\Desktop\\Respaldo_Energia\\estados_total")

nombre <- list("Bimbaletes__Aguascalientes",
               "Nueva_Baja_California__Baja_California",
               "San_Ignacio__Baja_California_Sur",
               "San_Bartolo__Campeche",
               "El_Progreso__Chiapas",
               "Sierra_TomÃ³chic_Chihuahua",
               "Corral_de_Barrancas__Coahuila",
               "Los_Almarcigos__Colima",
               "Santa_MarÃ­a_del_Oro__Durango",
               "Abasolo__Guanajuato",
               "Ayutla_de_los_Libres__Guerrero",
               "Zotola__Hidalgo",
               "Ojuelos__Jalisco",
               "Las_CaÃ±adas__MichoacÃ¡n",
               "Cuauchichinola__Morelos",
               "Playa_Novillero__Nayarit",
               "Presa_San_Antonio__Nuevo_LeÃ³n",
               "ZapotitlÃ¡n__Puebla",
               "PeNamiller__Queretaro",
               "Alvaro_ObregOn__Quintana_Roo",
               "Armadillo_de_los_Infante__San_Luis_PotosÃ­",
               "El_Espinal__Sinaloa",
               "Amalia__Sonora",
               "Villa_Tecolutilla__Tabasco",
               "Atlangatepec__Tlaxcala",
               "Cahuapan__Veracruz",
               "Samahil_Yucatan",
               "El_Nuevo_Mercurio_Zacatecas")
estado <- list("Aguascalientes",
               "Baja_California",
               "Baja_California_Sur",
               "Campeche",
               "Chiapas",
               "Chihuahua",
               "Coahuila",
               "Colima",
               "Durango",
               "Guanajuato",
               "Guerrero",
               "Hidalgo",
               "Jalisco",
               "MichoacÃ¡n",
               "Morelos",
               "Nayarit",
               "Nuevo_LeÃ³n",
               "Puebla",
               "Queretaro",
               "Quintana_Roo",
               "San_Luis_PotosÃ­",
               "Sinaloa",
               "Sonora",
               "Tabasco",
               "Tlaxcala",
               "Veracruz",
               "Yucatan",
               "Zacatecas")


for (i in 1:28) {

archivo1 <- str_c("dataexport_20200421_", nombre[[i]], ".csv") 
archivo2 <- str_c("dataexport_20200427_", nombre[[i]], ".csv") 
archivo3 <- str_c("dataexport_20200503_", nombre[[i]], ".csv") 
archivo4 <- str_c("dataexport_20200512_", nombre[[i]], ".csv") 
archivo_final <- str_c(estado[[i]],".csv")


A1<-read.csv(archivo1 ,skip=9,header=T)
A2<-read.csv(archivo2 ,skip=9,header=T)
A3<-read.csv(archivo3 ,skip=9,header=T)
A4<-read.csv(archivo4 ,skip=9,header=T)



B1 <- rbind(A1,A2)

B2 <- rbind(A3,A4)


C1 <- rbind(B1,B2)


All <- C1

Final <- unique(All)

Final$timestamp <- strsplit(as.character(Final$timestamp),'T')

Final$timestamp = parse_date_time(Final$timestamp,"ymd HM")

write.csv(Final,archivo_final)
}


