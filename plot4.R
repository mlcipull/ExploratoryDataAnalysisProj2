## Exploratory Data Analysis Course Project
rm(list=ls())

library(data.table)
library(ggplot2)
## This first line will likely take a few seconds. Be patient!
#National Emissions Inventory database
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# 4. Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999–2008?

Emissions.SCC<-merge(NEI,SCC,by="SCC")
Coal.Emissions <- grep("coal",Emissions.SCC$Short.Name) #Gives the rows where coal is

Coal.Only<-Emissions.SCC[Coal.Emissions,]
sum.each.year<-aggregate(Coal.Only$Emissions,by=list(Coal.Only$year),FUN = sum)
colnames(sum.each.year)=c("year","emissions")

png(filename = "plot4.png")
barplot(sum.each.year$emissions,names.arg = sum.each.year$year,main="Total Coal Combusion Source Emissions",,ylab="emissions (in tons)",xlab="years")
dev.off()