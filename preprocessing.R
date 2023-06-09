---
title: "preprocesssing"
author: "Risa Yamazaki"
date: "2023-06-09"
output: html_document
---
  
### Media data


library(readxl)
#TV
#load data
TV<-read_excel("MMM/UL_MMM_TV.xlsx")
## filtering data on the Mealkit
TV<-subset(TV, TV$Sector =='MEAL KITS')
#make columns of week number and year
TV$week<-format(as.Date(TV$Date), "%U")
TV$year<-format(as.Date(TV$Date), "%Y")
# combine week number and year number into a single column
TV$Periods<- paste(TV$year,TV$week)
#sum the values of cost grouped by the periods (yyyy ww)
TV_2 = data.frame(TV$Periods, Cost = TV$Net.media.costs)
TV_2<- TV_2 %>%
  group_by(TV.Periods) %>%
  summarize(total_cost = sum(Cost))
#change column names
colnames(TV_2) <-c('Periods','TVcosts')


#Overig
#load data
Overig<-read_excel("MMM/UL_MMM_Overig.xlsx")
## filtering data on the Mealkit
Overig<-subset(Overig, Overig$Sector =='MEAL KITS')
#make columns of week number and year
Overig$week<-format(as.Date(Overig$Date), "%U")
Overig$year<-format(as.Date(Overig$Date), "%Y")
# combine week number and year number into a single column
Overig$Periods<- paste(Overig$year,Overig$week)
#sum the values of cost grouped by the periods (yyyy ww)
Overig_2 = data.frame(Overig$Periods, Cost = Overig$`Net media costs`)
Overig_2<- Overig_2 %>%
  group_by(Overig.Periods) %>%
  summarize(total_cost = sum(Cost))
#change column names
colnames(Overig_2) <-c('Periods','Overigcosts')

#FB
FB <- read_excel("MMM/UL_MMM_Facebook.xlsx")
FB<-subset(FB, FB$Sector =='MEAL KITS')
#Separate data into facebook and instagram
IG<-FB[FB$Publisher == 'instagram', ]
FB<-FB[FB$Publisher == 'facebook', ]
#make columns of week number and year
FB$week<-format(as.Date(FB$Date), "%U")
FB$year<-format(as.Date(FB$Date), "%Y")
# combine week number and year number into a single column
FB$Periods<- paste(FB$year,FB$week)
# print the combined dates
print(FB$Periods)
#sum the values of cost grouped by the periods (yyyy ww)
FB_2 = data.frame(FB$Periods, Cost = FB$Costs)
FB_2<- FB_2 %>%
  group_by(FB.Periods) %>%
  summarize(total_cost = sum(Cost))
#change column names
colnames(FB_2) <-c('Periods','FBcosts')

##Instagram
#make columns of week number and year
IG$week<-format(as.Date(IG$Date), "%U")
IG$year<-format(as.Date(IG$Date), "%Y")
# combine week number and year number into a single column
IG$Periods<- paste(IG$year,IG$week)
# print the combined dates
print(IG$Periods)
#sum the values of cost grouped by the periods (yyyy ww)
IG_2 = data.frame(IG$Periods, Cost = IG$Costs)
IG_2<- IG_2 %>%
  group_by(IG.Periods) %>%
  summarize(total_cost = sum(Cost))
#change column names
colnames(IG_2) <-c('Periods','IGcosts')

#Pinterest
#load data
Pinterest<-read_excel("MMM/UL_MMM_Pinterest.xlsx")
## filtering data on the Mealkit
Pinterest<-subset(Pinterest, Pinterest$Sector =='MEAL KITS')
#make columns of week number and year
Pinterest$week<-format(as.Date(Pinterest$Date), "%U")
Pinterest$year<-format(as.Date(Pinterest$Date), "%Y")
# combine week number and year number into a single column
Pinterest$Periods<- paste(Pinterest$year,Pinterest$week)
#sum the values of cost grouped by the periods (yyyy ww)
Pinterest_2 = data.frame(Pinterest$Periods, Cost = Pinterest$Costs)
Pinterest_2<- Pinterest_2 %>%
  group_by(Pinterest.Periods) %>%
  summarize(total_cost = sum(Cost))
#change column names
colnames(Pinterest_2) <-c('Periods','Pinterestcosts')

#Google Adword
#load data
Adword<-read_excel("MMM/UL_MMM_Google Adwords.xlsx")
## filtering data on the Mealkit
Adword<-subset(Adword, Adword$Sector =='MEAL KITS')
#make columns of week number and year
Adword$week<-format(as.Date(Adword$Date), "%U")
Adword$year<-format(as.Date(Adword$Date), "%Y")
# combine week number and year number into a single column
Adword$Periods<- paste(Adword$year,Adword$week)
#sum the values of cost grouped by the periods (yyyy ww)
Adword_2 = data.frame(Adword$Periods, Cost = Adword$Costs)
Adword_2<- Adword_2 %>%
  group_by(Adword.Periods) %>%
  summarize(total_cost = sum(Cost))
#change column names
colnames(Adword_2) <-c('Periods','Adwordcosts')

#Xandr
#load data
Xandr<-read_excel("MMM/UL_MMM_Xandr.xlsx")
## filtering data on the Mealkit
Xandr<-subset(Xandr, Xandr$Sector =='MEAL KITS')
#make columns of week number and year
Xandr$week<-format(as.Date(Xandr$Date), "%U")
Xandr$year<-format(as.Date(Xandr$Date), "%Y")
# combine week number and year number into a single column
Xandr$Periods<- paste(Xandr$year,Xandr$week)
#sum the values of cost grouped by the periods (yyyy ww)
Xandr_2 = data.frame(Xandr$Periods, Cost = Xandr$Costs)
Xandr_2<- Xandr_2 %>%
  group_by(Xandr.Periods) %>%
  summarize(total_cost = sum(Cost))
#change column names
colnames(Xandr_2) <-c('Periods','Xandrcosts')

##DV360
#load data
DV360<- read_excel("MMM/CORRECT_DV360_MMM.xlsx")
## filtering data on the Mealkit
DV360<-subset(DV360, DV360$Sector =='MEAL KITS')
#make columns of week number and year
DV360$week<-format(as.Date(DV360$Date), "%U")
DV360$year<-format(as.Date(DV360$Date), "%Y")
# combine week number and year number into a single column
DV360$Periods<- paste(DV360$year,DV360$week)
#sum the values of cost grouped by the periods (yyyy ww)
DV360_2 = data.frame(DV360$Periods, Cost = DV360$Costs)
DV360_2<- DV360_2 %>%
  group_by(DV360.Periods) %>%
  summarize(total_cost = sum(Cost))
#change column names
colnames(DV360_2) <-c('Periods','DV360costs')


#summing media cost data 
dfs <- list(DV360_2, FB_2, IG_2, TV_2, Xandr_2, Pinterest_2, Adword_2, Overig_2)
# merge all data frames by "Periods" column
mediacosts <- Reduce(function(x, y) merge(x, y, by = "Periods", all = TRUE), dfs)



### KPI data


###sales data
KPI<-data.frame(Knorr_MealKits)
newdata <- data.frame(Knorr_MealKits_1_)
newdata2 <- read_excel("MMM/Knorr_MealKits2.xlsx", 
                       sheet = "FINAL")
#making a column period to align the format 
KPI$period <- substr(KPI$X.PRD_DSC_LONG., nchar(KPI$X.PRD_DSC_LONG)-6, nchar(KPI$X.PRD_DSC_LONG))
newdata$period <- substr(newdata$X.PRD_DSC_LONG., nchar(newdata$X.PRD_DSC_LONG)-6, nchar(newdata$X.PRD_DSC_LONG))
newdata2$period <- substr(newdata2$`[PRD_DSC_LONG]`, nchar(newdata2$`[PRD_DSC_LONG]`)-6, nchar(newdata2$`[PRD_DSC_LONG]`))
#calculate price index
KPI$price_idx <- (KPI$X.Price.per.Item..in.EUR../KPI$MARKET..Price.per.Item..in.EUR..)*100
newdata$price_idx <- (newdata$X.Price.per.Item..in.EUR../newdata$MARKET..Price.per.Item..in.EUR..)*100
newdata2$price_idx <- (newdata2$`[Price per Item (in EUR)]`/newdata2$`MARKET [Price per Item (in EUR)]`)*100
#creating the new dataset
KPI2 = data.frame(Periods = KPI$period, Sales = KPI$X.Total.Units., TDP = KPI$X.TDP., Price = KPI$price_idx)
newdata1_2 = data.frame(Periods = newdata$period, Sales = newdata$X.Total.Units., TDP = newdata$X.TDP., Price = newdata$price_idx)
newdata2_2 = data.frame(Periods = newdata2$period, Sales = newdata2$`[Total Units]`, TDP = newdata2$`[TDP]`, Price = newdata2$price_idx)

#merging all KPI data
KPI2 <- rbind(KPI2, newdata1_2, newdata2_2)                                                                     


### Data cleaning : KPI + Media data

#Merge KPI data and media data
MMM <- merge(mediacosts, KPI2, by = "Periods", all = TRUE)
#convert all na into 0 media costs
MMM[is.na(MMM)] <- 0
#values of 2 columns of media data were assigned to the wrong rows. insert the values into row 73 and delete row 74, as the pseudo-period computed does not exsit. 
#values are hiddden here as they are company data
MMM[73, "FBcosts"] <- XXXXXX
MMM[73, "IGcosts"] <-XXXXXXX
MMM <- MMM[-c(1,2,74,187,189,190,191,192,193,194),]

#convert periods into date format 
MMM$Date <- as.Date(paste0(MMM$Periods, " 1"), format = "%Y %U %u")
# correct a date 
MMM[71, "Date"] <- "2021-01-01"



### Event data


#Merge KPI data and media data
MMM <- merge(mediacosts, KPI2, by = "Periods", all = TRUE)
#convert all na into 0 media costs
MMM[is.na(MMM)] <- 0
#values of 2 columns of media data were assigned to the wrong rows. insert the values into row 73 and delete row 74, as the pseudo-period computed does not exsit. 
MMM[73, "FBcosts"] <- 3276.590
MMM[73, "IGcosts"] <-724.3599
MMM <- MMM[-c(1,2,74,187,189,190,191,192,193,194),]

#convert periods into date format 
MMM$Date <- as.Date(paste0(MMM$Periods, " 1"), format = "%Y %U %u")
# correct a date 
MMM[71, "Date"] <- "2021-01-01"



### Lockdown data


#lockdown data
start_lockdown1 <- "2020-03-16"
end_lockdown1 <- "2020-06-01"
start_lockdown2 <- "2020-10-19"
end_lockdown2 <- "2021-04-28"
start_lockdown3 <- "2021-12-19"
end_lockdown3 <- "2022-04-18"

dt_all$lockdown <- 0
dt_all$lockdown[dt_all$Date >= start_lockdown1 & dt_all$Date <= end_lockdown1] <- 1
dt_all$lockdown[dt_all$Date >= start_lockdown2 & dt_all$Date <= end_lockdown2] <- 1
dt_all$lockdown[dt_all$Date >= start_lockdown3 & dt_all$Date <= end_lockdown3] <- 1
write.csv(dt_all, "thesisMMM.csv", row.names = FALSE)

