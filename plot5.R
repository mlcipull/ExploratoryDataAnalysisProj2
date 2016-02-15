#5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

rm(list=ls())

library(data.table)
library(ggplot2)
## This first line will likely take a few seconds. Be patient!
#National Emissions Inventory database
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# 4. Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999–2008?

Maryland.Emissions<-NEI[which(NEI$fips=="24510"),]
motor.emissions<-Maryland.Emissions[which(Maryland.Emissions$type=="ON-ROAD"),]
sum.motor.emissions<-aggregate(motor.emissions$Emissions,by=list(motor.emissions$year),FUN=sum)
colnames(sum.motor.emissions)=c("year","Emissions")

png(filename="plot5.png")
qplot(year,Emissions,data=sum.motor.emissions,geom="line") + ggtitle("Motor Vehicle Emissions in Baltimore City,MD")
dev.off()