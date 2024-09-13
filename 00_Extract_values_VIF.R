# Cargar las librerías necesarias
library(raster)
library(rgdal)
library(sp)
library(usdm)  # Para funciones VIF

# Leer las coordenadas desde un archivo CSV
coords <- read.csv("D:/Maxent/Inputs/presencias_limpias_vasconcellea2.csv")

# Asegurarse de que las coordenadas están en el formato correcto
coordinates <- data.frame(x = coords$Lon, y = coords$Lat)

# Transformar el dataframe en SpatialPoints
coordinates <- SpatialPoints(coordinates, proj4string = CRS("+init=epsg:4326"))

# Especificar la carpeta donde están los archivos ASCII
raster_folder <- "D:/Maxent/Inputs/variables ASCII"

# Crear un stack de archivos raster
raster_files <- list.files(raster_folder, full.names = TRUE, pattern = "\\.asc$")
raster_stack <- stack(raster_files)

# Extraer los valores del raster en las coordenadas dadas
values <- extract(raster_stack, coordinates)
values_df <- as.data.frame(values)
head(values_df)

# Convertir la lista de valores en un dataframe
values_df <- do.call(rbind, lapply(values, as.data.frame))
names(values_df) <- gsub(pattern = ".asc", replacement = "", basename(raster_files))

#####
# Calcular el VIF
vif_values <- vifstep(values_df, th = 10, method = 'pearson')  # Puedes ajustar el umbral con th

print(vif_values)
