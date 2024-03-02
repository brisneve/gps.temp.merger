# This maps outs the merged GPS data and temperature data

map_gps_temp <- function(df){

  libraries <- c("geosphere", "ggmap", "viridis", "tidyverse")

  if(!require(tidyverse)){
    install.packages("tidyverse")
    library(tidyverse)
  }

  if(!require(geosphere)){
    install.packages("geosphere")
    library(geosphere)
  }

  if(!require(ggmap)){
    install.packages("ggmap")
    library(ggmap)
  }

  if(!require(viridis)){
    install.packages("viridis")
    library(viridis)
  }


  coor_centroid <- centroid(df[,1:2])

  map <- get_map(location = c(lon = coor_centroid[1], lat = coor_centroid[2]), zoom = 12, source="google")

  ggmap(map)+
    geom_point(data=df,aes(lon,lat,color=temp))+
    scale_color_viridis(discrete = FALSE, option="H", name = "Temperature")+
    xlab("Longitude")+
    ylab("Latitude")+
    theme(legend.position=c(0.75,0.1),
          legend.direction = "horizontal",
          legend.background = element_blank())

}
