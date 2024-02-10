library(ggplot2)
library(dplyr)
library(readr)
library(readxl)
##
abspow<- read_excel("GitStuff/mswake/SpreadsheetsnJASP/abschangepow.xlsx")
Xaxis <- c("01:00","03:00","05:00","07:00")
abspow %>% filter(time!="0")
abspow$time <- factor(abspow$time)
abspow$Weight <- factor(abspow$Weight)
abspow$Sex <- factor(abspow$Sex)

##OVERALL

#alpha
abs_apow <- ggplot(abspow, aes(x = time, y = alpha_absch, fill=time))+
  geom_flat_violin(aes(fill=time),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(time)-.15, y = alpha_absch),position = position_jitter(width = .05), size = 1, shape = 20)+
  geom_boxplot(aes(x = time, y = alpha_absch),outlier.shape = NA, alpha = .5, width = .1, colour = "black")+
  #geom_line(data = tfw, aes(x = as.numeric(time)+.1, y = as.numeric(mean_rs), group = Weight, colour = Weight), linetype = 3)+
  #  geom_point(data = tfw, aes(x = as.numeric(time)+.1, y = as.numeric(mean_rs), group = Weight, colour = Weight), shape = 18) +
  #geom_errorbar(data = tfw, aes(x = as.numeric(time)+.1, y = as.numeric(mean_rs), group = Weight, colour = Weight, ymin = as.numeric(mean_rs-se_rs), ymax = as.numeric(mean_rs+se_rs), width = .05))+
  scale_colour_brewer(palette = "Dark2")+
  scale_fill_brewer(palette = "Dark2")+
  ggtitle("Spectral Power ")+
  labs(x="Time",y="Absolute Power")+
  scale_x_discrete(labels= Xaxis)
abs_apow
#beta
abs_bpow <- ggplot(abspow, aes(x = time, y = beta_absch))+
  geom_flat_violin(position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(time)-.15, y = beta_absch),position = position_jitter(width = .05), size = 1, shape = 20)+
  geom_boxplot(aes(x = time, y = beta_absch),outlier.shape = NA, alpha = .5, width = .1, colour = "black")+
  #geom_line(data = tfw, aes(x = as.numeric(time)+.1, y = as.numeric(mean_rs), group = Weight, colour = Weight), linetype = 3)+
  #  geom_point(data = tfw, aes(x = as.numeric(time)+.1, y = as.numeric(mean_rs), group = Weight, colour = Weight), shape = 18) +
  #geom_errorbar(data = tfw, aes(x = as.numeric(time)+.1, y = as.numeric(mean_rs), group = Weight, colour = Weight, ymin = as.numeric(mean_rs-se_rs), ymax = as.numeric(mean_rs+se_rs), width = .05))+
  scale_colour_brewer(palette = "Dark2")+
  scale_fill_brewer(palette = "Dark2")+
  ggtitle("Spectral Power")+
  labs(x="Time",y="Absolute Power")+
  scale_x_discrete(labels= Xaxis)
abs_bpow
#delta
abs_dpow <- ggplot(abspow, aes(x = time, y = delta_absch))+
  geom_flat_violin(position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(time)-.15, y = delta_absch),position = position_jitter(width = .05), size = 1, shape = 20)+
  geom_boxplot(aes(x = time, y = delta_absch),outlier.shape = NA, alpha = .5, width = .1, colour = "black")+
  #geom_line(data = tfw, aes(x = as.numeric(time)+.1, y = as.numeric(mean_rs), group = Weight, colour = Weight), linetype = 3)+
  #  geom_point(data = tfw, aes(x = as.numeric(time)+.1, y = as.numeric(mean_rs), group = Weight, colour = Weight), shape = 18) +
  #geom_errorbar(data = tfw, aes(x = as.numeric(time)+.1, y = as.numeric(mean_rs), group = Weight, colour = Weight, ymin = as.numeric(mean_rs-se_rs), ymax = as.numeric(mean_rs+se_rs), width = .05))+
  scale_colour_brewer(palette = "Dark2")+
  scale_fill_brewer(palette = "Dark2")+
  ggtitle("Spectral Power")+
  labs(x="Time",y="Absolute Power")+
  scale_x_discrete(labels= Xaxis)
abs_dpow
#theta
abs_tpow <- ggplot(abspow, aes(x = time, y = theta_absch))+
  geom_flat_violin(position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = blue)+
  geom_point(aes(x = as.numeric(time)-.15, y = theta_absch),position = position_jitter(width = .05), size = 1, shape = 20)+
  geom_boxplot(aes(x = time, y = theta_absch),outlier.shape = NA, alpha = .5, width = .1, colour = "black")+
  #geom_line(data = tfw, aes(x = as.numeric(time)+.1, y = as.numeric(mean_rs), group = Weight, colour = Weight), linetype = 3)+
  #  geom_point(data = tfw, aes(x = as.numeric(time)+.1, y = as.numeric(mean_rs), group = Weight, colour = Weight), shape = 18) +
  #geom_errorbar(data = tfw, aes(x = as.numeric(time)+.1, y = as.numeric(mean_rs), group = Weight, colour = Weight, ymin = as.numeric(mean_rs-se_rs), ymax = as.numeric(mean_rs+se_rs), width = .05))+
  scale_colour_brewer(palette = "Dark2")+
  scale_fill_brewer(palette = "Dark2")+
  ggtitle("Spectral Power")+
  labs(x="Time",y="Absolute Power")+
  scale_x_discrete(labels= Xaxis)
abs_tpow


##WEIGHT
#alpha
absalphapow <- ggplot(df, aes(x = time, y = alpha_absch, fill = Weight))+
  geom_flat_violin(aes(fill = Weight),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(time)-.15, y = alpha_absch, colour = Weight),position = position_jitter(width = .05), size = 1, shape = 20)+
  geom_boxplot(aes(x = time, y = alpha_absch, fill = Weight),outlier.shape = NA, alpha = .5, width = .1, colour = "black")+
  geom_line(data = tfw, aes(x = as.numeric(time)+.1, y = as.numeric(mean_rs), group = Weight, colour = Weight), linetype = 3)+
  #  geom_point(data = tfw, aes(x = as.numeric(time)+.1, y = as.numeric(mean_rs), group = Weight, colour = Weight), shape = 18) +
  #geom_errorbar(data = tfw, aes(x = as.numeric(time)+.1, y = as.numeric(mean_rs), group = Weight, colour = Weight, ymin = as.numeric(mean_rs-se_rs), ymax = as.numeric(mean_rs+se_rs), width = .05))+
  scale_colour_brewer(palette = "Dark2")+
  scale_fill_brewer(palette = "Dark2")+
  ggtitle("Psychomotor Vigilance Performance")+
  labs(x="Time",y="Response Speed")+
  scale_x_discrete(labels= Xaxis)
#beta

#delta

#theta

##SEX
#alpha

#beta

#delta

#theta


