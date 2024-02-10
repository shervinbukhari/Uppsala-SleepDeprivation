
library(tidyverse)
library(ggpubr)
library(rstatix)
library(lme4) # for multilevel models
library(tidyverse) # for data manipulation and plots
library(haven) #for reading sav data
library(sjstats) #for calculating intra-class correlation (ICC)
library(effects) #for plotting parameter effects
library(jtools) #for transformaing model summaries
library(ROCR) #for calculating area under the curve (AUC) statistics
library(cowplot)
library(readr)
library(plotrix)
library(GLMMadaptive)
library(ordinal)
library(writexl)
library(readxl)
library(emmeans)
library(lmerTest)
library(MuMIn)
library(effects)
library(lattice)
library(sjPlot)
library(glmmTMB)


cbp2 <- c("#CC79A7", "#56B4E9","#0072B2" , 
          "#E6AB02","#F0E442" , "#D55E00","#009E73" ,"#000000")
KSS <- read_excel("GitStuff/mswake/Main-results/kss_score.xlsx")
KSS$Sex=factor(KSS$Sex)
KSS$Weight=factor(KSS$Weight)
KSS$Time=factor(KSS$Time)
## LMM
ksslm1 <- lmer(Sleepiness ~ Time*Sex*Weight + (1|inSub_EEG), data=KSS, REML=FALSE)
ksslm2 <- lmer(Sleepiness ~ Time*Sex + Time*Weight + Sex*Weight + (1|inSub_EEG), data=KSS,REML=FALSE)
ksslm3 <- lmer(Sleepiness ~ Time*Sex + Time*Weight + (1|inSub_EEG), data=KSS,REML=FALSE)
ksslm4 <- lmer(Sleepiness ~ Time*Sex + (1|inSub_EEG), data=KSS, REML=FALSE)
ksslm5 <- lmer(Sleepiness ~ Time*Weight + (1|inSub_EEG), data=KSS, REML=FALSE)
#Compare models
kss_anova<-anova(ksslm1,ksslm2,ksslm3,ksslm4,ksslm5)

kss_glm<-glmer(Sleepiness ~ Time*Sex + (1|inSub_EEG), data=KSS,family=Gamma(link="identity"),)
#
ksslm3 <- lmer(Sleepiness ~ Time*Sex + Time*Weight + (1|inSub_EEG), data=KSS,REML=TRUE)
effectsize::eta_squared(ksslm3, partial = TRUE) ### partial eta sq
plot(fitted(ksslm3),residuals(ksslm3))
qqnorm(resid(ksslm3))  ##QQ plot showing distribution of residuals 
write_xlsx(anova(ksslm3),"GitStuff/mswake/SpreadsheetsnJASP/kss_anovatable.xlsx")
ksslm_sum<-summary(ksslm3)
write_xlsx(ksslm_sum,"GitStuff/mswake/SpreadsheetsnJASP/ksslm_sum.xlsx")
##Check for linearity
linearity<-plot(resid(ksslm3),#extract the residuals
                KSS$Sleepiness) #specify original y variable

#Check for normality
qqmath(ksslm3)

#Try with model_plot (argument for type can be varied)
plot_model(ksslm3, type='diag') # you can ajust type (see package info: ?plot_model)

mdl3 <- lmer(Sleepiness ~ Time*Sex + Time*Weight + (1|inSub_EEG), data=KSS,REML=TRUE)

#Plotting
KSS_time <- KSS %>% group_by(Time) %>% summarise(mean_kss=mean(Sleepiness),se_kss=std.error(Sleepiness))
KSS_time$Time=factor(KSS_time$Time)
# Rainclouds for repeated measures, continued
Xlab <- c("23:00","01:00","03:00","05:00","07:00")
 
KSS_plot <- ggplot(KSS, aes(x = Time, y = Sleepiness, fill = Time))+
  geom_flat_violin(aes(fill = Time),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = TRUE, colour = NA,alpha=0.6)+
  geom_point(aes(x = as.numeric(Time), y = Sleepiness, colour=Time),position = position_jitter(width = .00), size = 3.5, shape = 20)+
  geom_boxplot(aes(x = Time, y = Sleepiness, fill = Time), width = .1, outlier.shape = NA,alpha=0.4)+
 geom_line(data = KSS_time, aes(x = as.numeric(Time)+.1, y = as.numeric(mean_kss), group=1), linetype = 3)+
  geom_errorbar(data = KSS_time, aes(x = as.numeric(Time)+.1, y = as.numeric(mean_kss), ymin = as.numeric(mean_kss-se_kss), ymax = as.numeric(mean_kss+se_kss), width = .05, colour=Time), size=1 )+
  geom_point(data = KSS_time, aes(x = as.numeric(Time)+.1, y = as.numeric(mean_kss), colour=Time), shape = 15)+
  scale_fill_manual(values=cbp2)+
  scale_colour_manual(values=cbp2)+
  ggtitle("")+
  labs(x="Time",y="Sleepiness")+
  scale_x_discrete(labels= Xlab)+
  theme(legend.position = "none")+
scale_y_continuous(breaks=c(1,4.5,9))
KSS_plot
## SPLIT BY SEX
KSS_sx <- KSS %>% group_by(Time,Sex) %>% summarise(mean_kss=mean(Sleepiness),se_kss=std.error(Sleepiness))
KSSsx_plot <- ggplot(KSS, aes(x = Time, y = Sleepiness, fill = Sex))+
  geom_flat_violin(aes(fill = Sex),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = TRUE, colour = NA,alpha=0.6)+
  geom_point(aes(x = as.numeric(Time), y = Sleepiness, colour=Sex),position = position_jitterdodge(jitter.width =0,jitter.height=0.1, dodge.width=0.1), size = 3.5, shape = 20)+
  geom_boxplot(aes(x = Time, y = Sleepiness, fill = Sex), width = .1, outlier.shape = NA,alpha=0.4)+
  geom_line(data = KSS_sx, aes(x = as.numeric(Time)+.1, y = as.numeric(mean_kss), colour=Sex), linetype = 3)+
  geom_errorbar(data = KSS_sx, aes(x = as.numeric(Time)+.1, y = as.numeric(mean_kss), ymin = as.numeric(mean_kss-se_kss), ymax = as.numeric(mean_kss+se_kss), width = .05, colour=Sex), size=1 )+
  geom_point(data = KSS_sx, aes(x = as.numeric(Time)+.1, y = as.numeric(mean_kss), colour=Sex), shape = 15)+
  scale_fill_manual(values=c("#CC79A7","#009E73"))+
  scale_colour_manual(values=c("#CC79A7","#009E73"))+
  ggtitle("")+
  labs(x="Time",y="Sleepiness")+
  scale_x_discrete(labels= Xlab)+
  theme(legend.position = "right")+
  scale_y_continuous(breaks=c(1,4.5,9))
KSSsx_plot

## SPLIT BY SEX
KSS_wt <- KSS %>% group_by(Time,Weight) %>% summarise(mean_kss=mean(Sleepiness),se_kss=std.error(Sleepiness))
KSSwt_plot <- ggplot(KSS, aes(x = Time, y = Sleepiness, fill = Weight))+
  geom_flat_violin(aes(fill = Weight),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = TRUE, colour = NA,alpha=0.6)+
  geom_point(aes(x = as.numeric(Time), y = Sleepiness, colour=Weight),position = position_jitterdodge(jitter.width =0,jitter.height=0.1, dodge.width=0.1), size = 3.5, shape = 20)+
  geom_boxplot(aes(x = Time, y = Sleepiness, fill = Weight), width = .1, outlier.shape = NA,alpha=0.4)+
  geom_line(data = KSS_wt, aes(x = as.numeric(Time)+.1, y = as.numeric(mean_kss), colour=Weight), linetype = 3)+
  geom_errorbar(data = KSS_wt, aes(x = as.numeric(Time)+.1, y = as.numeric(mean_kss), ymin = as.numeric(mean_kss-se_kss), ymax = as.numeric(mean_kss+se_kss), width = .05, colour=Weight), size=1 )+
  geom_point(data = KSS_wt, aes(x = as.numeric(Time)+.1, y = as.numeric(mean_kss), colour=Weight), shape = 15)+
  scale_fill_manual(values=c("#E6AB02" ,"#0072B2"))+
  scale_colour_manual(values=c("#E6AB02" ,"#0072B2"))+
  ggtitle("")+
  labs(x="Time",y="Sleepiness")+
  scale_x_discrete(labels= Xlab)+
  theme(legend.position = "right")+
  scale_y_continuous(breaks=c(1,4.5,9))
KSSwt_plot