library(tidyverse)
library(mada)
library(dplyr)

#load data
dat<-read.csv("semiology.csv", header=TRUE) %>% 
  select (Author, Year, Retain, Parameter, TP, FP, FN, TN) %>% 
  rename(`study names`=Author)

#filter data to include nonduplicate studies only
dat1 <- filter(dat, Retain==1)
dat1 <- subset(dat1, select=-c(Retain))

#filter data to include eyeclosure studies only
eyeclosure <- filter(dat1, Parameter=='Eye closure') 

#remove zeroes
eyeclosure<-eyeclosure[-c(7),]

#print dataframe
eyeclosure

#positive likelihood
posLR.DSL <- madauni(eyeclosure, type = "posLR", method = "DSL")
summary(posLR.DSL)
forest(posLR.DSL)

#negative likelihood
negLR.DSL <- madauni(eyeclosure, type = "negLR", method = "DSL")
summary(negLR.DSL)
forest(negLR.DSL)

##bivariate analysis
(ss<-reitsma(eyeclosure))
summary(ss)
#AUC is available for both mada and meta4diag
srocdat<-reitsma(data = eyeclosure)
mada::AUC(srocdat)

sumss<-SummaryPts(ss,n.iter = 10^3) #bivariate pooled LR
summary(sumss)
plot(srocdat)


#year analysis
ssr<-as.data.frame(ss$residuals)
ssr$Year<-as.Date(as.character(eyeclosure$Year),"%Y")

#sensitivity
p<-ggplot(ssr, aes(x=ssr$Year,y=ssr$tsens))+geom_point()+scale_x_date()+geom_smooth(method="lm")+ggtitle("Relationship between transformed sensitivity and Publication Year")+labs(x="Year",y="transformed sensitivity")
p

#specificity
fitss<-lm(ssr$tfpr~ssr$Year,data=ssr)
q<-ggplot(ssr, aes(x=ssr$Year,y=ssr$tfpr))+geom_point()+scale_x_date()+geom_smooth(method="lm")+ggtitle("Relationship between transformed specificity and Publication Year")
q    

#########Prevalence
library(metafor)
eyeclosure$xi=(eyeclosure$TP+eyeclosure$FN)
eeyeclosure$ni=(eyeclosure$TP+eyeclosure$FP+eyeclosure$FN+eyeclosure$TN)
eyeclosure$pi <- with(eyeclosure, xi/ni)
eyeclosure <- escalc(measure="PFT", xi=xi, ni=ni, data=eyeclosure, add=0) 
res <- rma(yi, vi, method="REML", data=eyeclosure, slab=paste(Authors))
result<-predict(res, transf=transf.ipft.hm, targs=list(ni=eyeclosure$ni))
result$pred

##########Fagan
source("https://raw.githubusercontent.com/achekroud/nomogrammer/master/nomogrammer.r")
p<-nomogrammer(Prevalence = result$pred, Plr = exp(posLR.DSL$coefficients), Nlr = exp(negLR.DSL$coefficients))
p+ggtitle("Fagan's normogram for Spot Sign and ICH growth")
ggsave(p,file="Fagan_SpotSign.png",width=5.99,height=3.99,units="in")




#