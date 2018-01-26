#Question 3
##Load the packages
require(rio)
require(dplyr)

##Load the datasets
NEI<-import("summarySCC_PM25.rds")
SCC<-import("Source_Classification_Code.rds")

##Statistical Summary
library(ggplot2)
NEIsub3<-NEI%>%
  filter(fips=="24510")%>%
  group_by(year,type)%>%
  summarise(Emissions=sum(Emissions))

##Visualization
png("plot3.png",height=480,width=480)
ggplot(NEIsub3,aes(x=as.factor(year),y=Emissions,fill=as.factor(year)))+
  geom_bar(stat="identity")+
  facet_grid(.~type)+
  theme_grey()+
  ggtitle("Emissions per Type in Baltimore City, Maryland")+
  labs(x="year",y=expression(PM[2.5]))+
  scale_fill_brewer(palette = "Set2")
dev.off()