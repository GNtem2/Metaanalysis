##### Import dataset #####
library(readr); library(metafor) ; library(dplyr) ; library(ggpubr)
df <- read_csv("Study Characteristics Combined.csv")

##### Perform meta-analysis #####
# All studies
dat$model <- c(dat$Study)
dat <- df %>%
  mutate(xi=Combined_event,
         ni=Combined_n,
         pi=xi/ni) #calculate new variable pi base on ratio xi/ni. pi = ischaemic stroke recurrence rate
dat <- escalc(measure="PFT", xi=xi, ni=ni, data=dat, add=0, slab=paste(Study, Pub_year, sep=", "))	#Freeman-Tukey double arcsine transformation
res <- rma(yi, vi, method="REML", data=dat) # REML = restricted maximum-likelihood estimator, a method to estimate amount of heterogeneity
res 
# Cochran's Q is significant when the true outcomes are heterogeneous
# I^2 estimates how much of the total variability in the estimates (total variability = heterogeneity + sampling variability) is heterogeneity
# H^2 is ratio of total variability to sampling variability
predict(res, transf=transf.ipft.hm, targs=list(ni=dat$ni)) # Transform the output back to a proportion
confint(res)

# Count number of participants
sum(dat$Combined_n)

# Create forest plot  
par(cex = 0.9)
forest(res, transf=transf.ipft.hm, targs=list(ni=dat$ni), # transf.ipft.hm = inverse of Freeman-Tukey (double arcsine) transformation for proportions
       xlim=c(-1.1,0.4),refline=0.000,cex=.75, 
       ilab=cbind(dat$Study_type_3, dat$Region, dat$xi, dat$ni), # cex = font size
       ilab.xpos=c(-.7,-.5,-.3,-.1),digits=3, mlab="", header="Study",
       order=order(dat$pi))
op <- par(cex=.75, font=2)
text(c(-.7,-.5,-.3,-.1), 32, c("Study Type", "Region", "Outcomes", "Total Subjects"))
par(op)

### add text with Q-value, dfs, p-value, and I^2 statistic
text(-1, -1, pos=4, cex=0.75, bquote(paste("RE Model (Q = ",
                                           .(formatC(res$QE, digits=2, format="f")), ", df = ", .(res$k - res$p),
                                           ", p = ", .(formatC(res$QEp, digits=2, format="f")), "; ", I^2, " = ",
                                           .(formatC(res$I2, digits=1, format="f")), "%)")))


# All studies, minor stroke only
df2 <- filter(df, Retain_MS_only == TRUE) # Only keep retained studies
dat2$model <- c(dat2$Study)
dat2 <- df2 %>%
  mutate(xi=Minor_stroke_event,
         ni=Minor_stroke_n,
         pi=xi/ni) #calculate new variable pi base on ratio xi/ni. pi = ischaemic stroke recurrence rate
dat2 <- escalc(measure="PFT", xi=xi, ni=ni, data=dat2, add=0, slab=paste(Study, Pub_year, sep=", "))	#Freeman-Tukey double arcsine transformation
res2 <- rma(yi, vi, method="REML", data=dat2) # REML = restricted maximum-likelihood estimator, a method to estimate amount of heterogeneity
res2 
# Cochran's Q is significant when the true outcomes are heterogeneous
# I^2 estimates how much of the total variability in the estimates (total variability = heterogeneity + sampling variability) is heterogeneity
# H^2 is ratio of total variability to sampling variability
predict(res2, transf=transf.ipft.hm, targs=list(ni=dat2$ni)) # Transform the output back to a proportion
confint(res2)

# Count number of participants
sum(dat2$Minor_stroke_n)

# Create forest plot  
par(cex = 0.9)
forest(res2, transf=transf.ipft.hm, targs=list(ni=dat2$ni), # transf.ipft.hm = inverse of Freeman-Tukey (double arcsine) transformation for proportions
       xlim=c(-1.1,0.4),refline=0.000,cex=.75, 
       ilab=cbind(dat2$Study_type_3, dat2$Region, dat2$xi, dat2$ni), # cex = font size
       ilab.xpos=c(-.7,-.5,-.3,-.1),digits=3, mlab="", header="Study",
       order=order(dat2$pi))
op <- par(cex=.75, font=2)
text(c(-.7,-.5,-.3,-.1), 21, c(" Study type", "Region", "Outcomes", "Total Subjects"))
par(op)


### add text with Q-value, dfs, p-value, and I^2 statistic
text(-1, -1, pos=4, cex=0.75, bquote(paste("RE Model (Q = ",
                                           .(formatC(res2$QE, digits=2, format="f")), ", df = ", .(res2$k - res2$p),
                                           ", p = ", .(formatC(res2$QEp, digits=2, format="f")), "; ", I^2, " = ",
                                           .(formatC(res2$I2, digits=1, format="f")), "%)")))



### Metaregression #####
# Variables:
# Study_type_3 i.e. observational, RCT-control, RCT-experimental
# Study_type_2 i.e. observational, RCT
# Setting i.e. single or multicentre
# Year_start i.e. Start year of cohort accrual
# Pub_year i.e. year of publication
# Continent i.e. Continent where studies were performed

# All studies
res <- rma(yi, vi, method="REML", mods = ~ Study_type_3, data=dat)
res
res <- rma(yi, vi, method="REML", mods = ~ Study_type_2, data=dat)
res
res <- rma(yi, vi, method="REML", mods = ~ Setting, data=dat)
res
res <- rma(yi, vi, method="REML", mods = ~ Year_start, data=dat)
res
res <- rma(yi, vi, method="REML", mods = ~ Pub_year, data=dat)
res # Significant
res <- rma(yi, vi, method="REML", mods = ~ Continent, data=dat)
res # Significant 
res <- rma(yi, vi, method="REML", mods = ~ International, data=dat)
res 


# Minor stroke only
res <- rma(yi, vi, method="REML", mods = ~ Study_type_3, data=dat2)
res
res <- rma(yi, vi, method="REML", mods = ~ Study_type_2, data=dat2)
res
res <- rma(yi, vi, method="REML", mods = ~ Setting, data=dat2)
res # Significant
res <- rma(yi, vi, method="REML", mods = ~ Year_start, data=dat2)
res
res <- rma(yi, vi, method="REML", mods = ~ Pub_year, data=dat2)
res # Significant
res <- rma(yi, vi, method="REML", mods = ~ Continent, data=dat2)
res 
res <- rma(yi, vi, method="REML", mods = ~ International, data=dat2)
res 

