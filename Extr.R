##Process MODIS and CORINE Data
library(mapview)
library(MODIS)
library(sf)
library(raster)
library(rgdal)

rm(list=ls())
Dland <- st_read("C:/Users/Caro/Downloads/vg2500_geo84/vg2500_geo84/vg2500_sta.shp")
liste <-read.csv("C:/Users/Caro/Desktop/ClimateChange/CLC2006/clc2000legend.csv")

##########   2006   ######################################################################
#corine data load plus merge clc data table with land use names
co06 <- st_read("C:/Users/Caro/Desktop/ClimateChange/CLC2006")
co06 <- merge(co06, liste, by.x="CODE_06", by.y="CLC_CODE")
co06 <- co06[,-(1:5)]
co06 <- co06[,-(2:4)]

main      <- "C:/Users/Caro/Downloads/Daten_MODIS/Daten_MODIS/"
January06   <- raster(paste0(main,"jan06shortmed.grd"))
February06  <- raster(paste0(main,"feb06shortmed.grd"))
March06     <- raster(paste0(main,"maerz06shortmed.grd"))
April06     <- raster(paste0(main,"april06shortmed.grd"))
May06       <- raster(paste0(main,"may06shortmed.grd"))
June06      <- raster(paste0(main,"june06shortmed.grd"))
July06      <- raster(paste0(main,"july06shortmed.grd"))
August06    <- raster(paste0(main,"aug06shortmed.grd"))
September06 <- raster(paste0(main,"sep06shortmed.grd"))
October06   <- raster(paste0(main,"oct06shortmed.grd"))
November06  <- raster(paste0(main,"nov06shortmed.grd"))
December06  <- raster(paste0(main,"dec06shortmed.grd"))

yearshort06 <- stack(January06, February06,March06,April06,May06,June06,July06,August06,September06,October06,November06,December06)
st_transform(Dland, crs=projection(yearshort06)) -> Dland
yearshort06 <- crop(yearshort06, Dland)
yearshort06 <- mask(yearshort06, Dland)
writeRaster(yearshort06, file="C:/Users/Caro/Desktop/ClimateChange/stack06short.grd", overwrite=TRUE)

#transform crs corine data to rasta 
crs(co06) ##"+proj=utm +zone=32 +datum=WGS84 +units=m +no_defs"
crs(yearshort06) ##+proj=sinu +lon_0=0 +x_0=0 +y_0=0 +a=6371007.181 +b=6371007.181 +units=m +no_defs 
st_transform(co06, crs=projection(yearshort06)) -> co06

month06 <- list(January06,February06,March06,April06,May06,June06,July06,August06,September06,October06,November06,December06)
names(month06) <- c("jan06","feb06","mar06","apr06","may06","jun06","jul06","aug06","sep06","oct06","nov06","dec06")

x <- 0
for (i in month06){
        x <- x+1
        ### Extract raster information
        print(i)
        extr <- extract(i, co06, df = TRUE, fun=median, na.rm=TRUE)
        extr <- extr[complete.cases(extr),]
        co06$PolyID<- 1:nrow(co06)
        extr <- merge(extr, co06, by.x="ID", by.y="PolyID")
        print(head(extr))
        save(extr, file=paste0(("C:/Users/Caro/Desktop/ClimateChange/2006/"), names(month06[x]),".RData"))
}
############    2012    #########################################################################

co12 <- readOGR("C:/Users/Caro/Desktop/ClimateChange/CLC2012/CLC2012.shp")
# co12 <- st_read("C:/Users/Caro/Desktop/ClimateChange/CLC2012")
# co12 <- read_sf("C:/Users/Caro/Desktop/ClimateChange/CLC2012/CLC2012.shp")
liste <-read.csv("C:/Users/Caro/Desktop/ClimateChange/CLC2006/clc2000legend.csv")
co12 <- merge(co12, liste, by.x="CODE_12", by.y="CLC_CODE")
co12 <- spTransform(co12,CRS=CRS("+proj=sinu +lon_0=0 +x_0=0 +y_0=0 +a=6371007.181 +b=6371007.181 +units=m +no_defs"))
# co12 <- co12[,-(1:10)]
# co12 <- co12[,-(2:4)]

main      <- "C:/Users/Caro/Downloads/Daten_MODIS/Daten_MODIS/"
January12   <- raster(paste0(main,"jan12shortmed.grd"))
February12  <- raster(paste0(main,"feb12shortmed.grd"))
March12     <- raster(paste0(main,"maerz12shortmed.grd"))
April12     <- raster(paste0(main,"april12swmed.grd"))
May12       <- raster(paste0(main,"may12shortmed.grd"))
June12      <- raster(paste0(main,"june12shortmed.grd"))
July12      <- raster(paste0(main,"july12shortmed.grd"))
August12    <- raster(paste0(main,"aug12shortmed.grd"))
September12 <- raster(paste0(main,"sep12shortmed.grd"))
October12   <- raster(paste0(main,"oct12shortmed.grd"))
November12  <- raster(paste0(main,"nov12shortmed.grd"))
December12  <- raster(paste0(main,"Dec12sw_med.grd"))

#January12,February12,March12,April12,May12,June12,July12,August12,September12,
yearshort12 <- stack(October12,November12,December12)
Dland <- st_transform(Dland, crs=projection(yearshort12))
yearshort12 <- crop(yearshort12, Dland)
yearshort12 <- mask(yearshort12, Dland)
writeRaster(yearshort12, file="C:/Users/Caro/Desktop/ClimateChange/stack12short.grd", overwrite=TRUE)


#transform crs corine data to rasta 
crs(co12) ##"+proj=utm +zone=32 +datum=WGS84 +units=m +no_defs"
crs(yearshort12) ##+proj=sinu +lon_0=0 +x_0=0 +y_0=0 +a=6371007.181 +b=6371007.181 +units=m +no_defs 
st_transform(co12, crs=projection(yearshort12)) -> co12
# crs(co12) <- "+proj=sinu +lon_0=0 +x_0=0 +y_0=0 +a=6371007.181 +b=6371007.181 +units=m +no_defs"
# co12 <- projectRaster(co12, crs=projection(yearshort12))

# January12, February12,March12,April12,May12,June12,July12,August12,September12,
month12 <- list(October12,November12,December12)
# "jan12","feb12","mar12","apr12","may12","jun12","jul12","aug12","sep12",
names(month12) <- c("oct12","nov12","dec12")

extr <- extract(January12, co12, df = TRUE, fun=median, na.rm=TRUE)

x <- 0
for (i in month12){
        x <- x+1
        ### Extract raster information
        print(i)
        extr <- extract(i, co12, df = TRUE, fun=median, na.rm=TRUE)
        extr <- extr[complete.cases(extr),]
        co12$PolyID<- 1:nrow(co12)
        extr <- merge(extr, co12, by.x="ID", by.y="PolyID")
        print(head(extr))
        save(extr, file=paste0(("C:/Users/Caro/Desktop/ClimateChange/2012/"), names(month12[x]),".RData"))
}
#####################    2018   ###########################################################
#co18 <- st_read("C:/Users/Caro/Desktop/ClimateChange/CLC2018")
co18 <- readOGR("C:/Users/Caro/Downloads/CLC2018/CLC2018/clc18_de.shp")
liste <-read.csv("C:/Users/Caro/Desktop/ClimateChange/CLC2006/clc2000legend.csv")
co18 <- merge(co18, liste, by.x="CODE_18", by.y="CLC_CODE")
co18 <- spTransform(co18,CRS=CRS("+proj=sinu +lon_0=0 +x_0=0 +y_0=0 +a=6371007.181 +b=6371007.181 +units=m +no_defs"))
# co18 <- co18[,-(1:5)]
# co18 <- co18[,-(2:4)]

main      <- "C:/Users/Caro/Downloads/Daten_MODIS/Daten_MODIS/"
January18   <- raster(paste0(main,"Jan18sw_med.grd"))
February18  <- raster(paste0(main,"feb18sw_med.grd"))
March18     <- raster(paste0(main,"maerz18sw_med.grd"))
April18     <- raster(paste0(main,"april18sw_med.grd"))
May18       <- raster(paste0(main,"may18shortmed.grd"))
June18      <- raster(paste0(main,"june18shortmed.grd"))
July18      <- raster(paste0(main,"july18shortmed.grd"))
August18    <- raster(paste0(main,"aug18sw_med.grd"))
September18 <- raster(paste0(main,"Sep18_sw_med.grd"))
October18   <- raster(paste0(main,"Okt18sw_med.grd"))
November18  <- raster(paste0(main,"Nov18sw_med.grd"))
December18  <- raster(paste0(main,"Dec18sw_med.grd"))

yearshort18 <- stack(January18, February18,March18,April18,May18,June18,July18,August18,September18,October18,November18,December18)
st_transform(Dland, crs=projection(yearshort18)) -> Dland
yearshort18 <- crop(yearshort18, Dland)
yearshort18 <- mask(yearshort18, Dland)
# writeRaster(yearshort18, file="C:/Users/Caro/Desktop/ClimateChange/stack18short.grd", overwrite=TRUE)


#transform crs corine data to rasta 
# crs(co18) ##"+proj=utm +zone=32 +datum=WGS84 +units=m +no_defs"
# crs(yearshort18) ##+proj=sinu +lon_0=0 +x_0=0 +y_0=0 +a=6371007.181 +b=6371007.181 +units=m +no_defs 
# st_transform(co18, crs=projection(yearshort18)) -> co18
# crs(co18) <- "+proj=sinu +lon_0=0 +x_0=0 +y_0=0 +a=6371007.181 +b=6371007.181 +units=m +no_defs"
# co18 <- projectRaster(co18, crs=projection(yearshort18))
# res_corine <- resample(co18, yearshort18)
# stack18 <- stack(res_corine, yearshort18)

crs(yearshort18) ##+proj=sinu +lon_0=0 +x_0=0 +y_0=0 +a=6371007.181 +b=6371007.181 +units=m +no_defs 
st_transform(co18, crs=projection(yearshort18)) -> co18

month18 <- list(January18,February18,March18,April18,May18,June18,July18,August18,September18,October18,November18,December18)
names(month18) <- c("jan18","feb18","mar18","apr18","may18","jun18","jul18","aug18","sep18","oct18","nov18","dec18")


# extr <- extract(January18, co18, df = TRUE, fun=median, na.rm=TRUE)
# test <- merge(January18, co18)


 x <- 0
 for (i in month18){
         x <- x+1
         ### Extract raster information
         print(i)
         extr <- extract(i, co18, df = TRUE, fun=median, na.rm=TRUE)
         print("test1")
         extr <- extr[complete.cases(extr),]
         co18$PolyID<- 1:nrow(co18)
         extr <- merge(extr, co18, by.x="ID", by.y="PolyID")
         print(head(extr))
         save(extr, file=paste0(("C:/Users/Caro/Desktop/ClimateChange/2018/"), names(month18[x]),".RData"))
 }

