##Process MODIS and CORINE Data
library(sf)
library(raster)
library(ggplot2)
library(reshape2)
library(plyr)

rm(list=ls())
### 2006 ###
jan06 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/January_2006.Rda")
feb06 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/February_2006.Rda")
mar06 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/March_2006.Rda")
apr06 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/April_2006.Rda")
may06 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/May_2006.Rda")
jun06 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/June_2006.Rda")
jul06 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/July_2006.Rda")
aug06 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/August_2006.Rda")
sep06 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/September_2006.Rda")
oct06 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/October_2006.Rda")
nov06 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/November_2006.Rda")
dec06 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/December_2006.Rda")

### 2012 ###
jan12 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/January_2012.Rda")
feb12 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/February_2012.Rda")
mar12 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/March_2012.Rda")
apr12 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/April_2012.Rda")
may12 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/May_2012.Rda")
jun12 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/June_2012.Rda")
jul12 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/July_2012.Rda")
aug12 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/August_2012.Rda")
sep12 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/September_2012.Rda")
oct12 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/October_2012.Rda")
nov12 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/November_2012.Rda")
dec12 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/December_2012.Rda")

## 2018 ###
jan18 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/January_2018.Rda")
feb18 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/February_2018.Rda")
mar18 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/March_2018.Rda")
apr18 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/April_2018.Rda")
may18 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/May_2018.Rda")
jun18 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/June_2018.Rda")
jul18 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/July_2018.Rda")
aug18 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/August_2018.Rda")
sep18 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/September_2018.Rda")
oct18 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/October_2018.Rda")
nov18 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/November_2018.Rda")
dec18 <- readRDS("C:/Users/Caro/Desktop/ClimateChange/RDS_VALUES/December_2018.Rda")

master <- data.frame(
  "Year"  = c(c(rep("2006", 12)),c(rep("2012", 12))),
  "month" = c(1:12),
  "Artificial surfaces"                   = c(jan06$Albedo[1],feb06$Albedo[1],mar06$Albedo[1],apr06$Albedo[1], may06$Albedo[1], jun06$Albedo[1],jul06$Albedo[1],aug06$Albedo[1],sep06$Albedo[1],oct06$Albedo[1],nov06$Albedo[1],dec06$Albedo[1],jan12$Albedo[1],feb12$Albedo[1],mar12$Albedo[1],apr12$Albedo[1], may12$Albedo[1], jun12$Albedo[1],jul12$Albedo[1],aug12$Albedo[1],sep12$Albedo[1],oct12$Albedo[1],nov12$Albedo[1],dec12$Albedo[1]),
  "Forests"                               = c(jan06$Albedo[2],feb06$Albedo[2],mar06$Albedo[2],apr06$Albedo[2], may06$Albedo[2], jun06$Albedo[2],jul06$Albedo[2],aug06$Albedo[2],sep06$Albedo[2],oct06$Albedo[2],nov06$Albedo[2],dec06$Albedo[2],jan12$Albedo[2],feb12$Albedo[2],mar12$Albedo[2],apr12$Albedo[2], may12$Albedo[2], jun12$Albedo[2],jul12$Albedo[2],aug12$Albedo[2],sep12$Albedo[2],oct12$Albedo[2],nov12$Albedo[2],dec12$Albedo[2]),
  "Heterogeneous agricultural areas"      = c(jan06$Albedo[3],feb06$Albedo[3],mar06$Albedo[3],apr06$Albedo[3], may06$Albedo[3], jun06$Albedo[3],jul06$Albedo[3],aug06$Albedo[3],sep06$Albedo[3],oct06$Albedo[3],nov06$Albedo[3],dec06$Albedo[3],jan12$Albedo[3],feb12$Albedo[3],mar12$Albedo[3],apr12$Albedo[3], may12$Albedo[3], jun12$Albedo[3],jul12$Albedo[3],aug12$Albedo[3],sep12$Albedo[3],oct12$Albedo[3],nov12$Albedo[3],dec12$Albedo[3]),
  "Open spaces"                           = c(jan06$Albedo[4],feb06$Albedo[4],mar06$Albedo[4],apr06$Albedo[4], may06$Albedo[4], jun06$Albedo[4],jul06$Albedo[4],aug06$Albedo[4],sep06$Albedo[4],oct06$Albedo[4],nov06$Albedo[4],dec06$Albedo[4],jan12$Albedo[4],feb12$Albedo[4],mar12$Albedo[4],apr12$Albedo[4], may12$Albedo[4], jun12$Albedo[4],jul12$Albedo[4],aug12$Albedo[4],sep12$Albedo[4],oct12$Albedo[4],nov12$Albedo[4],dec12$Albedo[4]),
  "Vegetation"                            = c(jan06$Albedo[5],feb06$Albedo[5],mar06$Albedo[5],apr06$Albedo[5], may06$Albedo[5], jun06$Albedo[5],jul06$Albedo[5],aug06$Albedo[5],sep06$Albedo[5],oct06$Albedo[5],nov06$Albedo[5],dec06$Albedo[5],jan12$Albedo[5],feb12$Albedo[5],mar12$Albedo[5],apr12$Albedo[5], may12$Albedo[5], jun12$Albedo[5],jul12$Albedo[5],aug12$Albedo[5],sep12$Albedo[5],oct12$Albedo[5],nov12$Albedo[5],dec12$Albedo[5]),
  "Water"                                 = c(jan06$Albedo[6],feb06$Albedo[6],mar06$Albedo[6],apr06$Albedo[6], may06$Albedo[6], jun06$Albedo[6],jul06$Albedo[6],aug06$Albedo[6],sep06$Albedo[6],oct06$Albedo[6],nov06$Albedo[6],dec06$Albedo[6],jan12$Albedo[6],feb12$Albedo[6],mar12$Albedo[6],apr12$Albedo[6], may12$Albedo[6], jun12$Albedo[6],jul12$Albedo[6],aug12$Albedo[6],sep12$Albedo[6],oct12$Albedo[6],nov12$Albedo[6],dec12$Albedo[6]),
  "Wetlands"                              = c(jan06$Albedo[7],feb06$Albedo[7],mar06$Albedo[7],apr06$Albedo[7], may06$Albedo[7], jun06$Albedo[7],jul06$Albedo[7],aug06$Albedo[7],sep06$Albedo[7],oct06$Albedo[7],nov06$Albedo[7],dec06$Albedo[7],jan12$Albedo[7],feb12$Albedo[7],mar12$Albedo[7],apr12$Albedo[7], may12$Albedo[7], jun12$Albedo[7],jul12$Albedo[7],aug12$Albedo[7],sep12$Albedo[7],oct12$Albedo[7],nov12$Albedo[7],dec12$Albedo[7]))

write.csv(master, file = "MasterTabelle.csv",row.names=FALSE)

x <- 1
for (i in 1:24){
  mean <- sum(master[x, 3:9]) /7
  master$class_mean[i] <- mean
  
  sd <- sd(master[x, 3:9])
  master$sd[i] <- sd
  x <- x+1
}

# png(filename="C:/Users/Caro/Desktop/ClimateChange/Albedo.png", width = 900, height = 600, res=100)
ggplot(data=master, aes(x=month, y=class_mean, group=Year, color=Year)) +
  geom_line() + geom_point() + 
  geom_errorbar(aes(ymin=class_mean-sd, ymax=class_mean+sd), width=.2,
                position=position_dodge(0.05)) + scale_color_brewer(palette="Dark2")
#dev.off()

master1 <- data.frame(
  "Year"  = c(c(rep("2006", 12)),c(rep("2012", 12))),
  "month" = c(rep(1),rep(2),rep(3),rep(4),rep(5),rep(6),rep(7),rep(8),rep(9),rep(10),rep(11),rep(12)),
  "class" = c("Artificial surfaces", "Forests", "Heterogeneous agricultural areas", 
              "Open spaces","Vegetation","Water","Wetlands"),
  "2006"  = c(jan06$Albedo[1],jan06$Albedo[2],jan06$Albedo[3],jan06$Albedo[4],jan06$Albedo[5],jan06$Albedo[6],jan06$Albedo[7],
              feb06$Albedo[1],feb06$Albedo[2],feb06$Albedo[3],feb06$Albedo[4],feb06$Albedo[5],feb06$Albedo[6],feb06$Albedo[7],
              mar06$Albedo[1],mar06$Albedo[2],mar06$Albedo[3],mar06$Albedo[4],mar06$Albedo[5],mar06$Albedo[6],mar06$Albedo[7],
              apr06$Albedo[1],apr06$Albedo[2],apr06$Albedo[3],apr06$Albedo[4],apr06$Albedo[5],apr06$Albedo[6],apr06$Albedo[7],
              may06$Albedo[1],may06$Albedo[2],may06$Albedo[3],may06$Albedo[4],may06$Albedo[5],may06$Albedo[6],may06$Albedo[7],
              jun06$Albedo[1],jun06$Albedo[2],jun06$Albedo[3],jun06$Albedo[4],jun06$Albedo[5],jun06$Albedo[6],jun06$Albedo[7],
              jul06$Albedo[1],jul06$Albedo[2],jul06$Albedo[3],jul06$Albedo[4],jul06$Albedo[5],jul06$Albedo[6],jul06$Albedo[7],
              aug06$Albedo[1],aug06$Albedo[2],aug06$Albedo[3],aug06$Albedo[4],aug06$Albedo[5],aug06$Albedo[6],aug06$Albedo[7],
              sep06$Albedo[1],sep06$Albedo[2],sep06$Albedo[3],sep06$Albedo[4],sep06$Albedo[5],sep06$Albedo[6],sep06$Albedo[7],
              oct06$Albedo[1],oct06$Albedo[2],oct06$Albedo[3],oct06$Albedo[4],oct06$Albedo[5],oct06$Albedo[6],oct06$Albedo[7],
              nov06$Albedo[1],nov06$Albedo[2],nov06$Albedo[3],nov06$Albedo[4],nov06$Albedo[5],nov06$Albedo[6],nov06$Albedo[7],
              dec06$Albedo[1],dec06$Albedo[2],dec06$Albedo[3],dec06$Albedo[4],dec06$Albedo[5],dec06$Albedo[6],dec06$Albedo[7]),
              
  "2012"  = c(jan12$Albedo[1],jan12$Albedo[2],jan12$Albedo[3],jan12$Albedo[4],jan12$Albedo[5],jan12$Albedo[6],jan12$Albedo[7],
              feb12$Albedo[1],feb12$Albedo[2],feb12$Albedo[3],feb12$Albedo[4],feb12$Albedo[5],feb12$Albedo[6],feb12$Albedo[7],
              mar12$Albedo[1],mar12$Albedo[2],mar12$Albedo[3],mar12$Albedo[4],mar12$Albedo[5],mar12$Albedo[6],mar12$Albedo[7],
              apr12$Albedo[1],apr12$Albedo[2],apr12$Albedo[3],apr12$Albedo[4],apr12$Albedo[5],apr12$Albedo[6],apr12$Albedo[7],
              may12$Albedo[1],may12$Albedo[2],may12$Albedo[3],may12$Albedo[4],may12$Albedo[5],may12$Albedo[6],may12$Albedo[7],
              jun12$Albedo[1],jun12$Albedo[2],jun12$Albedo[3],jun12$Albedo[4],jun12$Albedo[5],jun12$Albedo[6],jun12$Albedo[7],
              jul12$Albedo[1],jul12$Albedo[2],jul12$Albedo[3],jul12$Albedo[4],jul12$Albedo[5],jul12$Albedo[6],jul12$Albedo[7],
              aug12$Albedo[1],aug12$Albedo[2],aug12$Albedo[3],aug12$Albedo[4],aug12$Albedo[5],aug12$Albedo[6],aug12$Albedo[7],
              sep12$Albedo[1],sep12$Albedo[2],sep12$Albedo[3],sep12$Albedo[4],sep12$Albedo[5],sep12$Albedo[6],sep12$Albedo[7],
              oct12$Albedo[1],oct12$Albedo[2],oct12$Albedo[3],oct12$Albedo[4],oct12$Albedo[5],oct12$Albedo[6],oct12$Albedo[7],
              nov12$Albedo[1],nov12$Albedo[2],nov12$Albedo[3],nov12$Albedo[4],nov12$Albedo[5],nov12$Albedo[6],nov12$Albedo[7],
              dec12$Albedo[1],dec12$Albedo[2],dec12$Albedo[3],dec12$Albedo[4],dec12$Albedo[5],dec12$Albedo[6],dec12$Albedo[7]))
,
  
  "2018"  = c(jan18$Albedo[1],jan18$Albedo[2],jan18$Albedo[3],jan18$Albedo[4],jan18$Albedo[5],jan18$Albedo[6],jan18$Albedo[7],
              feb18$Albedo[1],feb18$Albedo[2],feb18$Albedo[3],feb18$Albedo[4],feb18$Albedo[5],feb18$Albedo[6],feb18$Albedo[7],
              mar18$Albedo[1],mar18$Albedo[2],mar18$Albedo[3],mar18$Albedo[4],mar18$Albedo[5],mar18$Albedo[6],mar18$Albedo[7],
              apr18$Albedo[1],apr18$Albedo[2],apr18$Albedo[3],apr18$Albedo[4],apr18$Albedo[5],apr18$Albedo[6],apr18$Albedo[7],
              may18$Albedo[1],may18$Albedo[2],may18$Albedo[3],may18$Albedo[4],may18$Albedo[5],may18$Albedo[6],may18$Albedo[7],
              jun18$Albedo[1],jun18$Albedo[2],jun18$Albedo[3],jun18$Albedo[4],jun18$Albedo[5],jun18$Albedo[6],jun18$Albedo[7],
              jul18$Albedo[1],jul18$Albedo[2],jul18$Albedo[3],jul18$Albedo[4],jul18$Albedo[5],jul18$Albedo[6],jul18$Albedo[7],
              aug18$Albedo[1],aug18$Albedo[2],aug18$Albedo[3],aug18$Albedo[4],aug18$Albedo[5],aug18$Albedo[6],aug18$Albedo[7],
              sep18$Albedo[1],sep18$Albedo[2],sep18$Albedo[3],sep18$Albedo[4],sep18$Albedo[5],sep18$Albedo[6],sep18$Albedo[7],
              oct18$Albedo[1],oct18$Albedo[2],oct18$Albedo[3],oct18$Albedo[4],oct18$Albedo[5],oct18$Albedo[6],oct18$Albedo[7],
              nov18$Albedo[1],nov18$Albedo[2],nov18$Albedo[3],nov18$Albedo[4],nov18$Albedo[5],nov18$Albedo[6],nov18$Albedo[7],
              dec18$Albedo[1],dec18$Albedo[2],dec18$Albedo[3],dec18$Albedo[4],dec18$Albedo[5],dec18$Albedo[6],dec18$Albedo[7])),
  
  "Artificial surfaces"                   = c(,feb06$Albedo[1],mar06$Albedo[1],apr06$Albedo[1], may06$Albedo[1], jun06$Albedo[1],jul06$Albedo[1],aug06$Albedo[1],sep06$Albedo[1],oct06$Albedo[1],nov06$Albedo[1],dec06$Albedo[1],jan12$Albedo[1],feb12$Albedo[1],mar12$Albedo[1],apr12$Albedo[1], may12$Albedo[1], jun12$Albedo[1],jul12$Albedo[1],aug12$Albedo[1],sep12$Albedo[1],oct12$Albedo[1],nov12$Albedo[1],dec12$Albedo[1]),
  "Forests"                               = c(,feb06$Albedo[2],mar06$Albedo[2],apr06$Albedo[2], may06$Albedo[2], jun06$Albedo[2],jul06$Albedo[2],aug06$Albedo[2],sep06$Albedo[2],oct06$Albedo[2],nov06$Albedo[2],dec06$Albedo[2],jan12$Albedo[2],feb12$Albedo[2],mar12$Albedo[2],apr12$Albedo[2], may12$Albedo[2], jun12$Albedo[2],jul12$Albedo[2],aug12$Albedo[2],sep12$Albedo[2],oct12$Albedo[2],nov12$Albedo[2],dec12$Albedo[2]),
  "Heterogeneous agricultural areas"      = c(,feb06$Albedo[3],mar06$Albedo[3],apr06$Albedo[3], may06$Albedo[3], jun06$Albedo[3],jul06$Albedo[3],aug06$Albedo[3],sep06$Albedo[3],oct06$Albedo[3],nov06$Albedo[3],dec06$Albedo[3],jan12$Albedo[3],feb12$Albedo[3],mar12$Albedo[3],apr12$Albedo[3], may12$Albedo[3], jun12$Albedo[3],jul12$Albedo[3],aug12$Albedo[3],sep12$Albedo[3],oct12$Albedo[3],nov12$Albedo[3],dec12$Albedo[3]),
  "Open spaces"                           = c(,feb06$Albedo[4],mar06$Albedo[4],apr06$Albedo[4], may06$Albedo[4], jun06$Albedo[4],jul06$Albedo[4],aug06$Albedo[4],sep06$Albedo[4],oct06$Albedo[4],nov06$Albedo[4],dec06$Albedo[4],jan12$Albedo[4],feb12$Albedo[4],mar12$Albedo[4],apr12$Albedo[4], may12$Albedo[4], jun12$Albedo[4],jul12$Albedo[4],aug12$Albedo[4],sep12$Albedo[4],oct12$Albedo[4],nov12$Albedo[4],dec12$Albedo[4]),
  "Vegetation"                            = c(,feb06$Albedo[5],mar06$Albedo[5],apr06$Albedo[5], may06$Albedo[5], jun06$Albedo[5],jul06$Albedo[5],aug06$Albedo[5],sep06$Albedo[5],oct06$Albedo[5],nov06$Albedo[5],dec06$Albedo[5],jan12$Albedo[5],feb12$Albedo[5],mar12$Albedo[5],apr12$Albedo[5], may12$Albedo[5], jun12$Albedo[5],jul12$Albedo[5],aug12$Albedo[5],sep12$Albedo[5],oct12$Albedo[5],nov12$Albedo[5],dec12$Albedo[5]),
  "Water"                                 = c(,feb06$Albedo[6],mar06$Albedo[6],apr06$Albedo[6], may06$Albedo[6], jun06$Albedo[6],jul06$Albedo[6],aug06$Albedo[6],sep06$Albedo[6],oct06$Albedo[6],nov06$Albedo[6],dec06$Albedo[6],jan12$Albedo[6],feb12$Albedo[6],mar12$Albedo[6],apr12$Albedo[6], may12$Albedo[6], jun12$Albedo[6],jul12$Albedo[6],aug12$Albedo[6],sep12$Albedo[6],oct12$Albedo[6],nov12$Albedo[6],dec12$Albedo[6]),
  "Wetlands"                              = c(,feb06$Albedo[7],mar06$Albedo[7],apr06$Albedo[7], may06$Albedo[7], jun06$Albedo[7],jul06$Albedo[7],aug06$Albedo[7],sep06$Albedo[7],oct06$Albedo[7],nov06$Albedo[7],dec06$Albedo[7],jan12$Albedo[7],feb12$Albedo[7],mar12$Albedo[7],apr12$Albedo[7], may12$Albedo[7], jun12$Albedo[7],jul12$Albedo[7],aug12$Albedo[7],sep12$Albedo[7],oct12$Albedo[7],nov12$Albedo[7],dec12$Albedo[7]))

master1 <- melt(master1[,1], id.vars="Year")
master1$Year <- paste(c(rep(c(rep("2006",12),rep("2012",12)),7)))
master1$variable <- factor(master1$variable,
                           levels = c("Wetlands","Water","Artificial.surfaces",
                                      "Open.spaces","Forests","Vegetation", 
                                      "Heterogeneous.agricultural.areas"))

ggplot(data=master1, aes(x=month, y=class_mean, group=Year, color=Year)) +
  geom_line() + geom_point() + geom_errorbar(aes(ymin=class_mean-sd, ymax=class_mean+sd), width=.2,
                                             position=position_dodge(0.05)) +
  scale_color_brewer(palette="Dark2")

