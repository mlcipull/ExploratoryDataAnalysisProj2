## Exploratory Data Analysis Course Project
rm(list=ls())

library(data.table)
## This first line will likely take a few seconds. Be patient!
#National Emissions Inventory database
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from
#all sources for each of the years 1999, 2002, 2005, and 2008.

sum.each.year<-aggregate(NEI$Emissions,by=list(NEI$year,NEI$Pollutant),FUN=sum)
colnames(sum.each.year)=c("year","pollutant","emissions")

png(filename = "plot1.png")
barplot(sum.each.year$emissions,names.arg = sum.each.year$year,main="PM 2.5 Emissions",ylab="emissions (in tons)",xlab="years")
dev.off()