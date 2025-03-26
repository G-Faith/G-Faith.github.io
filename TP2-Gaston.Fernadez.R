install.packages('dplyr')
library('dplyr')
library('ggplot2')

ruta.bd <- "E:\\Descarga\\Descarga\\6_reservas_hoteles.csv"
Reservas <- read.csv(ruta.bd,header = TRUE, sep = ",",stringsAsFactors = TRUE)


head(Reservas)
View(Reservas)

#Habitación mas reservada

Reservas.habitación <-table(Reservas$room_type_reserved[!is.na(Reservas$room_type_reserved)])
Reservas.habitación <- sort(Reservas.habitación,decreasing = TRUE)

View(Reservas.habitación)

#Tipo de contratación con mas cancelaciones

Reservas.cancelados <- as.data.frame(table(Reservas$market_segment_type[!is.na(Reservas$market_segment_type) & Reservas$booking_status == "Canceled"]))

Reservas.cancelados <- arrange(Reservas.cancelados, decreasing = TRUE)

colnames(Reservas.cancelados)  <- c("Categoria", "Cancelados")

Reservas.market <- as.data.frame(table(Reservas$market_segment_type[!is.na(Reservas$market_segment_type) & !is.na(Reservas$booking_status)]))

colnames(Reservas.market)  <- c("Categoria", "Total")

Reservas.ratio  <- left_join(Reservas.market,Reservas.cancelados, by= "Categoria")



Reservas.ratio$ratio  <- Reservas.ratio$Cancelados/Reservas.ratio$Total

View(Reservas.ratio)

#Dispersion mes de arribo y tiempos en alquileres

Reservas <- mutate(Reservas,
       fecha = as.Date(paste(!is.na(Reservas$arrival_year),!is.na(Reservas$arrival_month),!is.na(Reservas$arrival_day), sep = "-")))

View(Reservas)

# Proporción de cancelaciones en top alquilado.

#Linea de tiempo donde se vea el pico de alquileres en el modo de alquiler mas solicitado.

#Tipo de familia del TOP 1 alquilado.

