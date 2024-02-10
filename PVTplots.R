library(ggplot2)
library(dplyr)
library(readr)
library(readxl)
library(plotrix)
cbp2 <- c("#000000", "#E6AB02", "#56B4E9", "#009E73",
          "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
Xaxis <- c("23:00","01:00","03:00","05:00","07:00")
pvt_rs<-read_excel("GitStuff/mswake/SpreadsheetsnJASP/responsespeed_pvt.xls")
pvt_rs$Time=factor(pvt_rs$var_Time)
pvt_rs$Weight=factor(pvt_rs$Weight)
pvt_rs$Sex=factor(pvt_rs$Gender)
pvt_rsw<- pvt_rs %>% filter(Condition=="W")
pvt_rsws<- pvt_rsw %>%group_by(Time,sub, Weight) %>% summarise(mean = mean(Response_speed), se=std.error(Response_speed))
pvt_rswt <- pvt_rsw %>% group_by(Time) %>% summarise(mean = mean(Response_speed), se=std.error(Response_speed))
pvt_rsw_wt <- pvt_rsw %>% group_by(Time, Weight) %>% summarise(mean = mean(Response_speed), se=std.error(Response_speed))
pvt_rsw_sx <- pvt_rsw %>% group_by(Time, Sex) %>% summarise(mean = mean(Response_speed), se=std.error(Response_speed))
#OVERALL
pvt_rs_sc <- ggplot(pvt_rsw, aes(x = Time, y = Response_speed, fill=Time))+
  geom_flat_violin(aes(fill=Time),position = position_nudge(x = .01, y = 0), adjust = 1.5, trim = FALSE)+
  geom_point(aes(x = as.numeric(Time)-.15, y = Response_speed),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("Response Speed")+
  xlab("Time")+
  ggtitle("Psychomotor Vigilance")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "none")+
  scale_fill_manual(values=cbp2)
pvt_rs_sc
pvt_rs_bp <- ggplot(pvt_rswt, aes(x=Time, y=mean, fill = Time))+
  geom_col(aes(x=Time, y=mean),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = pvt_rswt, aes(x = as.numeric(Time), y = as.numeric(mean), ymin = as.numeric(mean - se), ymax = as.numeric(mean + se), width = .1),position=position_dodge(0.35))+
  ylab("Response Speed")+
  xlab("Time")+
  ggtitle("PVT performance")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(3.1, 3.4))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "none")+
  scale_fill_manual(values=cbp2)
pvt_rs_bp

#WT
sc_pvt_wt <- ggplot(pvt_rsw, aes(x = Time, y = Response_speed, fill=Weight))+
  geom_flat_violin(aes(fill=Weight),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(Time)-.15, y = Response_speed, colour=Weight),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("Response Speed")+
  xlab("Time")+
  ggtitle("PVT performance")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "right")+
  scale_fill_manual(values=cbp2)+
  scale_color_manual(values=cbp2)
sc_pvt_wt
bp_pvt_wt <- ggplot(pvt_rsw_wt, aes(x=Time, y=mean, fill = Weight))+
  geom_col(aes(x=Time, y=mean),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = pvt_rsw_wt, aes(x = as.numeric(Time), y = as.numeric(mean), ymin = as.numeric(mean - se), ymax = as.numeric(mean + se), width = .1),position=position_dodge(0.35))+
  ylab("Response speed")+
  xlab("Time")+
  ggtitle("PVT performance")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(3, 3.5))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
bp_pvt_wt
#SX
sc_pvt_sx <- ggplot(pvt_rsw, aes(x = Time, y = Response_speed, fill=Sex))+
  geom_flat_violin(aes(fill=Sex),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(Time)-.15, y = Response_speed, colour=Sex),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("Response Speed")+
  xlab("Time")+
  ggtitle("PVT performance")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "right")+
  scale_fill_manual(values=cbp2)+
  scale_color_manual(values=cbp2)
sc_pvt_sx
bp_pvt_sx <- ggplot(pvt_rsw_sx, aes(x=Time, y=mean, fill = Sex))+
  geom_col(aes(x=Time, y=mean),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = pvt_rsw_sx, aes(x = as.numeric(Time), y = as.numeric(mean), ymin = as.numeric(mean - se), ymax = as.numeric(mean + se), width = .1),position=position_dodge(0.35))+
  ylab("Response speed")+
  xlab("Time")+
  ggtitle("PVT performance")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(3.0, 3.5))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
bp_pvt_sx

lapses<-read_excel("GitStuff/mswake/SpreadsheetsnJASP/PVT_RS_lapses.xls")
lapses$Time=factor(lapses$Time)
lapses$Weight=factor(lapses$Weight)
lapses$Sex=factor(lapses$Gender)
lapses_w<- lapses %>% filter(condition=="W")
lapsest_w <- lapses_w %>% group_by(Time) %>% summarise(mean = mean(total_lapses), se=std.error(total_lapses))
lapses_wt <- lapses_w %>% group_by(Time, Weight) %>% summarise(mean = mean(total_lapses), se=std.error(total_lapses))
lapses_sx <- lapses_w %>% group_by(Time, Sex) %>% summarise(mean = mean(total_lapses), se=std.error(total_lapses))
#TOTAL LAPSES
#OVERALL
sc_lapses<- ggplot(lapses_w, aes(x = Time, y = total_lapses, fill=Time))+
  geom_flat_violin(aes(fill=Time),position = position_nudge(x = .01, y = 0), adjust = 1.5, trim = FALSE)+
  geom_point(aes(x = as.numeric(Time)-.15, y = total_lapses),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("Number of Lapses")+
  xlab("Time")+
  ggtitle("Psychomotor Vigilance")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "none")+
  scale_fill_manual(values=cbp2)
sc_lapses
bp_lapses <- ggplot(lapsest_w, aes(x=Time, y=mean, fill = Time))+
  geom_col(aes(x=Time, y=mean),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = lapsest_w, aes(x = as.numeric(Time), y = as.numeric(mean), ymin = as.numeric(mean - se), ymax = as.numeric(mean + se), width = .1),position=position_dodge(0.35))+
  ylab("Total lapses")+
  xlab("Time")+
  ggtitle("PVT performance")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(0, 5))+
  theme(legend.position = "none")+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
bp_lapses
#WT
#WT
sc_lapses_wt <- ggplot(lapses_w, aes(x = Time, y = total_lapses, fill=Weight))+
  geom_flat_violin(aes(fill=Weight),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(Time)-.15, y = total_lapses, colour=Weight),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("Lapses")+
  xlab("Time")+
  ggtitle("PVT performance")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "right")+
  scale_fill_manual(values=cbp2)+
  scale_color_manual(values=cbp2)
sc_lapses_wt
bp_pvt_wt <- ggplot(lapses_wt, aes(x=Time, y=mean, fill = Weight))+
  geom_col(aes(x=Time, y=mean),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = lapses_wt, aes(x = as.numeric(Time), y = as.numeric(mean), ymin = as.numeric(mean - se), ymax = as.numeric(mean + se), width = .1),position=position_dodge(0.35))+
  ylab("Lapses")+
  xlab("Time")+
  ggtitle("PVT performance")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(0, 7.5))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
bp_pvt_wt
#SX
sc_lapses_wt <- ggplot(lapses_w, aes(x = Time, y = total_lapses, fill=Sex))+
  geom_flat_violin(aes(fill=Sex),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(Time)-.15, y = total_lapses, colour=Sex),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("Lapses")+
  xlab("Time")+
  ggtitle("PVT performance")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "right")+
  scale_fill_manual(values=cbp2)+
  scale_color_manual(values=cbp2)
sc_lapses_wt
bp_pvt_sx <- ggplot(lapses_sx, aes(x=Time, y=mean, fill = Sex))+
  geom_col(aes(x=Time, y=mean),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = lapses_sx, aes(x = as.numeric(Time), y = as.numeric(mean), ymin = as.numeric(mean - se), ymax = as.numeric(mean + se), width = .1),position=position_dodge(0.35))+
  ylab("Lapses")+
  xlab("Time")+
  ggtitle("PVT performance")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(0, 7.5))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
bp_pvt_sx
