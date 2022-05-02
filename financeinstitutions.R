#developed by Chenhui Zhang
#as a gift to Trivium
#love you all
#====
#set working directory====
setwd("D:/Trivium/Subscription_Information")
#Import libraries====
library("tidyverse")
library("ggplot2")
library("openxlsx")
library("magrittr")
library("dplyr")
library("stringr")
library("tidyr")
library("writexl")
library("readxl")
#Read excel into R====
cleaneddata<-read_excel("cleaned_Free Neopol List1.xlsx", sheet="cleaneddata")
data500<-read_excel("cleaned_Free Neopol List1.xlsx",sheet = "501-1000")
assetmanagers<-read_excel("cleaned_Free Neopol List1.xlsx", sheet="Asset_managers")
banks<-read_excel("cleaned_Free Neopol List1.xlsx", sheet = "Banks")
insurers<-read_excel("cleaned_Free Neopol List1.xlsx", sheet = "Insurers")
allemail<-data.frame(cleaneddata$`Email Address`)
sepemail<-separate(allemail,cleaneddata..Email.Address.,into = c("Before","Suffix"),sep = "@",remove=FALSE)
names(sepemail)<-c("Email","Before","Suffix")

#get all asset managers====
allassetmanagers<-data.frame(Email=c("aaa"),Before=c("null"),Suffix=c("null"))
pat<-data.frame(Pattern="pat")
for (i in 1:29){
  ipat<-assetmanagers$Suffix[i]
  pat<-rbind(pat,ipat)
  iaaa<-sepemail[grep(pattern = ipat,sepemail$Suffix),]
  allassetmanagers<-rbind(allassetmanagers,iaaa)
}
  
allassetmanagers<-allassetmanagers[-1,]
allassetmanagers<-select(allassetmanagers,-Before)
write_xlsx(allassetmanagers,path ="D:/Trivium/Subscription_Information\\assetmanagers.xlsx" )

#get all banks====
allbanks<-data.frame(Email=c("bbb"),Before=c("null"),Suffix=c("null"))
patb<-data.frame(Pattern="pat")
for (j in 1:32){
  jpatb<-banks$Suffix[j]
  patb<-rbind(patb,jpatb)
  ibbb<-sepemail[grep(pattern = jpatb,sepemail$Suffix),]
  allbanks<-rbind(allbanks,ibbb)
}
allbanks<-allbanks[-1,]
allbanks<-select(allbanks,-Before)
write_xlsx(allbanks,path="D:/Trivium/Subscription_Information\\banks.xlsx" )

#get all insurers====
allinsurers<-data.frame(Email=c("ccc"),Before=c("null"),Suffix=c("null"))
patc<-data.frame(Pattern="pat")
for (k in 1:17){
  kpatc<-insurers$Suffix[k]
  patc<-rbind(patc,kpatc)
  iccc<-sepemail[grep(pattern=kpatc,sepemail$Suffix),]
  allinsurers<-rbind(allinsurers,iccc)
}
allinsurers<-allinsurers[-1,]
allinsurers<-select(allinsurers,-Before)
#put them in one file====
write_xlsx(allinsurers,path="D:/Trivium/Subscription_Information\\insures.xlsx")
