library(ggplot2)
library(dplyr)
library(readr)
library(readxl)
library(plotrix)

cbp2 <- c("#000000", "#E6AB02", "#56B4E9", "#009E73",
          "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
Xaxis <- c("23:00","01:00","03:00","05:00","07:00")
## KSS SCORE
KSS <- read_excel("GitStuff/mswake/SpreadsheetsnJASP/kss_score.xlsx")

KSSt<- KSS %>% group_by(Time) %>% summarise(mean = mean(Sleepiness), se = std.error(Sleepiness))
#Overall
KSS$Time=factor(KSS$Time)
KSSt$Time=factor(KSSt$Time)
Hist <- ggplot(KSS, aes(x=Time, y=Sleepiness, fill=Time))+
  geom_col(aes(x=Time, y=Sleepiness),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = KSSt, aes(x = as.numeric(Time), y = as.numeric(mean), ymin = as.numeric(mean - se), ymax = as.numeric(mean + se), width = .1), position=position_dodge(0.35))+
  ylab("KSS Score")+
  xlab("Time")+
  ggtitle("Subjecitve Sleepiness")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(0, 9))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
Hist
#BY SEX
KSS_Sex <- KSS %>% group_by(Time, Sex) %>% summarise(mean = mean(Sleepiness), se = std.error(Sleepiness))
KSS_Sex$Time = factor(KSS_Sex$Time)
Hist <- ggplot(KSS_Sex, aes(x=Time, y=mean, fill = Sex))+
  geom_col(aes(x=Time, y=mean),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = KSS_Sex, aes(x = as.numeric(Time), y = as.numeric(mean), group = Sex, ymin = as.numeric(mean - se), ymax = as.numeric(mean + se), width = .1),position=position_dodge(0.35))+
  ylab("KSS Score")+
  xlab("Time")+
  ggtitle("Subjecitve Sleepiness")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 15))+
  coord_cartesian(ylim=c(0, 9))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2,labels=c("Female","Male"))
Hist
# BY WT
KSS_wt <- KSS %>% group_by(Time, Weight) %>% summarise(mean = mean(Sleepiness), se = std.error(Sleepiness))
KSS_wt$Time = factor(KSS_wt$Time)
KSS_wt$Weight= factor(KSS_wt$Weight)
Hist <- ggplot(KSS_wt, aes(x=Time, y=mean, fill = Weight))+
  geom_col(aes(x=Time, y=mean),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = KSS_wt, aes(x = as.numeric(Time), y = as.numeric(mean), group = Weight, ymin = as.numeric(mean - se), ymax = as.numeric(mean + se), width = .1),position=position_dodge(0.35))+
  ylab("KSS Score")+
  xlab("Time")+
  ggtitle("Subjecitve Sleepiness")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 15))+
  coord_cartesian(ylim=c(0, 9))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
Hist

sleeps<- read_excel("GitStuff/mswake/SpreadsheetsnJASP/sumcount_msevent.xlsx")
sleeps$Time = factor(sleeps$Time)
sleeps$Sex = factor(sleeps$Sex)
sleeps$Weight = factor(sleeps$Weight)

# OVERALL
Hist <- ggplot(sleeps, aes(x=Time, y=Count))+
  geom_col(aes(x=Time, y=Count), fill="#E6AB02",width=0.5,position=position_dodge(width=0.35))+
  ylab("Counts")+
  xlab("Time")+
  ggtitle("Participants with sleep events")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 15))+
  coord_cartesian(ylim=c(0, 30))+
  scale_x_discrete(labels=Xaxis)
Hist
## BY SEX
sleeps<- read_excel("GitStuff/mswake/SpreadsheetsnJASP/summscount_sex.xlsx")
sleeps$Time = factor(sleeps$Time)
sleeps$Sex = factor(sleeps$Sex)

Hist <- ggplot(sleeps, aes(x=Time, y=Counts, fill=Sex))+
  geom_col(aes(x=Time, y=Counts), width=0.5,position=position_dodge(width=0.35))+
  ylab("Counts")+
  xlab("Time")+
  ggtitle("Participants with sleep events")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 15))+
  coord_cartesian(ylim=c(0, 20))+
  scale_x_discrete(labels=Xaxis)+
scale_fill_manual(values=cbp2)
Hist
## BY WEIGHT GROUP
sleeps<- read_excel("GitStuff/mswake/SpreadsheetsnJASP/summscount_wt.xlsx")
sleeps$Time = factor(sleeps$Time)
sleeps$Weight = factor(sleeps$Weight)
Hist <- ggplot(sleeps, aes(x=Time, y=Counts, fill=Weight))+
  geom_col(aes(x=Time, y=Counts), width=0.5,position=position_dodge(width=0.35))+
  ylab("Counts")+
  xlab("Time")+
  ggtitle("Participants with sleep events")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 15))+
  coord_cartesian(ylim=c(0, 20))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
Hist

##MicroSleeps
sum_msevents <- data.frame(sum_msevents)
sum_msevents$Time =factor(sum_msevents$Time,labels=c("07:00","23:00"))


Hist <- ggplot(sum_msevents, aes(x= order(Time,count), y=mean_onset))+
  geom_col(aes(x=Time, y=mean_onset),fill="#E6AB02",width=0.5,position=position_dodge(width=0.35))+
  ylab("Mean time to first sleep/microsleep episode (s)")+
  theme(axis.title = element_text(size = 15), axis.text = element_text(size = 15),legend.title=element_text(size = 12),legend.text=element_text(size=12))+
  xlab("Time")
Hist