install.pac

Sleepev <- read_excel("GitStuff/mswake/Main-results/Sleepevents_EEG.xlsx")
Sleepev$Sex=factor(Sleepev$Sex)
Sleepev$Weight=factor(Sleepev$Weight)
Sleepev$Time=factor(Sleepev$Time)
Sleepev_glmer <- glmer(EVENT ~ Time*Sex + Time*Weight + (1|Sub), data=Sleepev, family=binomial(link="logit"))
Sleepev_glmer <- glmer(EVENT ~ Time*Sex + Time*Weight + (1|Sub), data=Sleepev, family=binomial(link="logit"), control=glmerControl(optimizer="bobyqa",optCtrl=list(maxfun=2e5)))


m2 <-  glmmTMB(EVENT ~ Time*Sex + Time*Weight + (1|Sub), data=Sleepev, family=binomial(link="logit"))
m3 <- glmmTMB(EVENT ~ Time + (1|Sub), data=Sleepev, family=binomial(link="logit"))
m4 <- glmmTMB(EVENT ~ (1|Sub), data=Sleepev, family=binomial(link="logit"))
anova(m2,m3,m4)
effectsize::chi


numcols <- grep("^c\\.",names(Sleepev))
dfs <- Sleepev
dfs[,numcols] <- scale(dfs[,numcols])
m1_sc <- update(Sleepev_glmer,data=dfs)

tt <- getME(m1_sc,"theta")
ll <- getME(m1_sc,"lower")
min(tt[ll==0])

max(pmin(abs(sc_grad1),abs(derivs1$gradient)))

dd <- update(m1_sc,devFunOnly=TRUE)
pars <- unlist(getME(m1_sc,c("theta","fixef")))
grad2 <- grad(dd,pars)
hess2 <- hessian(dd,pars)
sc_grad2 <- solve(hess2,grad2)
max(pmin(abs(sc_grad2),abs(grad2)))

m1_sc