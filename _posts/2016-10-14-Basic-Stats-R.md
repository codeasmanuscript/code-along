---
title: Basic statistics and R commands
details: Learn about common R and statistic commands.
location: FG423
date: 2016-10-14
time: '13:00'
topic: basic stats and R
packages: '"broom"'
permalink: /404
---

Outline:

- Basic descriptive (mean, median, SD, IQR)
- t-test
- Correlation
- ANOVA
- Linear regression
- Logistic regression


{% highlight r %}
library(broom)
ds <- read.csv("http://codeasmanuscript.org/states_data.csv")
head(ds)
{% endhighlight %}



{% highlight text %}
#>    StateName Population Income Illiteracy LifeExp Murder HSGrad Frost
#> 1    Alabama       3615   3624        2.1   69.05   15.1   41.3    20
#> 2     Alaska        365   6315        1.5   69.31   11.3   66.7   152
#> 3    Arizona       2212   4530        1.8   70.55    7.8   58.1    15
#> 4   Arkansas       2110   3378        1.9   70.66   10.1   39.9    65
#> 5 California      21198   5114        1.1   71.71   10.3   62.6    20
#> 6   Colorado       2541   4884        0.7   72.06    6.8   63.9   166
#>     Area Region           Division Longitude Latitude
#> 1  50708  South East South Central  -86.7509  32.5901
#> 2 566432   West            Pacific -127.2500  49.2500
#> 3 113417   West           Mountain -111.6250  34.2192
#> 4  51945  South West South Central  -92.2992  34.7336
#> 5 156361   West            Pacific -119.7730  36.5341
#> 6 103766   West           Mountain -105.5130  38.6777
{% endhighlight %}



{% highlight r %}
str(ds)
{% endhighlight %}



{% highlight text %}
#> 'data.frame':	50 obs. of  13 variables:
#>  $ StateName : Factor w/ 50 levels "Alabama","Alaska",..: 1 2 3 4 5 6 7 8 9 10 ...
#>  $ Population: num  3615 365 2212 2110 21198 ...
#>  $ Income    : num  3624 6315 4530 3378 5114 ...
#>  $ Illiteracy: num  2.1 1.5 1.8 1.9 1.1 0.7 1.1 0.9 1.3 2 ...
#>  $ LifeExp   : num  69 69.3 70.5 70.7 71.7 ...
#>  $ Murder    : num  15.1 11.3 7.8 10.1 10.3 6.8 3.1 6.2 10.7 13.9 ...
#>  $ HSGrad    : num  41.3 66.7 58.1 39.9 62.6 63.9 56 54.6 52.6 40.6 ...
#>  $ Frost     : num  20 152 15 65 20 166 139 103 11 60 ...
#>  $ Area      : num  50708 566432 113417 51945 156361 ...
#>  $ Region    : Factor w/ 4 levels "North Central",..: 3 4 4 3 4 4 2 3 3 3 ...
#>  $ Division  : Factor w/ 9 levels "East North Central",..: 2 6 4 9 6 4 5 7 7 7 ...
#>  $ Longitude : num  -86.8 -127.2 -111.6 -92.3 -119.8 ...
#>  $ Latitude  : num  32.6 49.2 34.2 34.7 36.5 ...
{% endhighlight %}



{% highlight r %}
summary(ds)
{% endhighlight %}



{% highlight text %}
#>       StateName    Population        Income       Illiteracy   
#>  Alabama   : 1   Min.   :  365   Min.   :3098   Min.   :0.500  
#>  Alaska    : 1   1st Qu.: 1080   1st Qu.:3993   1st Qu.:0.625  
#>  Arizona   : 1   Median : 2838   Median :4519   Median :0.950  
#>  Arkansas  : 1   Mean   : 4246   Mean   :4436   Mean   :1.170  
#>  California: 1   3rd Qu.: 4968   3rd Qu.:4814   3rd Qu.:1.575  
#>  Colorado  : 1   Max.   :21198   Max.   :6315   Max.   :2.800  
#>  (Other)   :44                                                 
#>     LifeExp          Murder           HSGrad          Frost       
#>  Min.   :67.96   Min.   : 1.400   Min.   :37.80   Min.   :  0.00  
#>  1st Qu.:70.12   1st Qu.: 4.350   1st Qu.:48.05   1st Qu.: 66.25  
#>  Median :70.67   Median : 6.850   Median :53.25   Median :114.50  
#>  Mean   :70.88   Mean   : 7.378   Mean   :53.11   Mean   :104.46  
#>  3rd Qu.:71.89   3rd Qu.:10.675   3rd Qu.:59.15   3rd Qu.:139.75  
#>  Max.   :73.60   Max.   :15.100   Max.   :67.30   Max.   :188.00  
#>                                                                   
#>       Area                  Region                 Division 
#>  Min.   :  1049   North Central:12   Mountain          : 8  
#>  1st Qu.: 36985   Northeast    : 9   South Atlantic    : 8  
#>  Median : 54277   South        :16   West North Central: 7  
#>  Mean   : 70736   West         :13   New England       : 6  
#>  3rd Qu.: 81162                      East North Central: 5  
#>  Max.   :566432                      Pacific           : 5  
#>                                      (Other)           :11  
#>    Longitude          Latitude    
#>  Min.   :-127.25   Min.   :27.87  
#>  1st Qu.:-104.16   1st Qu.:35.55  
#>  Median : -89.90   Median :39.62  
#>  Mean   : -92.46   Mean   :39.41  
#>  3rd Qu.: -78.98   3rd Qu.:43.14  
#>  Max.   : -68.98   Max.   :49.25  
#> 
{% endhighlight %}



{% highlight r %}
mean(ds$Frost)
{% endhighlight %}



{% highlight text %}
#> [1] 104.46
{% endhighlight %}



{% highlight r %}
median(ds$Population)
{% endhighlight %}



{% highlight text %}
#> [1] 2838.5
{% endhighlight %}



{% highlight r %}
sd(ds$Illiteracy)
{% endhighlight %}



{% highlight text %}
#> [1] 0.6095331
{% endhighlight %}



{% highlight r %}
IQR(ds$Area)
{% endhighlight %}



{% highlight text %}
#> [1] 44177.25
{% endhighlight %}



{% highlight r %}
t.test(ds$Population, ds$HS.Grad)
{% endhighlight %}



{% highlight text %}
#> 
#> 	One Sample t-test
#> 
#> data:  ds$Population
#> t = 6.7257, df = 49, p-value = 1.765e-08
#> alternative hypothesis: true mean is not equal to 0
#> 95 percent confidence interval:
#>  2977.626 5515.214
#> sample estimates:
#> mean of x 
#>   4246.42
{% endhighlight %}



{% highlight r %}
tidy(t.test(ds$Population, ds$HS.Grad))
{% endhighlight %}



{% highlight text %}
#>   estimate statistic      p.value parameter conf.low conf.high
#> 1  4246.42  6.725676 1.765367e-08        49 2977.626  5515.214
#>              method alternative
#> 1 One Sample t-test   two.sided
{% endhighlight %}



{% highlight r %}
cor(ds$LifeExp, ds$Population)
{% endhighlight %}



{% highlight text %}
#> [1] -0.06805195
{% endhighlight %}



{% highlight r %}
cor.test(ds$LifeExp, ds$Population)
{% endhighlight %}



{% highlight text %}
#> 
#> 	Pearson's product-moment correlation
#> 
#> data:  ds$LifeExp and ds$Population
#> t = -0.47257, df = 48, p-value = 0.6387
#> alternative hypothesis: true correlation is not equal to 0
#> 95 percent confidence interval:
#>  -0.3399601  0.2143561
#> sample estimates:
#>         cor 
#> -0.06805195
{% endhighlight %}



{% highlight r %}
cor(ds[c('Frost', 'Population', 'Area')])
{% endhighlight %}



{% highlight text %}
#>                 Frost  Population       Area
#> Frost       1.0000000 -0.33215245 0.05922910
#> Population -0.3321525  1.00000000 0.02254384
#> Area        0.0592291  0.02254384 1.00000000
{% endhighlight %}



{% highlight r %}
tidy(cor.test(ds$LifeExp, ds$Population))
{% endhighlight %}



{% highlight text %}
#>      estimate  statistic   p.value parameter   conf.low conf.high
#> 1 -0.06805195 -0.4725733 0.6386594        48 -0.3399601 0.2143561
#>                                 method alternative
#> 1 Pearson's product-moment correlation   two.sided
{% endhighlight %}



{% highlight r %}
tidy(cor(ds[c('Frost', 'Population', 'Area')]))
{% endhighlight %}



{% highlight text %}
#>    .rownames      Frost  Population       Area
#> 1      Frost  1.0000000 -0.33215245 0.05922910
#> 2 Population -0.3321525  1.00000000 0.02254384
#> 3       Area  0.0592291  0.02254384 1.00000000
{% endhighlight %}



{% highlight r %}
tidy(cor(ds[c('Frost', 'Population', 'Area')]))
{% endhighlight %}



{% highlight text %}
#>    .rownames      Frost  Population       Area
#> 1      Frost  1.0000000 -0.33215245 0.05922910
#> 2 Population -0.3321525  1.00000000 0.02254384
#> 3       Area  0.0592291  0.02254384 1.00000000
{% endhighlight %}



{% highlight r %}
tidy(cor(ds[c('Frost', 'Population', 'Area')], 
         method = 'spearman'))
{% endhighlight %}



{% highlight text %}
#>    .rownames      Frost Population       Area
#> 1      Frost  1.0000000 -0.4588526  0.1122878
#> 2 Population -0.4588526  1.0000000 -0.1206723
#> 3       Area  0.1122878 -0.1206723  1.0000000
{% endhighlight %}



{% highlight r %}
tidy(cor(ds[c('Frost', 'Population', 'Area')], 
         use = 'complete.obs',
         method = 'spearman'))
{% endhighlight %}



{% highlight text %}
#>    .rownames      Frost Population       Area
#> 1      Frost  1.0000000 -0.4588526  0.1122878
#> 2 Population -0.4588526  1.0000000 -0.1206723
#> 3       Area  0.1122878 -0.1206723  1.0000000
{% endhighlight %}



{% highlight r %}
aov(Sepal.Length ~ Species, data = iris)
{% endhighlight %}



{% highlight text %}
#> Call:
#>    aov(formula = Sepal.Length ~ Species, data = iris)
#> 
#> Terms:
#>                  Species Residuals
#> Sum of Squares  63.21213  38.95620
#> Deg. of Freedom        2       147
#> 
#> Residual standard error: 0.5147894
#> Estimated effects may be unbalanced
{% endhighlight %}



{% highlight r %}
summary(aov(Sepal.Length ~ Species, data = iris))
{% endhighlight %}



{% highlight text %}
#>              Df Sum Sq Mean Sq F value Pr(>F)    
#> Species       2  63.21  31.606   119.3 <2e-16 ***
#> Residuals   147  38.96   0.265                   
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
{% endhighlight %}



{% highlight r %}
tidy(aov(Sepal.Length ~ Species, data = iris))
{% endhighlight %}



{% highlight text %}
#>        term  df    sumsq     meansq statistic      p.value
#> 1   Species   2 63.21213 31.6060667  119.2645 1.669669e-31
#> 2 Residuals 147 38.95620  0.2650082        NA           NA
{% endhighlight %}



{% highlight r %}
glm(Murder ~ Income, data = ds, family = gaussian())
{% endhighlight %}



{% highlight text %}
#> 
#> Call:  glm(formula = Murder ~ Income, family = gaussian(), data = ds)
#> 
#> Coefficients:
#> (Intercept)       Income  
#>   13.509309    -0.001382  
#> 
#> Degrees of Freedom: 49 Total (i.e. Null);  48 Residual
#> Null Deviance:	    667.7 
#> Residual Deviance: 632.4 	AIC: 274.8
{% endhighlight %}



{% highlight r %}
summary(glm(Murder ~ Income, data = ds, family = gaussian()))
{% endhighlight %}



{% highlight text %}
#> 
#> Call:
#> glm(formula = Murder ~ Income, family = gaussian(), data = ds)
#> 
#> Deviance Residuals: 
#>     Min       1Q   Median       3Q      Max  
#> -6.0495  -2.8033  -0.2727   3.0730   6.5999  
#> 
#> Coefficients:
#>               Estimate Std. Error t value Pr(>|t|)    
#> (Intercept) 13.5093092  3.7782753   3.576  0.00081 ***
#> Income      -0.0013822  0.0008439  -1.638  0.10797    
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> (Dispersion parameter for gaussian family taken to be 13.17496)
#> 
#>     Null deviance: 667.75  on 49  degrees of freedom
#> Residual deviance: 632.40  on 48  degrees of freedom
#> AIC: 274.77
#> 
#> Number of Fisher Scoring iterations: 2
{% endhighlight %}



{% highlight r %}
tidy(glm(Murder ~ Income, data = ds, family = gaussian()))
{% endhighlight %}



{% highlight text %}
#>          term     estimate    std.error statistic      p.value
#> 1 (Intercept) 13.509309166 3.7782752868  3.575523 0.0008095577
#> 2      Income -0.001382233 0.0008438709 -1.637967 0.1079683114
{% endhighlight %}



{% highlight r %}
glm(group ~ extra, data = sleep, family = binomial())
{% endhighlight %}



{% highlight text %}
#> 
#> Call:  glm(formula = group ~ extra, family = binomial(), data = sleep)
#> 
#> Coefficients:
#> (Intercept)        extra  
#>     -0.6928       0.4652  
#> 
#> Degrees of Freedom: 19 Total (i.e. Null);  18 Residual
#> Null Deviance:	    27.73 
#> Residual Deviance: 24.29 	AIC: 28.29
{% endhighlight %}



{% highlight r %}
summary(glm(group ~ extra, data = sleep, family = binomial()))
{% endhighlight %}



{% highlight text %}
#> 
#> Call:
#> glm(formula = group ~ extra, family = binomial(), data = sleep)
#> 
#> Deviance Residuals: 
#>      Min        1Q    Median        3Q       Max  
#> -1.63347  -0.93197  -0.05824   1.11198   1.50310  
#> 
#> Coefficients:
#>             Estimate Std. Error z value Pr(>|z|)  
#> (Intercept)  -0.6928     0.6233  -1.112   0.2663  
#> extra         0.4652     0.2766   1.682   0.0926 .
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> (Dispersion parameter for binomial family taken to be 1)
#> 
#>     Null deviance: 27.726  on 19  degrees of freedom
#> Residual deviance: 24.290  on 18  degrees of freedom
#> AIC: 28.29
#> 
#> Number of Fisher Scoring iterations: 4
{% endhighlight %}



{% highlight r %}
tidy(glm(group ~ extra, data = sleep, family = binomial()))
{% endhighlight %}



{% highlight text %}
#>          term   estimate std.error statistic    p.value
#> 1 (Intercept) -0.6928304 0.6232561 -1.111630 0.26629715
#> 2       extra  0.4652017 0.2766064  1.681819 0.09260402
{% endhighlight %}

