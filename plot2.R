## Exploratory Data Analysis Course Project
rm(list=ls())

library(data.table)
## This first line will likely take a few seconds. Be patient!
#National Emissions Inventory database
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
#(𝚏𝚒𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶") from 1999
#to 2008? Use the base plotting system to make a plot answering this question.

Maryland.Emissions<-NEI[which(NEI$fips=="24510"),]
sum.each.year.MD<-aggregate(Maryland.Emissions$Emissions,by=list(Maryland.Emissions$year,Maryland.Emissions$Pollutant),FUN=sum)
colnames(sum.each.year.MD)=c("year","pollutant","emissions")

png(filename = "plot2.png")
barplot(sum.each.year.MD$emissions,names.arg = sum.each.year.MD$year,main="PM 2.5 Emissions for Baltimore City, Maryland",ylab="emissions (in tons)",xlab="years")
dev.off()
