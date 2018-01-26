#Question6

##Load the packages
require(rio)
require(dplyr)
##Load the datasets
NEI<-import("summarySCC_PM25.rds")
SCC<-import("Source_Classification_Code.rds")

##Visualization
png("plot6.png",height=480,width=960)
SCCsub5<-SCC%>%
  filter(grepl("^Highway Veh",Short.Name))
NEIsub6 <-NEI%>%
  filter(fips %in% c("24510","06037"), SCC %in% SCCsub5$SCC)%>%
  group_by(fips,year)%>%
  summarise(Emissions = sum(Emissions))

g1<-ggplot(NEIsub6, aes(y=Emissions,x=as.factor(year),fill=as.factor(year)))+
  geom_bar(stat="identity")+
  facet_grid(.~fips,scales = "free_y")+
  ggtitle('Total Emissions of Motor Vehicle Sources (1999-2002)\nLA, California vs. Baltimore City, Maryland')+
  geom_text(aes(label=round(Emissions,0),size=2, hjust=0.5, vjust=-1),col="black",cex=3)+
  labs(x="year",y=expression(PM[2.5]))+
  theme(legend.position= "none")+
  scale_fill_brewer(palette = "Set2")

NEIsub7<-NEIsub6%>%
  mutate(EmissionChange=ifelse(year-lag(year)>3,NA,(Emissions/lag(Emissions)-1)*100))%>%
  mutate(Year=c(NA,"1999-2002","2002-2005","2005-2008"))

NEIsub7<-na.omit(NEIsub7)
NEIsub7
g2<-ggplot(NEIsub7, aes(y=EmissionChange,x=as.factor(Year),fill=as.factor(Year)))+
  geom_bar(stat="identity")+  facet_grid(.~fips)+
  theme(legend.position = "none")+
  scale_fill_brewer(palette = "Set2")+
  ggtitle('Total Emission Changes of Motor Vehicle Sources\nLA, California vs. Baltimore City, Maryland')+
  geom_text(aes(label=round(EmissionChange,3),size=2, hjust=0.5, vjust=-1),col="black",cex=3)+
  labs(x="year",y=expression(PM[2.5]))
gridExtra::grid.arrange(g1,g2, ncol=2)

dev.off()

