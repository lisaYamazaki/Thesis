---
title: "preprocesssing"
author: "Risa Yamazaki"
date: "2023-06-09"
output: html_document
---
  
### Media data


library(readxl)
#TrdA
#load data
TrdA<-read_excel("MMM/UL_MMM_TrdA.xlsx")
## filtering data on the Mealkit
TrdA<-subset(TrdA, TrdA$Sector =='MEAL KITS')
#make columns of week number and year
TrdA$week<-format(as.Date(TrdA$Date), "%U")
TrdA$year<-format(as.Date(TrdA$Date), "%Y")
# combine week number and year number into a single column
TrdA$Periods<- paste(TrdA$year,TrdA$week)
#sum the values of cost grouped by the periods (yyyy ww)
TrdA_2 = data.frame(TrdA$Periods, Cost = TrdA$Net.media.costs)
TrdA_2<- TrdA_2 %>%
  group_by(TrdA.Periods) %>%
  summarize(total_cost = sum(Cost))
#change column names
colnames(TrdA_2) <-c('Periods','TrdAcosts')


#TrdB
#load data
TrdB<-read_excel("MMM/UL_MMM_TrdB.xlsx")
## filtering data on the Mealkit
TrdB<-subset(TrdB, TrdB$Sector =='MEAL KITS')
#make columns of week number and year
TrdB$week<-format(as.Date(TrdB$Date), "%U")
TrdB$year<-format(as.Date(TrdB$Date), "%Y")
# combine week number and year number into a single column
TrdB$Periods<- paste(TrdB$year,TrdB$week)
#sum the values of cost grouped by the periods (yyyy ww)
TrdB_2 = data.frame(TrdB$Periods, Cost = TrdB$`Net media costs`)
TrdB_2<- TrdB_2 %>%
  group_by(TrdB.Periods) %>%
  summarize(total_cost = sum(Cost))
#change column names
colnames(TrdB_2) <-c('Periods','TrdBcosts')

#DgtA
DgtA <- read_excel("MMM/UL_MMM_DgtA.xlsx")
DgtA<-subset(DgtA, DgtA$Sector =='MEAL KITS')
#Separate data into DgtA and instagram
DgtB<-DgtA[DgtA$Publisher == 'instagram', ]
DgtA<-DgtA[DgtA$Publisher == 'DgtA', ]
#make columns of week number and year
DgtA$week<-format(as.Date(DgtA$Date), "%U")
DgtA$year<-format(as.Date(DgtA$Date), "%Y")
# combine week number and year number into a single column
DgtA$Periods<- paste(DgtA$year,DgtA$week)
# print the combined dates
print(DgtA$Periods)
#sum the values of cost grouped by the periods (yyyy ww)
DgtA_2 = data.frame(DgtA$Periods, Cost = DgtA$Costs)
DgtA_2<- DgtA_2 %>%
  group_by(DgtA.Periods) %>%
  summarize(total_cost = sum(Cost))
#change column names
colnames(DgtA_2) <-c('Periods','DgtAcosts')

##Instagram
#make columns of week number and year
DgtB$week<-format(as.Date(DgtB$Date), "%U")
DgtB$year<-format(as.Date(DgtB$Date), "%Y")
# combine week number and year number into a single column
DgtB$Periods<- paste(DgtB$year,DgtB$week)
# print the combined dates
print(DgtB$Periods)
#sum the values of cost grouped by the periods (yyyy ww)
DgtB_2 = data.frame(DgtB$Periods, Cost = DgtB$Costs)
DgtB_2<- DgtB_2 %>%
  group_by(DgtB.Periods) %>%
  summarize(total_cost = sum(Cost))
#change column names
colnames(DgtB_2) <-c('Periods','DgtBcosts')

#DgtC
#load data
DgtC<-read_excel("MMM/UL_MMM_DgtC.xlsx")
## filtering data on the Mealkit
DgtC<-subset(DgtC, DgtC$Sector =='MEAL KITS')
#make columns of week number and year
DgtC$week<-format(as.Date(DgtC$Date), "%U")
DgtC$year<-format(as.Date(DgtC$Date), "%Y")
# combine week number and year number into a single column
DgtC$Periods<- paste(DgtC$year,DgtC$week)
#sum the values of cost grouped by the periods (yyyy ww)
DgtC_2 = data.frame(DgtC$Periods, Cost = DgtC$Costs)
DgtC_2<- DgtC_2 %>%
  group_by(DgtC.Periods) %>%
  summarize(total_cost = sum(Cost))
#change column names
colnames(DgtC_2) <-c('Periods','DgtCcosts')

#Google DgtD
#load data
DgtD<-read_excel("MMM/UL_MMM_Google DgtDs.xlsx")
## filtering data on the Mealkit
DgtD<-subset(DgtD, DgtD$Sector =='MEAL KITS')
#make columns of week number and year
DgtD$week<-format(as.Date(DgtD$Date), "%U")
DgtD$year<-format(as.Date(DgtD$Date), "%Y")
# combine week number and year number into a single column
DgtD$Periods<- paste(DgtD$year,DgtD$week)
#sum the values of cost grouped by the periods (yyyy ww)
DgtD_2 = data.frame(DgtD$Periods, Cost = DgtD$Costs)
DgtD_2<- DgtD_2 %>%
  group_by(DgtD.Periods) %>%
  summarize(total_cost = sum(Cost))
#change column names
colnames(DgtD_2) <-c('Periods','DgtDcosts')

#PDgtA
#load data
PDgtA<-read_excel("MMM/UL_MMM_PDgtA.xlsx")
## filtering data on the Mealkit
PDgtA<-subset(PDgtA, PDgtA$Sector =='MEAL KITS')
#make columns of week number and year
PDgtA$week<-format(as.Date(PDgtA$Date), "%U")
PDgtA$year<-format(as.Date(PDgtA$Date), "%Y")
# combine week number and year number into a single column
PDgtA$Periods<- paste(PDgtA$year,PDgtA$week)
#sum the values of cost grouped by the periods (yyyy ww)
PDgtA_2 = data.frame(PDgtA$Periods, Cost = PDgtA$Costs)
PDgtA_2<- PDgtA_2 %>%
  group_by(PDgtA.Periods) %>%
  summarize(total_cost = sum(Cost))
#change column names
colnames(PDgtA_2) <-c('Periods','PDgtAcosts')

##PDgtB
#load data
PDgtB<- read_excel("MMM/CORRECT_PDgtB_MMM.xlsx")
## filtering data on the Mealkit
PDgtB<-subset(PDgtB, PDgtB$Sector =='MEAL KITS')
#make columns of week number and year
PDgtB$week<-format(as.Date(PDgtB$Date), "%U")
PDgtB$year<-format(as.Date(PDgtB$Date), "%Y")
# combine week number and year number into a single column
PDgtB$Periods<- paste(PDgtB$year,PDgtB$week)
#sum the values of cost grouped by the periods (yyyy ww)
PDgtB_2 = data.frame(PDgtB$Periods, Cost = PDgtB$Costs)
PDgtB_2<- PDgtB_2 %>%
  group_by(PDgtB.Periods) %>%
  summarize(total_cost = sum(Cost))
#change column names
colnames(PDgtB_2) <-c('Periods','PDgtBcosts')


#summing media cost data 
dfs <- list(PDgtB_2, DgtA_2, DgtB_2, TrdA_2, PDgtA_2, DgtC_2, DgtD_2, TrdB_2)
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
MMM[73, "DgtAcosts"] <- XXXXXX
MMM[73, "DgtBcosts"] <-XXXXXXX
MMM <- MMM[-c(1,2,74,187,189,190,191,192,193,194),]

#convert periods into date format 
MMM$Date <- as.Date(paste0(MMM$Periods, " 1"), format = "%Y %U %u")
# correct a date 
MMM[71, "Date"] <- "2021-01-01"



### Event data
Event_Labelling_per_Brand <- read_excel("MMM/Event Labelling per Brand.xlsx")
View(Event_Labelling_per_Brand)
dt_event <-subset(Event_Labelling_per_Brand, Event_Labelling_per_Brand$Brands =='Knorr Mealkits')
dt_event[1,"Events"] <- "event1"
dt_event[2,"Events"] <- "event2"
dt_event[3,"Events"] <- "event3"
dt_event$week<-format(as.Date(dt_event$Date), "%U")
dt_event$year<-format(as.Date(dt_event$Date), "%Y")
# combine week number and year number into a single column
dt_event$Periods<- paste(dt_event$year,dt_event$week)
dt_event <-subset(dt_event, select = -Date)
dt_event <-subset(dt_event, select = -Brands)
dt_event <-subset(dt_event, select = -year)
dt_event <-subset(dt_event, select = -week)
dt_all <- merge(MMM, dt_event, by ="Periods",all.x = TRUE)
dt_all$Events <- ifelse(is.na(dt_all$Events), "na", dt_all$Events)

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


#for linear regression
#slicing dt_all into 3 parts: 80% train data, 10 % for validation and 10% for test. The division is the same ratio as Robyn time-series split. 
n <- nrow(dt_all) # Calculate the total number of elements in your data
trainnrow <- floor(n * 0.8)
MMM_train <- slice(dt_all,1:trainnrow)

valrow <- floor(n* 0.1)
MMM_val <- slice(dt_all, (nrow(MMM_train) + 1):(nrow(MMM_train) + valrow))

testrow <- floor(n* 0.1)
MMM_test <- slice(dt_all, (nrow(MMM_train) + nrow(MMM_val) + 1):(nrow(MMM_train) + nrow(MMM_val) + testrow))
