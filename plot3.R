## Exploratory Data Analysis Course Project
rm(list=ls())

library(data.table)
library(ggplot2)
## This first line will likely take a few seconds. Be patient!
#National Emissions Inventory database
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# 3. Of the four types of sources indicated by the 𝚝𝚢𝚙𝚎 (point, nonpoint, onroad, nonroad) variable,
#which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008?
#Use the ggplot2 plotting system to make a plot answer this question.
Maryland.Emissions<-NEI[which(NEI$fips=="24510"),]
sum.each.year.MD<-aggregate(Maryland.Emissions$Emissions,by=list(Maryland.Emissions$year,Maryland.Emissions$type),FUN=sum)
colnames(sum.each.year.MD)=c("year","type","Emissions")

png(filename = "plot3.png")
plot<-ggplot(sum.each.year.MD,aes(year,Emissions,color=type))
plot.vars <- plot + geom_line() + xlab("Year") + ylab("Total PM 2.5 Emissions") +
  ggtitle('Total Emissions in Baltimore City, Maryland: 1999 to 2008')
print(plot.vars)
dev.off()