setwd("D:/Trivium/Subscription_Information")
library("tidyverse")
library("ggplot2")
library("openxlsx")
library("magrittr")
library("dplyr")
library("stringr")
library("tidyr")
library("writexl")
data<-read.xlsx("cleaned_Free Neopol List1.xlsx")
data<-as.data.frame(data)
sepdata<-separate(data,Email.Address,into = c("Before","After"),sep = "@",remove=FALSE)

#Filter for gov, gou, .go
gov<-sepdata[grep(pattern = "gov",sepdata$After),]
gou<-sepdata[grep(pattern = "gou",sepdata$After),]
go<-sepdata[grep(pattern = ".go",sepdata$After),]
allgov<-rbind(gov,gou,go)%>%distinct()
unique(allgov$After)
write_xlsx(allgov,path ="D:/Trivium/Subscription_Information\\allgov.xlsx" )
