#Question 4 
##Load the packages
require(rio)
require(dplyr)

##Load the datasets
NEI<-import("summarySCC_PM25.rds")
SCC<-import("Source_Classification_Code.rds")

##Statistical Summary
SCCsub4<-SCC%>%
  filter(grepl("coal",Short.Name,ignore.case = T))
##Visualization
png("plot4.png",height=480,width=480)
NEIsub4<-NEI%>%
  filter(SCC %in% SCCsub4$SCC)%>%
  group_by(year)%>%
  summarise(Subtotal4=sum(Emissions))
attach(NEIsub4)
plot(year,Subtotal4,pch=16,col="red",cex=1.5)
lines(year,Subtotal4,col="red",lwd=2)
dev.off()