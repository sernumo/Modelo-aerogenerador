library("tidyverse")
library("ggplot2")
library("dplyr")
library("lubridate")

setwd("C:\\Users\\Serge\\Documents\\Programing\\Data _analysis_final\\Modelo-aerogenerador\\Datos_Meteoblue\\Abasolo_Guanajuato")

A1<-read.csv("dataexport_20200421T170846_Abasolo__Guanajuato.csv",skip=9,header=T)
A2<-read.csv("dataexport_20200427_Abasolo__Guanajuato.csv",skip=9,header=T)
A3<-read.csv("dataexport_20200503_Abasolo__Guanajuato.csv",skip=9,header=T)
A4<-read.csv("dataexport_20200512_Abasolo__Guanajuato.csv",skip=9,header=T)
#A4
#A5
#A6
####ETC

B1 <- rbind(A1,A2)

B2 <- rbind(A3,A4)
#B3 <- rbind(A5,A6)
#B4 <- rbind(Jul,Aug)
#B5 <- rbind(Sep,Oct)
#B6 <- rbind(Nov,Dec)
####ETC


C1 <- rbind(B1,B2)
#C2 <- rbind(B3,B4)
#C3 <- rbind(B5,B6)

#DY <- rbind(C1,C2)
#DY <- rbind(CY,C3)

#All <- rbind(D1,D2) esto en cao de tener todos 

All <- C1

Final <- unique(All)

Final$timestamp<- strsplit(as.character(Final$timestamp),'T')

Final$timestamp =parse_date_time(Final$timestamp,"ymd HM")
 


