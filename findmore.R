#This script helps to find institutions with the most subscribers
#and make more money from them :)
setwd("D:/Trivium/Subscription_Information")
library("tidyverse")
library("ggplot2")
library("openxlsx")
library("magrittr")
library("dplyr")
library("stringr")
library("tidyr")
library("writexl")
library("readxl")
#get current list
fin_asset<-read_excel("financial_institutions.xlsx",sheet="Asset managers")
fin_banks<-read_excel("financial_institutions.xlsx",sheet="Banks")
fin_insurers<-read_excel("financial_institutions.xlsx",sheet="Insurers")
fin<-rbind(fin_asset,fin_banks,fin_insurers)
fin<-as.data.frame(fin)
unifin<-as.data.frame(unique(fin$Suffix))
names(unifin)<-c("Suffix")
gov<-read_excel("gov_all_in_one_list.xlsx",sheet="Sheet1")
gov<-as.data.frame(gov)
unigov<-as.data.frame(unique(gov$Suffix))
names(unigov)<-c("Suffix")
currentlist<-rbind(unifin,unigov)
#find more
findmore<-read_excel("cleaned_Free Neopol List1.xlsx", sheet="findmore")
findmore<-as.data.frame(findmore)
agg<-aggregate(findmore$After,by=list(type=findmore$After),length)
agg<-as.data.frame(agg)
names(agg)<-c("email suffix", "number of subscribers")
write_xlsx(agg,path="D:/Trivium/Subscription_Information\\count_subcribers_by_institution.xlsx")
agg2<-agg[order(agg$`number of subscribers`,agg$`email suffix`,decreasing = TRUE),]
top50<-head(agg2,50)
plot(top50$`number of subscribers`)
quantile(agg2$`number of subscribers`,seq(0.5,1,0.05))
#quantile output as follows
#50%  55%  60%  65%  70%  75%  80%  85%  90%  95% 100% 
#1    1    1    1    2    2    2    3    4    8  109 
#Institutions with less than 3 subscribers accounted for 85% of total subscriptions
