# Metaanalysis
This project contains several metaanalyses in neurological diseases: Spot sign, Vertigo, Hypoxic-Coma and Coma.

## Aneurysm
This metaanalysis is designed to examine the rate of rupture of aneurysm. This study is in development.

## Hypoxic-Coma
This work has been published (Neurology 2010;74:572–580). The data is deposited in this repository. 

## Spot-Sign
The spot sign on CTA is used to predict hematoma growth and clinical outcome. The current project uses mada package on CRAN. It uses a bivariate method to assess spot sign as diagnostic test. There's also illustration of metaregression. It also contains codes for assessing positive predictive value. The codes are available in .Rmd document. This work has been published in journal Stroke at https://www.ahajournals.org/doi/10.1161/STROKEAHA.118.024347

## Vertigo
This metaanalysis is designed to look at HINT examination as bedside test for diagnosis of central or peripheral vertigo. In contrast to the above work, this one is in development. It will use the bivariate method for metaanalysis. The variation on the Spot-Sign project will be the use of Bayesian approach to metaanalysis.  

## TIA
The third metaanalysis examines the rate of stroke recurrence following management in rapid TIA clinic. A variety of different methods for calculating the 95% confidence interval of the binomial distribution. The mean of the binomial distribution is given by p and the variance by $p \times (1-p)$. A standard way of calculating the confidence interval is the Wald method $p\pm z\times \sqrt{\frac{p \times(1-p)}{n}}$. The Freeman-Tukey double arcsine transformation tries to transform the data to a normal distribution. This approach is useful for handling when occurence of event is rare. The exact or Clopper-Pearson method is suggested as the most conservative of the methods for calculating confidence interval for proportion. The Wilson method has similarities to the Wald method. It has an extra term $z^2/n$. The many different methods for calculating the confidence interval This project is also under development. 

The example below uses Freeman-Tukey double arcsine transformation from the metafor package. Later the exact method is added by the binomial.test function and passing the results to forest function.

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