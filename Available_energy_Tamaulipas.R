library("tidyverse")
library("ggplot2")
library("dplyr")
library("lubridate")



Wind<-read.csv('https://raw.githubusercontent.com/sernumo/Modelo-aerogenerador/master/Datos_medidos/Tam_windspeeddata.csv')
Wind <- Wind[!is.na(Wind$PCTimeStamp),]
Wind <- Wind[!is.na(Wind$Avg.wind.speed.m.s.130m),]

V1<- Wind$Avg.wind.speed.m.s.130m

Wind$PCTimeStamp =parse_date_time(Wind$PCTimeStamp ,"dmy HM")

Exp_data =365*24*6 #Numero de datos maximo en el año
data_avail=round((length(Wind$Avg.wind.speed.m.s.130m)/Exp_data)*100,2)

cat("La disponibilidad de datos :", data_avail,"% del periodo estudiado")

TP <- matrix(0,length(V1),1)


for (i in 1:length(V1)){

 
   if (V1[i]>=3 & V1[i]  < 10 ){
  TP[i]= 52.899*V1[i]**2-205.48*V1[i]+170.07
  }
  else if (V1[i]>=10 & V1[i]  < 12 ){
    TP[i]= 19*V1[i]+3372
  }
  else if (V1[i]>=12 & V1[i]  <= 22 ){
    TP[i]= 3600
  }

  else{
  TP[i]=0 
  }
}

PP <- data.frame(Wind,TP)

ggplot(data=PP,aes(PP$PCTimeStamp,PP$TP))+geom_line()

Mes<- month(Wind$PCTimeStamp)
PP <- cbind(PP,Mes)

MWh <- c(0,0,0,0,0,0,0,0,0,0,0,0)

Jan <- filter(PP, Mes==1)
#ggplot(data=Jan,aes(Jan$PCTimeStamp,Jan$TP))+geom_line()
MWh[1] <- sum(Jan$TP)/1000

Feb <- filter(PP, Mes==2)
#ggplot(data=Feb,aes(Feb$PCTimeStamp,Feb$TP))+geom_line()
MWh[2] <- sum(Feb$TP)/1000

Mar <- filter(PP, Mes==3)
#ggplot(data=Mar,aes(Mar$PCTimeStamp,Mar$TP))+geom_line()
MWh[3] <- sum(Mar$TP)/1000

Apr <- filter(PP, Mes==4)
#ggplot(data=Apr,aes(Apr$PCTimeStamp,Apr$TP))+geom_line()
MWh[4] <- sum(Apr$TP)/1000

May <- filter(PP, Mes==5)
#ggplot(data=May,aes(May$PCTimeStamp,May$TP))+geom_line()
MWh[5] <- sum(May$TP)/1000

Jun <- filter(PP, Mes==6)
#ggplot(data=Jun,aes(Jun$PCTimeStamp,Jun$TP))+geom_line()
MWh[6] <- sum(Jun$TP)/1000

Jul <- filter(PP, Mes==7)
#ggplot(data=Jul,aes(Jul$PCTimeStamp,Jul$TP))+geom_line()
MWh[7] <- sum(Jul$TP)/1000

Aug <- filter(PP, Mes==8)
#ggplot(data=Aug,aes(Aug$PCTimeStamp,Aug$TP))+geom_line()
MWh[8] <- sum(Aug$TP)/1000

Sep <- filter(PP, Mes==9)
#ggplot(data=Sep,aes(Sep$PCTimeStamp,Sep$TP))+geom_line()
MWh[9] <- sum(Sep$TP)/1000


Oct <- filter(PP, Mes==10)
#ggplot(data=Oct,aes(Oct$PCTimeStamp,Oct$TP))+geom_line()
MWh[10] <- sum(Oct$TP)/1000


Nov <- filter(PP, Mes==11)
#ggplot(data=Nov,aes(Nov$PCTimeStamp,Nov$TP))+geom_line()
MWh[11] <- sum(Nov$TP)/1000

Dec <- filter(PP, Mes==12)

MWh[12] <- sum(Dec$TP)/1000

Mnth <- c('Jan','Feb','Mar','Apr','May','jun','Jul','Aug','Sep','Oct','Nov','Dec')
ENRgy <- cbind(Mnth,MWh)

Tam_prod<- as.data.frame(ENRgy)
print("Producción mensual con Aerogenerador")
Tam_prod$MWh <- as.character(Tam_prod$MWh)
Energy <-sum(as.numeric(Tam_prod$MWh))

Tam_prod$MWh <- round(as.numeric(Tam_prod$MWh),2)

#######Ordenamos en decresiente#######

data3 <- Tam_prod # Replicate original data
data3$Mnth <- factor(data3$Mnth,    # Factor levels in decreasing order
                  levels = data3$Mnth[order(data3$MWh, decreasing = TRUE)])

#########Garficamos proucción mensual########

ggplot(data3, aes(x=Mnth, y=MWh, fill=Mnth))+
  geom_bar(stat = "identity")+
  theme_minimal()+geom_text(aes(label=MWh),hjust=0.5, vjust=-1)+
ggtitle("Energy estimation by month") +
  xlab("Month") + ylab("Energy [MWh]")+  scale_fill_manual(values=c("#461a9b","#461a9b","#461a9b","#4800fd","#4800fd","#4800fd","#0075ff","#0075ff","#0075ff","#0befff","#0befff","#0befff"))

#######Imprimimos mesnsaje de energia generada total###########

Tam_prod$MWh <- as.character(Tam_prod$MWh)

Energy <-sum(as.numeric(Tam_prod$MWh))

cat("La energía producida por la Máquina de prueba es: ", Energy,"MWh en 2019")











