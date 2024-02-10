library(ggplot2)
library(dplyr)
library(readr)
library(readxl)
##
sum_responsespeedweight <- read_excel("GitStuff/mswake/SpreadsheetsnJASP/sum_responsespeedweight.xls")
Xaxis <- c("23:00","01:00","03:00","05:00","07:00")
responsespeed_pvt <- read_excel("GitStuff/mswake/SpreadsheetsnJASP/responsespeed_pvt.xls")
df <- responsespeed_pvt
df %>% filter(Condition=="W")
df$var_Time <- factor(df$var_Time)
df$Gender <- factor(df$Gender)
df$Weight <- factor(df$Weight)

tfw<-sum_responsespeedweight
tfw$time <- factor(tfw$time)
#tfw$Gender <- factor(tfw$Gender)
tfw$Weight <- factor(tfw$Weight)


## BY WEIGHT
RS_cloudplot <- ggplot(df, aes(x = var_Time, y = Response_speed, fill = Weight))+
  geom_flat_violin(aes(fill = Weight),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(var_Time)-.15, y = Response_speed, colour = Weight),position = position_jitter(width = .05), size = 1, shape = 20)+
  geom_boxplot(aes(x = var_Time, y = Response_speed, fill = Weight),outlier.shape = NA, alpha = .5, width = .1, colour = "black")+
  geom_line(data = tfw, aes(x = as.numeric(time)+.1, y = as.numeric(mean_rs), group = Weight, colour = Weight), linetype = 3)+
  geom_point(data = tfw, aes(x = as.numeric(time)+.1, y = as.numeric(mean_rs), group = Weight, colour = Weight), shape = 18) +
  geom_errorbar(data = tfw, aes(x = as.numeric(time)+.1, y = as.numeric(mean_rs), group = Weight, colour = Weight, ymin = as.numeric(mean_rs-se_rs), ymax = as.numeric(mean_rs+se_rs), width = .05))+
  scale_colour_brewer(palette = "Dark2")+
  scale_fill_brewer(palette = "Dark2")+
  ggtitle("Psychomotor Vigilance Performance")+
  labs(x="Time",y="Response Speed")+
  scale_x_discrete(labels= Xaxis)
RS_cloudplot

## BY GENDER
sum_responsespeedgendr<- read_excel("GitStuff/mswake/SpreadsheetsnJASP/sum_responsespeedgendr.xls")
tfg<-sum_responsespeedgendr
tfg$time <- factor(tfg$time)
tfg$Gender <- factor(tfg$Gender)

RS_cloudplot <- ggplot(df, aes(x = var_Time, y = Response_speed, fill = Gender))+
  geom_flat_violin(aes(fill = Gender),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .5, colour = NA)+
  geom_point(aes(x = as.numeric(var_Time)-.15, y = Response_speed, colour = Gender),position = position_jitter(width = .05), size = 1, shape = 20)+
  geom_boxplot(aes(x = var_Time, y = Response_speed, fill = Gender),outlier.shape = NA, alpha = .5, width = .1, colour = "black")+
  geom_line(data = tfg, aes(x = as.numeric(time)+.1, y = as.numeric(mean_rs), group = Gender, colour = Gender), linetype = 4)+
  geom_point(data = tfg, aes(x = as.numeric(time)+.1, y = as.numeric(mean_rs), group = Gender, colour = Gender), shape = 18) +
  geom_errorbar(data = tfg, aes(x = as.numeric(time)+.1, y = as.numeric(mean_rs), group = Gender, colour = Gender, ymin = as.numeric(mean_rs-se_rs), ymax = as.numeric(mean_rs+se_rs), width = .05))+
  scale_colour_brewer(palette = "Dark2")+
  scale_fill_brewer(palette = "Dark2")+
  ggtitle("Psychomotor Vigilance Performance")+
  labs(x="Time",y="Response Speed")+
  scale_x_discrete(labels= Xaxis)
  RS_cloudplot

## Sleep 
## Lapses
  
  