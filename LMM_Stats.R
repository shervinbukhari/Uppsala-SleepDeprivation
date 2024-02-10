## SCRIPT FOR CALCULATING LINEAR MIXED MODELS FOR MSWAKE PROJECT##

###pull packages out of the library
library(readr)
library(readxl)
library(emmeans)
library(sjstats)
library(lme4)
library(lmerTest)
library(MuMIn)

###turn off scientfic notation

options(scipen = 999)

###read in the data set
abspow <- read_excel("GitStuff/mswake/SpreadsheetsnJASP/abschangepow.xlsx")
relpow <- read_excel("C:/Users/SHERVIN/Documents/GitStuff/mswake/SpreadsheetsnJASP/relpowr.xlsx")

View(abspow)        
attach(abspow) # FOLLOWING ANALYSIS IS ONLY FOR ABSOLUTE CH. POWER


###Tell it you have factors, and what they are called

abspow$time=factor(abspow$time)
abspow$Sex=factor(abspow$Sex)
abspow$Weight=factor(abspow$Weight)
#EXCLUDE 23:00 from abspow
abspow <- subset(abspow, time %in% c("1","3","5","7"))
relpow$time=factor(relpow$time)
relpow$sex=factor(relpow$sex)
relpow$Weight=factor(relpow$weight)

###R now knows your factors, the below command breaks down your variables 

summary(abspow)

###complex anova,
### we set up our linear model (lmer), with "gaze" as the DV and
### drink as an IV stating as.factor before it) and the we do       the same for Picture type. Then we add a random 
###intercept for the participant by stating + (1|sub) This makes it repeated measures

#alpha
absalpha_eff <- lmer(alpha_absch ~ as.factor(time)*as.factor(Sex)*as.factor(Weight) + (1|participant_ID)) ###linear model DV predicted by the IV (time*sex*weight)
res<-anova(absalpha_eff)                  ###show model as anova
eta_sq(absalpha_eff, partial = TRUE) ### partial eta sq
r.squaredGLMM(absalpha_eff)          ### adjust R2 for the model as an alternative
###Post hocs for main effects
emmeans(absalpha_eff, pairwise~time) ### post hoc for picture type, as its two level this isnt really 
qqnorm(resid(absalpha_eff))  ##QQ plot showing distribution of residuals 




#BMI instead of Weight Group
absalpha_eff2 <- lmer(alpha_absch ~ as.factor(time)*as.factor(Sex) + BMI + (1|participant_ID)) ###linear model DV predicted by the IV (time*sex*weight)
anova(absalpha_eff2)                  ###show model as anova
eta_sq(absalpha_eff2, partial = TRUE) ### partial eta sq
r.squaredGLMM(absalpha_eff2)          ### adjust R2 for the model as an alternative

###Post hocs for main effects
emmeans(absalpha_eff2, pairwise~time) ### post hoc for picture type, as its two level this isnt really 
qqnorm(resid(absalpha_eff2))  ##QQ plot showing distribution of residuals 

#Delta
absdelta_eff <- lmer(delta_absch ~ as.factor(time)*as.factor(Sex)*as.factor(Weight) + (1|participant_ID)) ###linear model DV predicted by the IV (time*sex*weight)
anova(absdelta_eff)                  ###show model as anova
eta_sq(absdelta_eff, partial = TRUE) ### partial eta sq
r.squaredGLMM(absdelta_eff)          ### adjust R2 for the model as an alternative

###Post hocs for main effects
emmeans(absdelta_eff, pairwise~time) ### post hoc for picture type, as its two level this isn't really 

#BMI 
absdelta_eff2 <- lmer(delta_absch ~ as.factor(time)*as.factor(Sex) + BMI + (1|participant_ID)) ###linear model DV predicted by the IV (time*sex*weight)
anova(absdelta_eff2)                  ###show model as anova
eta_sq(absdelta_eff2, partial = TRUE) ### partial eta sq
r.squaredGLMM(absdelta_eff2)    

#Theta
abstheta_eff <- lmer(theta_absch ~ as.factor(time)*as.factor(Sex)*as.factor(Weight) + (1|participant_ID)) ###linear model DV predicted by the IV (time*sex*weight)
anova(abstheta_eff)                  ###show model as anova
eta_sq(abstheta_eff, partial = TRUE) ### partial eta sq
r.squaredGLMM(abstheta_eff)          ### adjust R2 for the model as an alternative

###Post hocs for main effects
emmeans(abstheta_eff, pairwise~time) ### post hoc for picture type, as its two level this isnt really 
qqnorm(resid(abstheta_eff))  ##QQ plot showing distribution of residuals 

#BMI instead of Weight Group
abstheta_eff2 <- lmer(theta_absch ~ as.factor(time)*as.factor(Sex) + BMI + (1|participant_ID)) ###linear model DV predicted by the IV (time*sex*weight)
anova(abstheta_eff2)                  ###show model as anova
eta_sq(abstheta_eff2, partial = TRUE) ### partial eta sq
r.squaredGLMM(abstheta_eff2)  

#Beta
absbeta_eff <- lmer(beta_absch ~ as.factor(time)*as.factor(Sex)*as.factor(Weight) + (1|participant_ID)) ###linear model DV predicted by the IV (time*sex*weight)
anova(absbeta_eff)                  ###show model as anova
eta_sq(absbeta_eff, partial = TRUE) ### partial eta sq
r.squaredGLMM(absbeta_eff)          ### adjust R2 for the model as an alternative

###Post hocs for main effects
emmeans(absbeta_eff, pairwise~time) ### post hoc for picture type, as its two level this isnt really 
qqnorm(resid(absbeta_eff))  ##QQ plot showing distribution of residuals 

#BMI instead of Weight Group
absbeta_eff2 <- lmer(beta_absch ~ as.factor(time)*as.factor(Sex) + BMI + (1|participant_ID)) ###linear model DV predicted by the IV (time*sex*weight)
anova(absbeta_eff2)                  ###show model as anova
eta_sq(absbeta_eff2, partial = TRUE) ### partial eta sq
r.squaredGLMM(absbeta_eff2)  



View(relpow)
attach(abspow) # FOLLOWING ANALYSIS IS ONLY FOR RELATIVE CHANGE IN POWER
summary(relpow)

