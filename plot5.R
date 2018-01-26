#Question 5
##Load the packages
require(rio)
require(dplyr)

##Load the datasets
NEI<-import("summarySCC_PM25.rds")
SCC<-import("Source_Classification_Code.rds")
##Statistical Summary
SCCsub5<-SCC%>%
  filter(grepl("^Highway Veh",Short.Name))

NEIsub5 <-NEI%>%
  filter(fips=="24510",SCC %in% SCCsub5$SCC)%>%
  group_by(year)%>%
  summarise(Emissions = sum(Emissions))
NEIsub5

##Visualizaton
ggplot(NEIsub5,aes(x=as.factor(year),y= Emissions,fill=as.factor(year)))+geom_line()+geom_bar(stat="identity") +  scale_fill_brewer(palette = "Set2")+ geom_text(aes(label=round(Emissions,0),size=2, hjust=0.5, vjust=-1),col="black",cex=3)+ theme(legend.position= "none")+
  ggtitle('Total Emissions of Motor Vehicle Sources (1999-2002), Baltimore City, Maryland')+
  labs(x="year",y=expression(PM[2.5]))
dev.off()