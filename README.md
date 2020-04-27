# Metaanalysis

This project contains several metaanalyses in neurological diseases: Spot sign, Vertigo, Hypoxic-Coma and Coma. The projects are developed within the subfolders and grouped according to the type of meta-analysis: Proportions and Diagnostic Test.

## PRISMA

The first part of any metaanalysis is the PRISMA statement. This flow diagram can be generated within R using the _PRISMAstatement_ library. The example provided uses data from the Spot Sign project.

## Proportion

A variety of different methods for calculating the 95% confidence interval of the binomial distribution. The mean of the binomial distribution is given by p and the variance by $\frac{p \times (1-p)}{n}$. The term $z$ is given    by $1-\frac{\alpha}{2}$ quantile of normal distribution. A standard way of calculating the confidence interval is the Wald method $p\pm z\times \sqrt{\frac{p \times(1-p)}{n}}$. The Freeman-Tukey double arcsine transformation tries to transform the data to a normal distribution. This approach is useful for handling when occurence of event is rare. The exact or Clopper-Pearson method is suggested as the most conservative of the methods for calculating confidence interval for proportion. It is based on cumulative properties of the binomial distribution. The Wilson method has similarities to the Wald method. It has an extra term $z^2/n$. There are many different methods for calculating the confidence interval for proportions. Investigators such as Agresti proposed that approximate methods are better than exact method. This project is also under development. 

The example below uses Freeman-Tukey double arcsine transformation from the metafor package. The exact method can be performed in a smilar way by by using the binomial.test function and passing the results to forest plot. The Wilson method can be added using similar approach.

```R
library(metafor) #open software metafor
#create data frame dat for TIA data
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

### TIA

This metaanalysis examines the rate of stroke recurrence following management in rapid TIA clinic. 

### Aneurysm

This metaanalysis is designed to examine the rate of rupture of aneurysm. The choice of method depends on whether the rate of rupture is framing of the confidence interval. This study is in development.


## Diagnostic test

There are several approaches to evaluation of diagnostic studies. The current approach is the bivariate method of Reitmas.

### Hypoxic-Coma

This work has been published (Neurology 2010;74:572). The data is deposited in this repository. 

### Spot-Sign (Frequentist)

The spot sign on CTA is used to predict hematoma growth and clinical outcome. The current project uses mada package on CRAN. It uses a bivariate method to assess spot sign as diagnostic test. There's also illustration of metaregression. It also contains codes for assessing positive predictive value. The codes are available in .Rmd document. Data was entered via Survey Monkey. This work has been published in journal Stroke at https://www.ahajournals.org/doi/10.1161/STROKEAHA.118.024347

### Vertigo (Bayesian)

This metaanalysis is designed to look at HINT examination as bedside test for diagnosis of central or peripheral vertigo. In contrast to the above work, this one is in development. It will use the bivariate method for metaanalysis. The variation on the Spot-Sign project will be the use of Bayesian approach to metaanalysis. Data will be entered via RedCap. 

The github repository was created in git bash

## Clinical-Trials

### Network-Metaanalysis

This project is under development.

```git
git remote add origin https://github.com/GNtem2/Metaanalysis.git
git push -u origin master
```