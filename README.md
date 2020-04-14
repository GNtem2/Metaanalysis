# Metaanalysis
This project contains several metaanalyses in neurological diseases: Spot sign, Vertigo, Hypoxic-Coma and Coma.

## Hypoxic-Coma
The data in this work has been published. The data is deposited in this repository. 

## Spot-Sign
Accuracy-of-Spot-Sign-meta-analysis of spot sign on CTA to predict hematoma growth and clinical outcome. The original data came from  Du. PLOS One 2014. The current project uses mada package on CRAN. It uses a bivariate method to assess spot sign as diagnostic test. There's also illustration of metaregression. It also contains codes for assessing positive predictive value. The codes are available in .Rmd document. This work has been published in journal Stroke at https://www.ahajournals.org/doi/10.1161/STROKEAHA.118.024347

## Vertigo
This metaanalysis is designed to look at HINT examination as bedside test for diganosis of central or peripheral vertigo. In contrast to the above work, this one is in development.

## TIA
The third metaanalysis examines the rate of stroke recurrence following management in rapid TIA clinic. This one is also under development.


```R
library(metafor) #open software metafor

#create data frame dat
#xi is numerator
#ni is denominator
dat <- data.frame(model=c("melbourne","paris","oxford","stanford","ottawa","new zealand"),
xi=c(7,7,6,2,31,2), 
ni=c(468,296, 281,223,982,172))

#calculate new variable pi base on ratio xi/ni
dat$pi <- with(dat, xi/ni)

#Freeman-Tukey double arcsine trasformation
dat <- escalc(measure="PFT", xi=xi, ni=ni, data=dat, add=0)	
res <- rma(yi, vi, method="REML", data=dat, slab=paste(model))

#create forest plot with labels
forest(res, transf=transf.ipft.hm, targs=list(ni=dat$ni), xlim=c(-1,1.5),refline=0.020,cex=.8, ilab=cbind(dat$xi, dat$ni),
       ilab.xpos=c(-.6,-.4),digits=3)
op <- par(cex=.75, font=2)
text(-1.0, 7.5, "model ",pos=4)
text(c(-.55,-.2), 7.5, c("recurrence", " total subjects"))
text(1.4,7.5, "frequency [95% CI]", pos=2)
par(op)
```
The github repository was created in git bash

```git
git remote add origin https://github.com/GNtem2/Metaanalysis.git
git push -u origin master
```