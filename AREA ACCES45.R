#Configuración inicial
library(rasterVis)
library(dichromat)
library(raster)
library(DT)
#library(ggplot2)
library(tidyverse)
library(raster)


##ACCESS 4.5 LIMA###
##########ACCESS 4.5
#Cargar datos
map <- raster("D:/Maxent/AREA Y LIMA2/Vasconcellea_candicans_ACCES45.asc")
plot(map)

#_______ÁREA KM2 
####################
#library(raster)
#library(rgdal)
#summary(map)
####Mapa de raster estilo lucia

###Reproyectar
####Límite de Lima
mps <- shapefile("D:/Maxent/AREA Y LIMA2/LIMA.shp")
plot(mps)
#hillshade_proj <- projectRaster(hillshade, crs = crs(b5))
#hillshade_proj
###ACTUAL
cat.act <- reclassify(map, c(-Inf,0.25,1,
                             0.25,0.50,2,
                             0.50,0.75,3,
                             0.75,Inf,4))

##
breaks <- seq(0, 4, by = 1) 
breaks
cols <- colorRampPalette(c( "gray93", "green4", "yellow", "red"))(length(breaks))

#dev.off() # Desactivamos todas las ventanas gráficas o dispositivos
#levelplot(cat.act, at = breaks, col.regions = cols, main = "Vasconcellea sp",
  #       margin=T) + spplot(mps, fill = "transparent", col = "white")
######


levelplot(cat.act, at = breaks, col.regions = cols, main = "       Distribución futura
          ACCESO-CM2 RPC 4.5",
          margin=F) + spplot(mps, fill = "transparent", col = "white")


#------------------------------------
#------------------------------------
#####ÁREA ACTUAL
###Resolución en grados geográficos 

res(cat.act) #0.008333° y un grados equivale a 111.32km
area <- res(cat.act)[1]*res(cat.act)[2]*111.32*111.32 #en Km cuadrados
area
vals <- getValues(cat.act)
v1 <- length(subset(vals, vals== 1))*area#/100
v2 <- length(subset(vals, vals== 2))*area
v3 <- length(subset(vals, vals== 3))*area
v4 <- length(subset(vals, vals== 4))*area
v1
aact <- c(v1,v2,v3,v4)
aact #aha
########BARPLOT
bp<- barplot(aact, ylim=c(0,1370224),
             #main = "Area (km^2)",
             xlab = "Idoneidad",
             ylab = "Área (km^2)",
             col = c( "gray93", "green4", "yellow", "red"), border = T, 
             cex.names=1,
             names.arg=c("0 - 0.25","0.25 - 0.50",
                         "0.50-0.75","0.75-1.00")
)

text(bp, aact + 60000 , labels = round(aact, digits = 2),  
     cex = 0.8)
##########LIMA
cat.act1 <- crop(cat.act,mps)
lima = mask(cat.act1, mps)
plot(lima)
plot(mps, add=TRUE, border='dark grey')
###############################
#levelplot(lima, at = breaks, col.regions = cols, main = "Vasconcellea sp",
  #        margin=T) + spplot(mps, fill = "transparent", col = "white")
levelplot(lima, at = breaks, col.regions = cols, main = "       ACCESS-CM2 RCP 4.5 (2081 - 2100)",
          margin=F) + spplot(mps, fill = "transparent", col = "white")
###Resolución en grados geográficos 
res(lima) #0.008333° y un grados equivale a 111.32km
area1 <- res(lima)[1]*res(lima)[2]*111.32*111.32 #en Km cuadrados
area1
vals1 <- getValues(lima)
v1a <- length(subset(vals1, vals1== 1))*area1#/100
v2a <- length(subset(vals1, vals1== 2))*area1
v3a <- length(subset(vals1, vals1== 3))*area1
v4a <- length(subset(vals1, vals1== 4))*area1
v1a
a45 <- c(v1a,v2a,v3a,v4a)
a45 #ahaa
###BARPLOT PARA SOLO 45
bp1<- barplot(a45, ylim=c(0,26733),
              #main = "Area (km^2)",
              xlab = "Idoneidad",
              ylab = "Área (km^2)",
              col = c( "gray93", "green4", "yellow", "red"), border = T, 
              cex.names=1,
              names.arg=c("0 - 0.25","0.25 - 0.50",
                          "0.50-0.75","0.75-1.00")
)

text(bp1, a45 + 1200 , labels = round(a45, digits = 2),  
     cex = 0.8)
####
