install.packages(merTools)

library(readr)
library(readxl)
library(emmeans)
library(sjstats)
library(lme4)
library(lmerTest)
library(MuMIn)
library(merTools)

###turn off scientfic notation

options(scipen = 999)

###read in the data set
EEGdata <- read_excel("GitStuff/mswake/Main-results/abspow_ROIs.xlsx")
EEGdata$Time=factor(EEGdata$Time)
EEGdata$Sex=factor(EEGdata$Sex)
EEGdata$Weight=factor(EEGdata$Weight)

###R now knows your factors, the below command breaks down your variables 
EEGdata<- subset(EEGdata, outliers_theta==0)
summary(EEGdata)
attach(EEGdata)

lm_atr <- lmer(AT_ratio ~ Time+Sex+Weight+Time*Sex+Time*Weight + (1|participantID))
lm_alpha<- lmer(alphaocc ~ Time+Sex+Weight+Time*Sex+Time*Weight + (1|participantID))
lm_theta<- lmer(thetafc ~ Time+Sex+Weight+Time*Sex+Time*Weight + (1|participantID))
lm_delta<- lmer(deltafront ~ Time+Sex+Weight+Time*Sex+Time*Weight + (1|participantID))
lm_beta <- lmer(betac ~ Time+Sex+Weight+Time*Sex+Time*Weight + (1|participantID))
lm_tarosci <- lmer(osci_tar ~ Time+Sex+Weight+Time*Sex+Time*Weight + (1|participantID))
lm_oscialpha <- lmer(osci_alphaocc ~ Time+Sex+Weight+Time*Sex+Time*Weight + (1|participantID))
lm_oscitheta <- lmer(osci_thetafc ~ Time+Sex+Weight+Time*Sex+Time*Weight + (1|participantID))
lm_oscidelta <- lmer(osci_deltafront ~ Time+Sex+Weight+Time*Sex+Time*Weight + (1|participantID))
lm_fracexp <- lmer(frac_exp ~ Time+Sex+Weight+Time*Sex+Time*Weight + (1|participantID)) 
anova(lm_atr)
anova(lm_alpha)
write_xlsx(anova(lm_alpha),"GitStuff/mswake/SpreadsheetsnJASP/lm_alphatab.xlsx")
write_xlsx(anova(lm_beta),"GitStuff/mswake/SpreadsheetsnJASP/lm_betatab.xlsx")
write_xlsx(anova(lm_delta),"GitStuff/mswake/SpreadsheetsnJASP/lm_deltatab.xlsx")
write_xlsx(anova(lm_theta),"GitStuff/mswake/SpreadsheetsnJASP/lm_thetatab.xlsx")
write_xlsx(anova(lm_atr),"GitStuff/mswake/SpreadsheetsnJASP/lm_atrtab.xlsx")
summary(lm_atr)
summary(lm_alpha)
summary(lm_theta)
summary(lm_delta)
summary(alpha)



confint(lm_atr)
ranef(lm_atr)$participantID
coef(lm_atr)$participantID
m2_alpha<- lmer(alphaocc ~ as.factor(Time)*as.factor(Sex)*as.factor(Weight) + (0+Time|participantID))
m3_alpha<-
res<-anova(m1_alpha)                  ###show model as anova
effectsize::eta_squared(lm_atr, partial = TRUE) ### partial eta sq
effectsize::eta_squared(lm_alpha, partial=TRUE)
effectsize::eta_squared(lm_oscialpha, partial=TRUE)
effectsize::eta_squared(lm_theta, partial=TRUE)
r.squaredGLMM(absalpha_eff)          ### adjust R2 for the model as an alternative
###Post hocs for main effects
emmeans(lm_alpha, pairwise~Time) ### post hoc
emmeans(lm_theta, pairwise~(Time|Weight))
emmeans(lm_theta, pairwise~Time)
qqnorm(resid(m1_alpha))  ##QQ plot showing distribution of residuals 
