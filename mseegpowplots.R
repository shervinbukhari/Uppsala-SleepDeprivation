library(ggplot2)
library(dplyr)
library(readr)
library(readxl)
library(plotrix)
cbp2 <- c("#000000", "#E6AB02", "#56B4E9", "#009E73",
          "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
abxpow<-read_excel("GitStuff/mswake/SpreadsheetsnJASP/absolute_xpsd.xlsx")
abspow<-read_excel("GitStuff/mswake/SpreadsheetsnJASP/absolute_psd.xlsx")
abspow$Time=factor(abspow$Time)
abspow$Sex=factor(abspow$Sex)
abspow_atime%>% group_by(Time) %>% summarise(mean = mean(Alpha), se = std.error(Alpha))
abspow_time<- abspow %>% group_by(Time) %>% summarise(mean_a = mean(Alpha), mean_b=mean(Beta),mean_d=mean(Delta), mean_t=mean(Theta),mean_Tar = mean(Tar), mean_Tbr=mean(Tbr), se_a = std.error(Alpha), se_b = std.error(Beta), se_d = std.error(Delta), se_t = std.error(Theta),se_ta=std.error(Tar),se_tb=std.error(Tbr))

Xaxis <- c("23:00","01:00","03:00","05:00","07:00")
abschpow<-read_excel("GitStuff/mswake/SpreadsheetsnJASP/abschangepow.xlsx")
relpow<-read_excel("GitStuff/mswake/SpreadsheetsnJASP/relpowr.xlsx")

#OVERALL ABS
#alpha
abs_sc_alph <- ggplot(abspow, aes(x = Time, y = Alpha, fill=Time))+
  geom_flat_violin(aes(fill=Time),position = position_nudge(x = .01, y = 0), adjust = 1.5, trim = FALSE)+
  geom_point(aes(x = as.numeric(Time)-.15, y = Alpha),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("Abs. power")+
  xlab("Time")+
  ggtitle("Alpha (8-12 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "none")+
  scale_fill_manual(values=cbp2)
abs_sc_alph
abs_bp_alph <- ggplot(abspow_time, aes(x=Time, y=mean_a, fill = Time))+
  geom_col(aes(x=Time, y=mean_a),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abspow_time, aes(x = as.numeric(Time), y = as.numeric(mean_a), ymin = as.numeric(mean_a - se_a), ymax = as.numeric(mean_a + se_a), width = .1),position=position_dodge(0.35))+
  ylab("Abs. pow")+
  xlab("Time")+
  ggtitle("Alpha (8-12 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(1.5, 3))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "none")+
  scale_fill_manual(values=cbp2)
abs_bp_alph

# beta
abs_sc_b <- ggplot(abspow, aes(x = Time, y = Beta, fill=Time))+
  geom_flat_violin(aes(fill=Time),position = position_nudge(x = .01, y = 0), adjust = 1.5, trim = FALSE)+
  geom_point(aes(x = as.numeric(Time)-.15, y = Beta),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("Abs. power")+
  xlab("Time")+
  ggtitle("Beta (12-30 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "none")+
  scale_fill_manual(values=cbp2)
abs_sc_b
abs_bp_beta <- ggplot(abspow_time, aes(x=Time, y=mean_b, fill = Time))+
  geom_col(aes(x=Time, y=mean_b),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abspow_time, aes(x = as.numeric(Time), y = as.numeric(mean_b), ymin = as.numeric(mean_b - se_b), ymax = as.numeric(mean_b + se_b), width = .1),position=position_dodge(0.35))+
  ylab("Abs. pow")+
  xlab("Time")+
  ggtitle("Beta (12-30 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(0, 0.2))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "none")+
  scale_fill_manual(values=cbp2)
abs_bp_beta

#delta
abs_sc_d <- ggplot(abspow, aes(x = Time, y = Delta, fill=Time))+
  geom_flat_violin(aes(fill=Time),position = position_nudge(x = .01, y = 0), adjust = 1.5, trim = FALSE)+
  geom_point(aes(x = as.numeric(Time)-.15, y = Delta),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("Abs. power")+
  xlab("Time")+
  ggtitle("Delta (0.5-4 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "none")+
  scale_fill_manual(values=cbp2)
abs_sc_d
abs_bp_d <- ggplot(abspow_time, aes(x=Time, y=mean_d, fill = Time))+
  geom_col(aes(x=Time, y=mean_d),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abspow_time, aes(x = as.numeric(Time), y = as.numeric(mean_d), ymin = as.numeric(mean_d - se_d), ymax = as.numeric(mean_d + se_d), width = .1),position=position_dodge(0.35))+
  ylab("Abs. pow")+
  xlab("Time")+
  ggtitle("Delta (0.5-4 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(0.5, 2.5))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "none")+
  scale_fill_manual(values=cbp2)
abs_bp_d

#theta
abs_sc_t <- ggplot(abspow, aes(x = Time, y = Theta, fill=Time))+
  geom_flat_violin(aes(fill=Time),position = position_nudge(x = .01, y = 0), adjust = 1.5, trim = FALSE)+
  geom_point(aes(x = as.numeric(Time)-.15, y = Theta),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("Abs. power")+
  xlab("Time")+
  ggtitle("Theta (4-8 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "none")+
  scale_fill_manual(values=cbp2)
abs_sc_t
abs_bp_t <- ggplot(abspow_time, aes(x=Time, y=mean_t, fill = Time))+
  geom_col(aes(x=Time, y=mean_t),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abspow_time, aes(x = as.numeric(Time), y = as.numeric(mean_t), ymin = as.numeric(mean_t - se_t), ymax = as.numeric(mean_t + se_t), width = .1),position=position_dodge(0.35))+
  ylab("Abs. pow")+
  xlab("Time")+
  ggtitle("Theta (4-8 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(0.75, 1.5))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "none")+
  scale_fill_manual(values=cbp2)
abs_bp_t

#THETA/ALPHA
abs_sc_tar <- ggplot(abspow, aes(x = Time, y = Tar, fill=Time))+
  geom_flat_violin(aes(fill=Time),position = position_nudge(x = .01, y = 0), adjust = 1.5, trim = FALSE)+
  geom_point(aes(x = as.numeric(Time)-.15, y = Tar),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("Rel. power")+
  xlab("Time")+
  ggtitle("Theta/Alpha Ratio")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "none")+
  scale_fill_manual(values=cbp2)
abs_sc_tar
abs_bp_tar <- ggplot(abspow_time, aes(x=Time, y=mean_t, fill = Time))+
  geom_col(aes(x=Time, y=mean_Tar),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abspow_time, aes(x = as.numeric(Time), y = as.numeric(mean_Tar), ymin = as.numeric(mean_Tar - se_ta), ymax = as.numeric(mean_Tar + se_ta), width = .1),position=position_dodge(0.35))+
  ylab("Rel. pow")+
  xlab("Time")+
  ggtitle("Theta/Alpha Ratio")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(0, 0.3))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "none")+
  scale_fill_manual(values=cbp2)
abs_bp_tar
#THETA/BETA
abs_sc_tbr <- ggplot(abspow, aes(x = Time, y = Tbr, fill=Time))+
  geom_flat_violin(aes(fill=Time),position = position_nudge(x = .01, y = 0), adjust = 1.5, trim = FALSE)+
  geom_point(aes(x = as.numeric(Time)-.15, y = Tbr),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("Rel. power")+
  xlab("Time")+
  ggtitle("Theta/Beta Ratio")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "none")+
  scale_fill_manual(values=cbp2)
abs_sc_tbr
abs_bp_tbr <- ggplot(abspow_time, aes(x=Time, y=mean_Tbr, fill = Time))+
  geom_col(aes(x=Time, y=mean_Tbr),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abspow_time, aes(x = as.numeric(Time), y = as.numeric(mean_Tbr), ymin = as.numeric(mean_Tbr - se_tb), ymax = as.numeric(mean_Tbr + se_tb), width = .1),position=position_dodge(0.35))+
  ylab("Rel. pow")+
  xlab("Time")+
  ggtitle("Theta/Beta Ratio")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(5, 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "none")+
  scale_fill_manual(values=cbp2)
abs_bp_tbr

##BY WT
abspow_wt<- abspow %>% group_by(Time, Weight) %>% summarise(mean_a = mean(Alpha), mean_b=mean(Beta),mean_t=mean(Delta), mean_d=mean(Theta),mean_Tar = mean(Tar), mean_Tbr=mean(Tbr), se_a = std.error(Alpha), se_b = std.error(Beta), se_d = std.error(Delta), se_t = std.error(Theta),se_ta=std.error(Tar),se_tb=std.error(Tbr))
View(abspow_wt)
#alpha
abs_sc_alph <- ggplot(abspow, aes(x = Time, y = Alpha, fill=Weight))+
  geom_flat_violin(aes(fill=Weight),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(Time)-.15, y = Alpha, colour=Weight),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("Abs. power")+
  xlab("Time")+
  ggtitle("Alpha (8-12 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "right")+
  scale_fill_manual(values=cbp2)+
  scale_color_manual(values=cbp2)
abs_sc_alph
abs_bp_alph <- ggplot(abspow_wt, aes(x=Time, y=mean_a, fill = Weight))+
  geom_col(aes(x=Time, y=mean_a),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abspow_wt, aes(x = as.numeric(Time), y = as.numeric(mean_a), ymin = as.numeric(mean_a - se_a), ymax = as.numeric(mean_a + se_a), width = .1),position=position_dodge(0.35))+
  ylab("Abs. pow")+
  xlab("Time")+
  ggtitle("Alpha (8-12 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(0, 3.5))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
abs_bp_alph

# beta
abs_sc_beta <- ggplot(abspow, aes(x = Time, y = Beta, fill=Weight))+
  geom_flat_violin(aes(fill=Weight),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(Time)-.15, y = Beta, colour=Weight),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("Abs. power")+
  xlab("Time")+
  ggtitle("Beta (12-30 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "right")+
  scale_fill_manual(values=cbp2)+
  scale_color_manual(values=cbp2)
abs_sc_beta
abs_bp_beta <- ggplot(abspow_wt, aes(x=Time, y=mean_b, fill = Weight))+
  geom_col(aes(x=Time, y=mean_b),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abspow_wt, aes(x = as.numeric(Time), y = as.numeric(mean_b), ymin = as.numeric(mean_b - se_b), ymax = as.numeric(mean_b + se_b), width = .1),position=position_dodge(0.35))+
  ylab("Abs. pow")+
  xlab("Time")+
  ggtitle("Beta (12-30 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(0, 0.3))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
abs_bp_beta

#delta
abs_sc_Delta <- ggplot(abspow, aes(x = Time, y = Delta, fill=Weight))+
  geom_flat_violin(aes(fill=Weight),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(Time)-.15, y = Delta, colour=Weight),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("Abs. power")+
  xlab("Time")+
  ggtitle("Delta (0.5-4 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "right")+
  scale_fill_manual(values=cbp2)+
  scale_color_manual(values=cbp2)
abs_sc_Delta
abs_bp_Delta <- ggplot(abspow_wt, aes(x=Time, y=mean_d, fill = Weight))+
  geom_col(aes(x=Time, y=mean_d),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abspow_wt, aes(x = as.numeric(Time), y = as.numeric(mean_d), ymin = as.numeric(mean_d - se_d), ymax = as.numeric(mean_d + se_d), width = .1),position=position_dodge(0.35))+
  ylab("Abs. pow")+
  xlab("Time")+
  ggtitle("Delta (12-30 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(0.5, 1.5))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
abs_bp_Delta

#theta
abs_sc_Theta <- ggplot(abspow, aes(x = Time, y = Theta, fill=Weight))+
  geom_flat_violin(aes(fill=Weight),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(Time)-.15, y = Theta, colour=Weight),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("Abs. power")+
  xlab("Time")+
  ggtitle("Theta (4-8 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "right")+
  scale_fill_manual(values=cbp2)+
  scale_color_manual(values=cbp2)
abs_sc_Theta
abs_bp_Theta <- ggplot(abspow_wt, aes(x=Time, y=mean_d, fill = Weight))+
  geom_col(aes(x=Time, y=mean_t),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abspow_wt, aes(x = as.numeric(Time), y = as.numeric(mean_t), ymin = as.numeric(mean_t - se_t), ymax = as.numeric(mean_t + se_t), width = .1),position=position_dodge(0.35))+
  ylab("Abs. pow")+
  xlab("Time")+
  ggtitle("Theta (4-8 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(1, 2.5))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
abs_bp_Theta

#THETA/ALPHA
abs_sc_Tar <- ggplot(abspow, aes(x = Time, y = Tar, fill=Weight))+
  geom_flat_violin(aes(fill=Weight),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(Time)-.15, y = Tar, colour=Weight),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("Abs. power")+
  xlab("Time")+
  ggtitle("Theta Alpha Ratio")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "right")+
  scale_fill_manual(values=cbp2)+
  scale_color_manual(values=cbp2)
abs_sc_Tar
abs_bp_Tar <- ggplot(abspow_wt, aes(x=Time, y=mean_Tar, fill = Weight))+
  geom_col(aes(x=Time, y=mean_Tar),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abspow_wt, aes(x = as.numeric(Time), y = as.numeric(mean_Tar), ymin = as.numeric(mean_Tar - se_ta), ymax = as.numeric(mean_Tar + se_ta), width = .1),position=position_dodge(0.35))+
  ylab("Abs. pow")+
  xlab("Time")+
  ggtitle("Theta-Alpha Ratio")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(0, 0.5))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
abs_bp_Tar
#THETA/BETA
abs_sc_Tbr <- ggplot(abspow, aes(x = Time, y = Tbr, fill=Weight))+
  geom_flat_violin(aes(fill=Weight),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(Time)-.15, y = Tbr, colour=Weight),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("Abs. power")+
  xlab("Time")+
  ggtitle("Theta Beta Ratio")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "right")+
  scale_fill_manual(values=cbp2)+
  scale_color_manual(values=cbp2)
abs_sc_Tbr
abs_bp_Tbr <- ggplot(abspow_wt, aes(x=Time, y=mean_Tbr, fill = Weight))+
  geom_col(aes(x=Time, y=mean_Tbr),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abspow_wt, aes(x = as.numeric(Time), y = as.numeric(mean_Tbr), ymin = as.numeric(mean_Tbr - se_tb), ymax = as.numeric(mean_Tbr + se_tb), width = .1),position=position_dodge(0.35))+
  ylab("Abs. pow")+
  xlab("Time")+
  ggtitle("Theta-Beta Ratio")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(0, 11))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
abs_bp_Tbr

## BY SEX
abspow_sx<- abspow %>% group_by(Time, Sex) %>% summarise(mean_a = mean(Alpha), mean_b=mean(Beta),mean_t=mean(Delta), mean_d=mean(Theta),mean_Tar = mean(Tar), mean_Tbr=mean(Tbr), se_a = std.error(Alpha), se_b = std.error(Beta), se_d = std.error(Delta), se_t = std.error(Theta),se_ta=std.error(Tar),se_tb=std.error(Tbr))
View(abspow_sx)
#alpha
abs_sc_alph <- ggplot(abspow, aes(x = Time, y = Alpha, fill=Sex))+
  geom_flat_violin(aes(fill=Sex),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(Time)-.15, y = Alpha, colour=Sex),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("Abs. power")+
  xlab("Time")+
  ggtitle("Alpha (8-12 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "right")+
  scale_fill_manual(values=cbp2)+
  scale_color_manual(values=cbp2)
abs_sc_alph
abs_bp_alph <- ggplot(abspow_sx, aes(x=Time, y=mean_a, fill = Sex))+
  geom_col(aes(x=Time, y=mean_a),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abspow_sx, aes(x = as.numeric(Time), y = as.numeric(mean_a), ymin = as.numeric(mean_a - se_a), ymax = as.numeric(mean_a + se_a), width = .1),position=position_dodge(0.35))+
  ylab("Abs. pow")+
  xlab("Time")+
  ggtitle("Alpha (8-12 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(1, 3.5))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
abs_bp_alph

# beta
abs_sc_beta <- ggplot(abspow, aes(x = Time, y = Beta, fill=Sex))+
  geom_flat_violin(aes(fill=Sex),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(Time)-.15, y = Beta, colour=Sex),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("Abs. power")+
  xlab("Time")+
  ggtitle("Beta (12-30 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "right")+
  scale_fill_manual(values=cbp2)+
  scale_color_manual(values=cbp2)
abs_sc_beta
abs_bp_beta <- ggplot(abspow_sx, aes(x=Time, y=mean_b, fill = Sex))+
  geom_col(aes(x=Time, y=mean_b),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abspow_sx, aes(x = as.numeric(Time), y = as.numeric(mean_b), ymin = as.numeric(mean_b - se_b), ymax = as.numeric(mean_b + se_b), width = .1),position=position_dodge(0.35))+
  ylab("Abs. pow")+
  xlab("Time")+
  ggtitle("Beta (12-30 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(0, 0.3))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
abs_bp_beta

#delta
abs_sc_Delta <- ggplot(abspow, aes(x = Time, y = Delta, fill=Sex))+
  geom_flat_violin(aes(fill=Sex),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(Time)-.15, y = Delta, colour=Sex),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("Abs. power")+
  xlab("Time")+
  ggtitle("Delta (0.5-4 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "right")+
  scale_fill_manual(values=cbp2)+
  scale_color_manual(values=cbp2)
abs_sc_Delta
abs_bp_Delta <- ggplot(abspow_sx, aes(x=Time, y=mean_d, fill = Sex))+
  geom_col(aes(x=Time, y=mean_d),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abspow_sx, aes(x = as.numeric(Time), y = as.numeric(mean_d), ymin = as.numeric(mean_d - se_d), ymax = as.numeric(mean_d + se_d), width = .1),position=position_dodge(0.35))+
  ylab("Abs. pow")+
  xlab("Time")+
  ggtitle("Delta (12-30 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(0.5, 1.5))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
abs_bp_Delta

#theta
abs_sc_Theta <- ggplot(abspow, aes(x = Time, y = Theta, fill=Sex))+
  geom_flat_violin(aes(fill=Sex),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(Time)-.15, y = Theta, colour=Sex),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("Abs. power")+
  xlab("Time")+
  ggtitle("Theta (4-8 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "right")+
  scale_fill_manual(values=cbp2)+
  scale_color_manual(values=cbp2)
abs_sc_Theta
abs_bp_Theta <- ggplot(abspow_sx, aes(x=Time, y=mean_d, fill = Sex))+
  geom_col(aes(x=Time, y=mean_t),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abspow_sx, aes(x = as.numeric(Time), y = as.numeric(mean_t), ymin = as.numeric(mean_t - se_t), ymax = as.numeric(mean_t + se_t), width = .1),position=position_dodge(0.35))+
  ylab("Abs. pow")+
  xlab("Time")+
  ggtitle("Theta (4-8 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(1, 2.5))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
abs_bp_Theta

#THETA/ALPHA
abs_sc_Tar <- ggplot(abspow, aes(x = Time, y = Tar, fill=Sex))+
  geom_flat_violin(aes(fill=Sex),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(Time)-.15, y = Tar, colour=Sex),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("Abs. power")+
  xlab("Time")+
  ggtitle("Theta Alpha Ratio")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "right")+
  scale_fill_manual(values=cbp2)+
  scale_color_manual(values=cbp2)
abs_sc_Tar
abs_bp_Tar <- ggplot(abspow_sx, aes(x=Time, y=mean_Tar, fill = Sex))+
  geom_col(aes(x=Time, y=mean_Tar),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abspow_sx, aes(x = as.numeric(Time), y = as.numeric(mean_Tar), ymin = as.numeric(mean_Tar - se_ta), ymax = as.numeric(mean_Tar + se_ta), width = .1),position=position_dodge(0.35))+
  ylab("Abs. pow")+
  xlab("Time")+
  ggtitle("Theta-Alpha Ratio")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(0, 0.5))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
abs_bp_Tar
#THETA/BETA
abs_sc_Tbr <- ggplot(abspow, aes(x = Time, y = Tbr, fill=Sex))+
  geom_flat_violin(aes(fill=Sex),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(Time)-.15, y = Tbr, colour=Sex),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("Abs. power")+
  xlab("Time")+
  ggtitle("Theta Beta Ratio")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "right")+
  scale_fill_manual(values=cbp2)+
  scale_color_manual(values=cbp2)
abs_sc_Tbr
abs_bp_Tbr <- ggplot(abspow_sx, aes(x=Time, y=mean_Tbr, fill = Sex))+
  geom_col(aes(x=Time, y=mean_Tbr),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abspow_sx, aes(x = as.numeric(Time), y = as.numeric(mean_Tbr), ymin = as.numeric(mean_Tbr - se_tb), ymax = as.numeric(mean_Tbr + se_tb), width = .1),position=position_dodge(0.35))+
  ylab("Abs. pow")+
  xlab("Time")+
  ggtitle("Theta-Beta Ratio")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(0, 11))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
abs_bp_Tbr


######################################################## NORMALIZED TO AVERAGE #######################################################
## Split by Sex
abxpow$Time=factor(abxpow$Time)
abxpow$Sex=factor(abxpow$Sex)
abxpow_sx<- abxpow %>% group_by(Time, Sex) %>% summarise(mean_na = mean(norm_alpha), mean_nb=mean(norm_beta),mean_nd=mean(norm_delta), mean_nt=mean(norm_theta), se_na = std.error(norm_alpha), se_nb = std.error(norm_beta), se_nd = std.error(norm_delta), se_nt = std.error(norm_theta))
abxpow_wt<- abxpow %>% group_by(Time, Weight) %>% summarise(mean_na = mean(norm_alpha), mean_nb=mean(norm_beta),mean_nd=mean(norm_delta), mean_nt=mean(norm_theta), se_na = std.error(norm_alpha), se_nb = std.error(norm_beta), se_nd = std.error(norm_delta), se_nt = std.error(norm_theta))
#alpha
abx_sc_alph <- ggplot(abxpow, aes(x = Time, y = norm_alpha, fill=Sex))+
  geom_flat_violin(aes(fill=Sex),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(Time)-.15, y = norm_alpha, colour=Sex),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("norm. power")+
  xlab("Time")+
  ggtitle("Alpha (8-12 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "right")+
  scale_fill_manual(values=cbp2)+
  scale_color_manual(values=cbp2)
abx_sc_alph
abx_bp_alph <- ggplot(abxpow_sx, aes(x=Time, y=mean_na, fill = Sex))+
  geom_col(aes(x=Time, y=mean_na),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abxpow_sx, aes(x = as.numeric(Time), y = as.numeric(mean_na), ymin = as.numeric(mean_na - se_na), ymax = as.numeric(mean_na + se_na), width = .1),position=position_dodge(0.35))+
  ylab("norm. power")+
  xlab("Time")+
  ggtitle("Alpha (8-12 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(-0.75, 0.5))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
abx_bp_alph

# beta
abx_sc_beta <- ggplot(abxpow, aes(x = Time, y = norm_beta, fill=Sex))+
  geom_flat_violin(aes(fill=Sex),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(Time)-.15, y = norm_beta, colour=Sex),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("norm. power")+
  xlab("Time")+
  ggtitle("Beta (12-30 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "right")+
  scale_fill_manual(values=cbp2)+
  scale_color_manual(values=cbp2)
abx_sc_beta
abx_bp_beta <- ggplot(abxpow_sx, aes(x=Time, y=mean_nb, fill = Sex))+
  geom_col(aes(x=Time, y=mean_nb),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abxpow_sx, aes(x = as.numeric(Time), y = as.numeric(mean_nb), ymin = as.numeric(mean_nb - se_nb), ymax = as.numeric(mean_nb + se_nb), width = .1),position=position_dodge(0.35))+
  ylab("normalized power")+
  xlab("Time")+
  ggtitle("Beta (12-30 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(-0.1, 0.1))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
abx_bp_beta

#delta
abx_sc_Delta <- ggplot(abxpow, aes(x = Time, y = norm_delta, fill=Sex))+
  geom_flat_violin(aes(fill=Sex),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(Time)-.15, y = norm_delta, colour=Sex),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("norm. power")+
  xlab("Time")+
  ggtitle("Delta (0.5-4 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "right")+
  scale_fill_manual(values=cbp2)+
  scale_color_manual(values=cbp2)
abx_sc_Delta
abx_bp_Delta <- ggplot(abxpow_sx, aes(x=Time, y=mean_nd, fill = Sex))+
  geom_col(aes(x=Time, y=mean_nd),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abxpow_sx, aes(x = as.numeric(Time), y = as.numeric(mean_nd), ymin = as.numeric(mean_nd - se_nd), ymax = as.numeric(mean_nd + se_nd), width = .1),position=position_dodge(0.35))+
  ylab("norm. pow")+
  xlab("Time")+
  ggtitle("Delta (12-30 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(-0.5, 0.5))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
abx_bp_Delta

#theta
abx_sc_Theta <- ggplot(abxpow, aes(x = Time, y = norm_theta, fill=Sex))+
  geom_flat_violin(aes(fill=Sex),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(Time)-.15, y = norm_theta, colour=Sex),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("normalized power")+
  xlab("Time")+
  ggtitle("Theta (4-8 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "right")+
  scale_fill_manual(values=cbp2)+
  scale_color_manual(values=cbp2)
abx_sc_Theta
abx_bp_Theta <- ggplot(abxpow_sx, aes(x=Time, y=mean_nt, fill = Sex))+
  geom_col(aes(x=Time, y=mean_nt),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abxpow_sx, aes(x = as.numeric(Time), y = as.numeric(mean_nt), ymin = as.numeric(mean_nt - se_nt), ymax = as.numeric(mean_nt + se_nt), width = .1),position=position_dodge(0.35))+
  ylab("normalized power")+
  xlab("Time")+
  ggtitle("Theta (4-8 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(-0.5, 0.5))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
abx_bp_Theta


#Split by WT
#alpha
abx_sc_alph <- ggplot(abxpow, aes(x = Time, y = norm_alpha, fill=Weight))+
  geom_flat_violin(aes(fill=Weight),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(Time)-.15, y = norm_alpha, colour=Weight),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("norm. power")+
  xlab("Time")+
  ggtitle("Alpha (8-12 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "right")+
  scale_fill_manual(values=cbp2)+
  scale_color_manual(values=cbp2)
abx_sc_alph
abx_bp_alph <- ggplot(abxpow_wt, aes(x=Time, y=mean_na, fill = Weight))+
  geom_col(aes(x=Time, y=mean_na),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abxpow_wt, aes(x = as.numeric(Time), y = as.numeric(mean_na), ymin = as.numeric(mean_na - se_na), ymax = as.numeric(mean_na + se_na), width = .1),position=position_dodge(0.35))+
  ylab("norm. power")+
  xlab("Time")+
  ggtitle("Alpha (8-12 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(-0.75, 0.5))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
abx_bp_alph

# beta
abx_sc_beta <- ggplot(abxpow, aes(x = Time, y = norm_beta, fill=Weight))+
  geom_flat_violin(aes(fill=Weight),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(Time)-.15, y = norm_beta, colour=Weight),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("norm. power")+
  xlab("Time")+
  ggtitle("Beta (12-30 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "right")+
  scale_fill_manual(values=cbp2)+
  scale_color_manual(values=cbp2)
abx_sc_beta
abx_bp_beta <- ggplot(abxpow_wt, aes(x=Time, y=mean_nb, fill = Weight))+
  geom_col(aes(x=Time, y=mean_nb),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abxpow_wt, aes(x = as.numeric(Time), y = as.numeric(mean_nb), ymin = as.numeric(mean_nb - se_nb), ymax = as.numeric(mean_nb + se_nb), width = .1),position=position_dodge(0.35))+
  ylab("normalized power")+
  xlab("Time")+
  ggtitle("Beta (12-30 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(-0.1, 0.1))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
abx_bp_beta

#delta
abx_sc_Delta <- ggplot(abxpow, aes(x = Time, y = norm_delta, fill=Weight))+
  geom_flat_violin(aes(fill=Weight),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(Time)-.15, y = norm_delta, colour=Weight),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("norm. power")+
  xlab("Time")+
  ggtitle("Delta (0.5-4 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "right")+
  scale_fill_manual(values=cbp2)+
  scale_color_manual(values=cbp2)
abx_sc_Delta
abx_bp_Delta <- ggplot(abxpow_wt, aes(x=Time, y=mean_nd, fill = Weight))+
  geom_col(aes(x=Time, y=mean_nd),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abxpow_wt, aes(x = as.numeric(Time), y = as.numeric(mean_nd), ymin = as.numeric(mean_nd - se_nd), ymax = as.numeric(mean_nd + se_nd), width = .1),position=position_dodge(0.35))+
  ylab("norm. pow")+
  xlab("Time")+
  ggtitle("Delta (12-30 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(-0.5, 0.5))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
abx_bp_Delta

#theta
abx_sc_Theta <- ggplot(abxpow, aes(x = Time, y = norm_theta, fill=Weight))+
  geom_flat_violin(aes(fill=Weight),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(Time)-.15, y = norm_theta, colour=Weight),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("normalized power")+
  xlab("Time")+
  ggtitle("Theta (4-8 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "right")+
  scale_fill_manual(values=cbp2)+
  scale_color_manual(values=cbp2)
abx_sc_Theta
abx_bp_Theta <- ggplot(abxpow_wt, aes(x=Time, y=mean_nt, fill = Weight))+
  geom_col(aes(x=Time, y=mean_nt),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abxpow_wt, aes(x = as.numeric(Time), y = as.numeric(mean_nt), ymin = as.numeric(mean_nt - se_nt), ymax = as.numeric(mean_nt + se_nt), width = .1),position=position_dodge(0.35))+
  ylab("normalized power")+
  xlab("Time")+
  ggtitle("Theta (4-8 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(-0.5, 0.5))+
  scale_x_discrete(labels=Xaxis)+
  scale_fill_manual(values=cbp2)
abx_bp_Theta

## OVERALL
abxpow_time<- abxpow %>% group_by(Time) %>% summarise(mean_na = mean(norm_alpha), mean_nb=mean(norm_beta),mean_nd=mean(norm_delta), mean_nt=mean(norm_theta), se_na = std.error(norm_alpha), se_nb = std.error(norm_beta), se_nd = std.error(norm_delta), se_nt = std.error(norm_theta))

#norm_alpha
abs_sc_alph <- ggplot(abxpow, aes(x = Time, y = norm_alpha, fill=Time))+
  geom_flat_violin(aes(fill=Time),position = position_nudge(x = .01, y = 0), adjust = 1.5, trim = FALSE)+
  geom_line(aes(group=participant_ID), colour="grey", alpha=.25, position = position_jitter(width = .05))+
  geom_point(aes(x = as.numeric(Time)-.15, y = norm_alpha),position = position_jitter(width = .05), size = 1, shape = 16)+
  ylab("Norm. power")+
  xlab("Time")+
  ggtitle("Alpha (8-12 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "none")+
  scale_fill_manual(values=cbp2)
abs_sc_alph
abs_bp_alph <- ggplot(abxpow_time, aes(x=Time, y=mean_na, fill = Time))+
  geom_col(aes(x=Time, y=mean_na),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abxpow_time, aes(x = as.numeric(Time), y = as.numeric(mean_na), ymin = as.numeric(mean_na - se_na), ymax = as.numeric(mean_na + se_na), width = .1),position=position_dodge(0.35))+
  ylab("Norm. power")+
  xlab("Time")+
  ggtitle("Alpha (8-12 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(-0.5, 0.5))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "none")+
  scale_fill_manual(values=cbp2)
abs_bp_alph

# norm_beta
abs_sc_b <- ggplot(abxpow, aes(x = Time, y = norm_beta, fill=Time))+
  geom_flat_violin(aes(fill=Time),position = position_nudge(x = .01, y = 0), adjust = 1.5, trim = FALSE)+
  geom_point(aes(x = as.numeric(Time)-.15, y = norm_beta),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("Norm. power")+
  xlab("Time")+
  ggtitle("Beta (12-30 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "none")+
  scale_fill_manual(values=cbp2)
abs_sc_b
abs_bp_beta <- ggplot(abxpow_time, aes(x=Time, y=mean_nb, fill = Time))+
  geom_col(aes(x=Time, y=mean_nb),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abxpow_time, aes(x = as.numeric(Time), y = as.numeric(mean_nb), ymin = as.numeric(mean_nb - se_nb), ymax = as.numeric(mean_nb + se_nb), width = .1),position=position_dodge(0.35))+
  ylab("Norm. pow")+
  xlab("Time")+
  ggtitle("Beta (12-30 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(-0.05, 0.05))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "none")+
  scale_fill_manual(values=cbp2)
abs_bp_beta

#delta
abs_sc_d <- ggplot(abxpow, aes(x = Time, y = norm_delta, fill=Time))+
  geom_flat_violin(aes(fill=Time),position = position_nudge(x = .01, y = 0), adjust = 1.5, trim = FALSE)+
  geom_point(aes(x = as.numeric(Time)-.15, y = norm_delta),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("Norm. power")+
  xlab("Time")+
  ggtitle("Delta (0.5-4 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "none")+
  scale_fill_manual(values=cbp2)
abs_sc_d
abs_bp_d <- ggplot(abxpow_time, aes(x=Time, y=mean_nd, fill = Time))+
  geom_col(aes(x=Time, y=mean_nd),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abxpow_time, aes(x = as.numeric(Time), y = as.numeric(mean_nd), ymin = as.numeric(mean_nd - se_nd), ymax = as.numeric(mean_nd + se_nd), width = .1),position=position_dodge(0.35))+
  ylab("Norm. pow")+
  xlab("Time")+
  ggtitle("Delta (0.5-4 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(-0.5, 0.5))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "none")+
  scale_fill_manual(values=cbp2)
abs_bp_d

#theta
abs_sc_t <- ggplot(abxpow, aes(x = Time, y = norm_theta, fill=Time))+
  geom_flat_violin(aes(fill=Time),position = position_nudge(x = .01, y = 0), adjust = 1.5, trim = FALSE)+
  geom_point(aes(x = as.numeric(Time)-.15, y = norm_theta),position = position_jitter(width = .05), size = 1, shape = 20)+
  ylab("Norm. power")+
  xlab("Time")+
  ggtitle("Theta (4-8 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "none")+
  scale_fill_manual(values=cbp2)
abs_sc_t
abs_bp_t <- ggplot(abxpow_time, aes(x=Time, y=mean_nt, fill = Time))+
  geom_col(aes(x=Time, y=mean_nt),width=0.5,position=position_dodge(width=0.35))+
  geom_errorbar(data = abxpow_time, aes(x = as.numeric(Time), y = as.numeric(mean_nt), ymin = as.numeric(mean_nt - se_nt), ymax = as.numeric(mean_nt + se_nt), width = .1),position=position_dodge(0.35))+
  ylab("Norm. power")+
  xlab("Time")+
  ggtitle("Theta (4-8 Hz)")+
  theme(axis.title=element_text(size=15), axis.text = element_text(size = 10))+
  coord_cartesian(ylim=c(-0.25, 0.25))+
  scale_x_discrete(labels=Xaxis)+
  theme(legend.position = "none")+
  scale_fill_manual(values=cbp2)
abs_bp_t
