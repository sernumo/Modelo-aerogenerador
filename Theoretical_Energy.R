library("tidyverse")
library("ggplot2")
library("dplyr")
library("lubridate")

setwd("C:\\Users\\snuñez\\Desktop\\Proyecto_Energia_BEDU")

Wind<-read.csv('2019_data_Tamaulipas_Windspeed.csv')
Wind <- Wind[!is.na(Wind$PCTimeStamp),]
Wind <- Wind[!is.na(Wind$Avg.wind.speed.m.s.130m),]

V1<- Wind$Avg.wind.speed.m.s.130m

Wind$PCTimeStamp =parse_date_time(Wind$PCTimeStamp ,"dmy HM")

Exp_data =365*24*6 #Numero de datos maximo en el año
data_avail=(length(Wind$Avg.wind.speed.m.s.130m)/Exp_data)*100

TP <- matrix(0,length(V1),1)


for (i in 1:length(V1)){

  if(V1[i] < 3.5){
    TP[i]= 0 }
  else if (V1[i]>=3.5 & V1[i]  < 4 ){
  TP[i]= 42.2
  }
  else if (V1[i]>=4 & V1[i]  < 4.5 ){
    TP[i]= 93.3
  }
  else if (V1[i]>=4.5 & V1[i]  < 5 ){
    TP[i]= 145.2
  }
  else if (V1[i]>=5 & V1[i]  < 5.5 ){
    TP[i]= 211.3
  }
  else if (V1[i]>=5.5 & V1[i]  < 6 ){
    TP[i]= 284.2
  }
  else if (V1[i]>=6 & V1[i]  < 6.5 ){
    TP[i]= 390
  }
  else if (V1[i]>=6.5 & V1[i]  < 7 ){
    TP[i]= 491
  }
  else if (V1[i]>=7 & V1[i]  < 7.5 ){
    TP[i]= 601.1
  }
  else if (V1[i]>=7.5 & V1[i]  < 8 ){
    TP[i]= 731.8
  }
  else if (V1[i]>=8 & V1[i]  < 8.5 ){
    TP[i]= 884.5
  }
  else if (V1[i]>=8.5 & V1[i]  < 9 ){
    TP[i]= 1087
  }
  else if (V1[i]>=9 & V1[i]  < 9.5 ){
    TP[i]= 1247.1
  }
  else if (V1[i]>=9.5 & V1[i]  < 10 ){
    TP[i]= 1429.6
  }
  else if (V1[i]>=10 & V1[i]  < 10.5 ){
    TP[i]= 1594.3
  }
  else if (V1[i]>=10.5 & V1[i]  < 11 ){
    TP[i]= 1742.1
  }
  else if (V1[i]>=11 & V1[i]  < 11.5 ){
    TP[i]= 1861.2
  }
  else if (V1[i]>=11.5 & V1[i]  < 12 ){
    TP[i]= 1948.1
  }
  else if (V1[i]>=12 & V1[i]  < 12.5 ){
    TP[i]= 1993.3
  }
  else if (V1[i]>=12.5 & V1[i]  <= 16.5 ){
    TP[i]= 2000
  }
  else{
  TP[i]=0 
  }
}

PP <- data.frame(Wind,TP)

ggplot(data=PP,aes(PP$PCTimeStamp,PP$TP))+geom_line()
