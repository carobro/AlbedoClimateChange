library(sf)
library(raster)
library(ggplot2)
rm(list=ls())

# load shapefiles 2006
jan06 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2006/jan06.RData"))
feb06 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2006/feb06.RData"))
mar06 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2006/mar06.RData"))
apr06 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2006/apr06.RData"))
may06 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2006/may06.RData"))
jun06 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2006/jun06.RData"))
jul06 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2006/jul06.RData"))
aug06 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2006/aug06.RData"))
sep06 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2006/sep06.RData"))
oct06 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2006/oct06.RData"))
nov06 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2006/nov06.RData"))
dec06 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2006/dec06.RData"))

# load shapefiles 2012
jan12 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2012/jan12.RData"))
feb12 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2012/feb12.RData"))
mar12 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2012/mar12.RData"))
apr12 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2012/apr12.RData"))
may12 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2012/may12.RData"))
jun12 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2012/jun12.RData"))
jul12 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2012/jul12.RData"))
aug12 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2012/aug12.RData"))
sep12 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2012/sep12.RData"))
oct12 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2012/oct12.RData"))
nov12 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2012/nov12.RData"))
dec12 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2012/dec12.RData"))

# load shapefiles 2018
jan18 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2018/jan18.RData"))
feb18 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2018/feb18.RData"))
mar18 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2018/mar18.RData"))
apr18 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2018/apr18.RData"))
may18 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2018/may18.RData"))
jun18 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2018/jun18.RData"))
jul18 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2018/jul18.RData"))
aug18 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2018/aug18.RData"))
sep18 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2018/sep18.RData"))
oct18 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2018/oct18.RData"))
nov18 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2018/nov18.RData"))
dec18 <- get(load("C:/Users/Caro/Desktop/ClimateChange/2018/dec18.RData"))


data <- list(jan06,feb06,mar06,apr06,may06,jun06,jul06,aug06,sep06,oct06,nov06,dec06,
             jan12,feb12,mar12,apr12,may12,jun12,jul12,aug12,sep12,oct12,nov12,dec12,
             jan18,feb18,mar18,apr18,may18,jun18,jul18,aug18,sep18,oct18,nov18,dec18) 

names(data) <- c("January_2006","February_2006","March_2006","April_2006","May_2006","June_2006",
                 "July_2006","August_2006","September_2006","October_2006","November_2006","December_2006",
                 "January_2012","February_2012","March_2012","April_2012","May_2012","June_2012",
                 "July_2012","August_2012","September_2012","October_2012","November_2012","December_2012",
                 "January_2018","February_2018","March_2018","April_2018","May_2018","June_2018",
                 "July_2018","August_2018","September_2018","October_2018","November_2018","December_2018") 

x <- 0
for (i in data){
  x <- x+1
  albedo <- aggregate(i$layer, by=list(i$LABEL1), median)
  
  print(albedo)
  saveRDS(albedo, file=paste0(("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/"), names(data[x]),".Rda"))
}
