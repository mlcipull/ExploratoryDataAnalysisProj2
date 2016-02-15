#Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽").
#Which city has seen greater changes over time in motor vehicle emissions?

rm(list=ls())

library(data.table)
library(ggplot2)
## This first line will likely take a few seconds. Be patient!
#National Emissions Inventory database
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Maryland.Emissions<-NEI[which(NEI$fips=="24510"),]
motor.emissions<-Maryland.Emissions[which(Maryland.Emissions$type=="ON-ROAD"),]
sum.motor.emissions<-aggregate(motor.emissions$Emissions,by=list(motor.emissions$year),FUN=sum)
colnames(sum.motor.emissions)=c("year","Emissions")
Balt.Fips<-rep("24510",length(sum.motor.emissions$year))
MD.motor.emissions<-cbind(sum.motor.emissions,Balt.Fips)
colnames(MD.motor.emissions)=c("year","Emissions","fips")

California.Emissions<-NEI[which(NEI$fips=="06037"),]
motor.emissions.CA<-California.Emissions[which(California.Emissions$type=="ON-ROAD"),]
sum.cali.motor.emissions<-aggregate(motor.emissions.CA$Emissions,by=list(motor.emissions.CA$year),FUN=sum)
Cali.Fips<-rep("06037",length(sum.cali.motor.emissions$year))
CA.motor.emissions<-cbind(sum.cali.motor.emissions,Cali.Fips)
colnames(CA.motor.emissions)=c("year","Emissions","fips")

png("plot6.png")
both.motor.emission<-rbind(MD.motor.emissions,CA.motor.emissions)
qplot(year,Emissions,data = both.motor.emission,color=fips,geom="line")+ggtitle("Motor Vehicle Emissions in Baltimore (24510) and in Los Angeles (06037)")
dev.off()