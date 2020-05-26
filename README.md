# Proyecto Energias Renovables BEDU
Este proyecto pretende identificar posibles zonas con potencial eólico en México
![Energias eolicas](https://media.giphy.com/media/Ynx3TPEReTklFeaoYB/giphy.gif)

Uno de los principales problemas al hacer un análsis de potencial eólico es que los datos requeridos son de paga por lo cual utilizamos:
<ul> 
<li>Datos libres de MeteoBLue </li>
<li>Datos de empresa privada </li>
<li>Datos libres del estado de México </li>
</ul>

Cada una de las etapas estaran diferenciadas para mostrar mejor el alcance del proyecto y las habilidades de programación que se tienen

## Adquisición de datos (Web Scrappping, spider)

[Web scrapping MeteoBlue](https://github.com/sernumo/Modelo-aerogenerador/blob/master/scrapy_meteoblue_limpio.py) 

## Limpieza de datos (R)
Los datos obtenidos por web scrapping se almacenaron en una carpeta aqui llamada Estados_Total, por lo que se creo un archivo (R) que une los datos reunidos en todo el mes, elimina los elementos repetidos y da formato adecuado a los datos 

[Unir datos de CSV](https://github.com/sernumo/Modelo-aerogenerador/blob/master/Unir_CSV_template.R)

Aqui se muestra otro notebook en R que también incluye eliminación de datos nulos y formato adecuado a los datos 

[Notebook Tamaulipas](https://github.com/sernumo/Modelo-aerogenerador/blob/master/Codigo_R_Tamaulipas.ipynb)


## Visualización de datos (R)
Aquí se muestran los archivos obtenidos para visualizar datos

[Notebook Tamaulipas](https://github.com/sernumo/Modelo-aerogenerador/blob/master/Codigo_R_Tamaulipas.ipynb)

[Notebook Oaxaca](https://github.com/sernumo/Modelo-aerogenerador/blob/master/Codigo_R_Oaxaca.ipynb)


Como tuvimos más de un estado del que requeriamos las mismas visualizaciones se opto despues por hacer un código que solo pidiera estado, nombre del archivo de origen y generará las graficas y archivos solo así como guardarlo en la carpeta donde estaban ese código final es 

[Visualización con parametros](https://github.com/sernumo/Modelo-aerogenerador/blob/master/CodigoR_parametrizado.R)

## Reporte final (Python)
Este reporte aun esta pendiente y esperamos terminarlo el 1/05/2020
