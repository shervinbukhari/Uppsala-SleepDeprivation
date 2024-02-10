## PLOT OF POWER at 23:00 and 07:00
library(ggplot2)
pow23_7 <- data.frame(pow_23_7)
pow23_7$time = factor(pow23_7$time)
Tlabs <- c("23:00","07:00")

barplot <- ggplot(pow23_7, aes(x = time, y = mean_alpha, fill="time"))+
  geom_col(aes(x = time, y = mean_alpha, fill=""),width=0.5)+
  geom_errorbar(data = pow23_7, aes(x = as.numeric(time), y = as.numeric(mean_alpha), ymin = as.numeric(mean_alpha-se_alpha), ymax = as.numeric(mean_alpha+se_alpha), width = .2))+
  labs(x="Time")+
  ylab(expression(abs.~power~(µV^2)))+
  scale_colour_brewer(palette = "Dark2")+
  scale_fill_brewer(palette = "Dark2")+
  scale_x_discrete(labels= Tlabs)+
  coord_cartesian(ylim=c(1, 3))+
barplot

barplot <- ggplot(pow23_7, aes(x = time, y = mean_beta, fill="time"))+
  geom_col(aes(x = time, y = mean_beta, fill=""),width=0.5)+
  geom_errorbar(data = pow23_7, aes(x = as.numeric(time), y = as.numeric(mean_beta), ymin = as.numeric(mean_beta-se_beta), ymax = as.numeric(mean_beta+se_beta), width = .2))+
  labs(x="Time")+
  ylab(expression(abs.~power~(µV^2)))+
  scale_colour_brewer(palette = "Dark2")+
  scale_fill_brewer(palette = "Dark2")+
  scale_x_discrete(labels= Tlabs)+
  coord_cartesian(ylim=c(0.125, 0.20))+
  theme(axis.title = element_text(size = 15))
barplot

barplot <- ggplot(pow23_7, aes(x = time, y = mean_delta, fill="time"))+
  geom_col(aes(x = time, y = mean_delta, fill=""),width=0.5)+
  geom_errorbar(data = pow23_7, aes(x = as.numeric(time), y = as.numeric(mean_delta), ymin = as.numeric(mean_delta-se_delta), ymax = as.numeric(mean_delta+se_delta), width = .2))+
  labs(x="Time")+
  ylab(expression(abs.~power~(µV^2)))+
  scale_colour_brewer(palette = "Dark2")+
  scale_fill_brewer(palette = "Dark2")+
  scale_x_discrete(labels= Tlabs)+
  coord_cartesian(ylim=c(1, 2.5))+
  theme(axis.title = element_text(size = 15))
barplot

barplot <- ggplot(pow23_7, aes(x = time, y = mean_theta, fill="time"))+
  geom_col(aes(x = time, y = mean_theta, fill="time", ), width=0.5)+
  geom_errorbar(data = pow23_7, aes(x = as.numeric(time), y = as.numeric(mean_theta), ymin = as.numeric(mean_theta-se_theta), ymax = as.numeric(mean_theta+se_theta), width = .2))+
  labs(x="Time")+
  ylab(expression(abs.~power~(µV^2)))+
  scale_colour_brewer(palette = "Dark2")+
  scale_fill_brewer(palette = "Dark2")+
  coord_cartesian(ylim=c(0.5, 2))+
  scale_x_discrete(labels= Tlabs)
barplot
