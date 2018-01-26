#Question 2 
##Load the packages
require(rio)
require(dplyr)

##Load the datasets
NEI<-import("summarySCC_PM25.rds")
SCC<-import("Source_Classification_Code.rds")

##Statistic Summary
NEIsub2<-NEI%>%
  filter(fips=="24510")%>%
  group_by(year)%>%
  summarize(Emissions=sum(Emissions))
NEIsub2
##Visualization
png("plot2.png",height=480,width=480)
plot2<-barplot(NEIsub2$Emissions,xlab="Year",ylab=expression('PM'[2.5]),main="Total Emissions in Baltimore City, MD",col="lightblue",  names.arg=c(1999,2002,2005,2008))
text(NEIsub2$Emissions-150,labels=round(NEIsub2$Emissions,0), cex=.8,col="red")
dev.off()