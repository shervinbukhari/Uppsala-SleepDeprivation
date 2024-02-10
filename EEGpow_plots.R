EEGdata <- read_excel("GitStuff/mswake/Main-results/abspow_ROIs.xlsx")
EEGdata$Time=factor(EEGdata$Time)
EEGdata$Sex=factor(EEGdata$Sex)
EEGdata$Weight=factor(EEGdata$Weight)
#Plotting
EEG_time_a <- EEGdata %>% group_by(Time) %>% summarise(mean_a=mean(alphaocc),se_a=std.error(alphaocc))
EEG_time_t <- EEGdata %>% group_by(Time) %>% summarise(mean_t=mean(thetafc),se_t=std.error(thetafc))
EEG_time_atr <- EEGdata %>% group_by(Time) %>% summarise(mean_a=mean(AT_ratio),se_a=std.error(AT_ratio))
# Rainclouds for repeated measures, continued
Xlab <- c("23:00","01:00","03:00","05:00","07:00")

EEG_aplot <- ggplot(EEGdata, aes(x = Time, y = alphaocc, fill = Time))+
  geom_flat_violin(aes(fill = Time),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = TRUE, colour = NA,alpha=0.6)+
  geom_point(aes(x = as.numeric(Time), y = alphaocc, colour=Time),position = position_jitter(width = .00), size = 3.5, shape = 20)+
  geom_boxplot(aes(x = Time, y = alphaocc, fill = Time), width = .1, outlier.shape = NA,alpha=0.4)+
  geom_line(data = EEG_time_a, aes(x = as.numeric(Time)+.1, y = as.numeric(mean_a), group=1), linetype = 3)+
  geom_errorbar(data = EEG_time_a, aes(x = as.numeric(Time)+.1, y = as.numeric(mean_a), ymin = as.numeric(mean_a-se_a), ymax = as.numeric(mean_a+se_a), width = .05, colour=Time), size=1 )+
  geom_point(data = EEG_time_a, aes(x = as.numeric(Time)+.1, y = as.numeric(mean_a), colour=Time), shape = 15)+
  geom_text(data=EEG_time_a, aes(x=as.numeric(Time)+.1, y=as.numeric(mean_a),label=format(round(mean_a,2),nsmall=2)),nudge_x=0.05,nudge_y=-1, inherit.aes = F,
                                  colour = "White",
                                  size = 3.5, angle=-90, fontface="bold")+
  scale_fill_manual(values=cbp2)+
  scale_colour_manual(values=cbp2)+
  ggtitle("")+
  labs(x="Time",y="Alpha Power")+
  scale_x_discrete(labels= Xlab)+
  theme(legend.position = "none")+
  scale_y_continuous(breaks=c(0,4.5,9))
EEG_aplot

#Theta
EEG_tplot <- ggplot(EEGdata, aes(x = Time, y = thetafc, fill = Time))+
  geom_flat_violin(aes(fill = Time),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = TRUE, colour = NA,alpha=0.6)+
  geom_point(aes(x = as.numeric(Time), y = thetafc, colour=Time),position = position_jitter(width = .00), size = 3.5, shape = 20)+
  geom_boxplot(aes(x = Time, y = thetafc, fill = Time), width = .1, outlier.shape = NA,alpha=0.4)+
  geom_line(data = EEG_time_t, aes(x = as.numeric(Time)+.1, y = as.numeric(mean_t), group=1), linetype = 3)+
  geom_errorbar(data = EEG_time_t, aes(x = as.numeric(Time)+.1, y = as.numeric(mean_t), ymin = as.numeric(mean_t-se_t), ymax = as.numeric(mean_t+se_t), width = .05, colour=Time), size=1 )+
  geom_point(data = EEG_time_t, aes(x = as.numeric(Time)+.1, y = as.numeric(mean_t), colour=Time), shape = 15)+
  scale_fill_manual(values=cbp2)+
  scale_colour_manual(values=cbp2)+
  ggtitle("")+
  labs(x="Time",y="Alpha Power")+
  scale_x_discrete(labels= Xlab)+
  theme(legend.position = "none")+
  scale_y_continuous(breaks=c(0,4.5,9))
EEG_tplot

## SPLIT BY SEX
KSS_sx <- KSS %>% group_by(Time,Sex) %>% summarise(mean_kss=mean(Sleepiness),se_kss=std.error(Sleepiness))
KSSsx_plot <- ggplot(KSS, aes(x = Time, y = Sleepiness, fill = Sex))+
  geom_flat_violin(aes(fill = Sex),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = TRUE, colour = NA,alpha=0.6)+
  geom_point(aes(x = as.numeric(Time), y = Sleepiness, colour=Sex),position = position_jitterdodge(jitter.width =0,jitter.height=0.1, dodge.width=0.1), size = 3.5, shape = 20)+
  geom_boxplot(aes(x = Time, y = Sleepiness, fill = Sex), width = .1, outlier.shape = NA,alpha=0.4)+
  geom_line(data = KSS_sx, aes(x = as.numeric(Time)+.1, y = as.numeric(mean_kss), colour=Sex), linetype = 3, size=)+
  geom_errorbar(data = KSS_sx, aes(x = as.numeric(Time)+.1, y = as.numeric(mean_kss), ymin = as.numeric(mean_kss-se_kss), ymax = as.numeric(mean_kss+se_kss), width = .05, colour=Sex), size=1)+
  geom_text()
  geom_point(data = KSS_sx, aes(x = as.numeric(Time)+.1, y = as.numeric(mean_kss), colour=Sex), shape = 15)+
  scale_fill_manual(values=c("#CC79A7","#009E73"))+
  scale_colour_manual(values=c("#CC79A7","#009E73"))+
  ggtitle("")+
  labs(x="Time",y="Sleepiness")+
  scale_x_discrete(labels= Xlab)+
  theme(legend.position = "right")+
  scale_y_continuous(breaks=c(1,4.5,9))
KSSsx_plot

## SPLIT BY WT
EEGdata_wt_theta <- EEGdata %>% group_by(Time,Weight) %>% summarise(mean_t=mean(thetafc),se_t=std.error(thetafc))
EEGw_tplot <- ggplot(EEGdata, aes(x = Time, y = thetafc, fill = Weight))+
  geom_flat_violin(aes(fill = Weight),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = TRUE, colour = NA,alpha=0.6)+
  geom_point(aes(x = as.numeric(Time), y = thetafc, colour=Weight),position = position_jitterdodge(jitter.width =0,jitter.height=0.1, dodge.width=0.1), size = 3.5, shape = 20)+
  geom_boxplot(aes(x = Time, y = thetafc, fill = Weight), width = .1, outlier.shape = NA,alpha=0.4)+
  geom_line(data = EEGdata_wt_theta, aes(x = as.numeric(Time)+.1, y = as.numeric(mean_t), colour=Weight), linetype = 3)+
  geom_errorbar(data = EEGdata_wt_theta, aes(x = as.numeric(Time)+.1, y = as.numeric(mean_t), ymin = as.numeric(mean_t-se_t), ymax = as.numeric(mean_t+se_t), width = .05, colour=Weight), size=1 )+
  geom_point(data = EEGdata_wt_theta, aes(x = as.numeric(Time)+.1, y = as.numeric(mean_t), colour=Weight), shape = 15)+
  scale_fill_manual(values=c("#E6AB02" ,"#0072B2"))+
  scale_colour_manual(values=c("#E6AB02" ,"#0072B2"))+
  ggtitle("")+
  labs(x="Time",y="Theta Power")+
  scale_x_discrete(labels= Xlab)+
  theme(legend.position = "right")+
  scale_y_continuous(breaks=c(0,4.5,9))
EEGw_tplot