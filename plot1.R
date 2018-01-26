
#Question 1
##Load the packages
require(rio)
require(dplyr)

##Load the datasets
NEI<-import("summarySCC_PM25.rds")
SCC<-import("Source_Classification_Code.rds")

##Statistic Summary
NEIsub1<-NEI%>%
  group_by(year)%>%
  summarize(Subtotal=sum(Emissions))
NEIsub1
##Visualization
png("plot1.png",height=480,width=480)
plot(NEIsub1$year,NEIsub1$Subtotal,xlab="Year",ylab="Total Emissions",main="Total Emissions for 1999,2002,2005 and 2008",col="red",pch=16)
lines(NEIsub1$year,NEIsub1$Subtotal,col="red")
dev.off()
