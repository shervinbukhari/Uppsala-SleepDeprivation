#
install.packages("writexl")
library("writexl")

PVT <- read_excel("GitStuff/mswake/SpreadsheetsnJASP/pvt_data_R.xlsx")
PVT <- na.omit(PVT)
PVT <- PVT %>% group_by(var_Time,Condition,sub) %>% summarise(mean_rs=mean(Response_speed), se_rs=std.error(Response_speed))

write_xlsx(PVT,"GitStuff/mswake/SpreadsheetsnJASP/PVT_responsetimes.xlsx")

PVT2 <- read_excel("GitStuff/mswake/SpreadsheetsnJASP/PVT/added109108118168RTs.xlsx")
PVT2 <- read_excel("GitStuff/mswake/SpreadsheetsnJASP/PVT/added109108118168RTs.xlsx")
PVT2 <- na.omit(PVT2)

PVT2 <- PVT2 %>% group_by(Time,Condition,sub) %>% summarise(mean_rs=mean(Response_speed), se_rs=std.error(Response_speed))

write_xlsx(PVT2,"GitStuff/mswake/SpreadsheetsnJASP/PVT_responsetimes2.xlsx")
## CALC AND EXP LAPSES DATA
Lapses<- read_excel("GitStuff/mswake/SpreadsheetsnJASP/PVT/PVT_DATA_all_raw.xlsx")
sum_Lapses <- Lapses %>% group_by(Time,Condition,G) %>% summarise(Olapse=sum(Olapse), Clapse=sum(Clapse))
write_xlsx(sum_Lapses,"GitStuff/mswake/SpreadsheetsnJASP/PVT_Lapses.xlsx")



PVT <- read_excel("GitStuff/mswake/SpreadsheetsnJASP/PVT/PVT_DATA_onlyvalid.xlsx")
PVT <- PVT %>% group_by(Time,Condition,G) %>% summarise(mean_rt=mean(rt),se_rt=std.error(rt), mean_rs=mean(rs), se_rs=std.error(rs), mean_rsslowest=mean(rs[rs>=quantile(rs, 0.9)]),se_slowest=std.error(rs[rs>=quantile(rs, 0.9)]))
write_xlsx(PVT,"GitStuff/mswake/SpreadsheetsnJASP/PVT/mean_RT_rs_slowest.xlsx")

PVT <- read_excel("GitStuff/mswake/SpreadsheetsnJASP/PVT/PVT_DATA_all_nofalsestarts.xlsx")
PVT <- PVT %>% group_by(Time,Condition,G) %>% summarise(mean_rs=mean(rs),se_rs=std.error(rs), mean_slowestrs=mean(rs[rs>=quantile(rs, 0.9)]),se_slowest=std.error(rs[rs>=quantile(rs, 0.9)]))
write_xlsx(PVT,"GitStuff/mswake/SpreadsheetsnJASP/PVT/meanrs_basner.xlsx")
