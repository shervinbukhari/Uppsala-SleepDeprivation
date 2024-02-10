library(ggplot2)
library(dplyr)
library(readr)
library(readxl)
library(plotrix)
library(pracma)
peakalpha <- read_excel("GitStuff/mswake/SpreadsheetsnJASP/peakalphafreq.xlsx")
peakalpha <- na.omit(peakalpha)

peakalpha %>% filter(Time=="0")
peak01<-peakalpha %>% filter(Time=="1")
peak03<-peakalpha %>% filter(Time=="3")
peak05<-peakalpha %>% filter(Time=="5")
peak07<-peakalpha %>% filter(Time=="7")

Hist23 <- ggplot(peak23, aes(x=Time, y=Counts, fill=Weight))+
  geom_col(aes(x=Time, y=Counts), width=0.5,position=position_dodge(width=0.35))+
  ylab("Counts")+
  xlab("Time")+
  ggtitle("Participants with sleep events")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 15))+
  coord_cartesian(ylim=c(0, 20))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
Hist
