---
title: Basic statistics and R commands
details: Learn about common R and statistic commands.
location: FG423
date: 2016-10-06
time: '13:00'
topic: basic stats and R
packages: '"broom"'
permalink: /404
---


{% highlight r %}
head(state.x77)
{% endhighlight %}



{% highlight text %}
#>            Population Income Illiteracy Life Exp Murder HS Grad Frost
#> Alabama          3615   3624        2.1    69.05   15.1    41.3    20
#> Alaska            365   6315        1.5    69.31   11.3    66.7   152
#> Arizona          2212   4530        1.8    70.55    7.8    58.1    15
#> Arkansas         2110   3378        1.9    70.66   10.1    39.9    65
#> California      21198   5114        1.1    71.71   10.3    62.6    20
#> Colorado         2541   4884        0.7    72.06    6.8    63.9   166
#>              Area
#> Alabama     50708
#> Alaska     566432
#> Arizona    113417
#> Arkansas    51945
#> California 156361
#> Colorado   103766
{% endhighlight %}



{% highlight r %}
str(state.x77)
{% endhighlight %}



{% highlight text %}
#>  num [1:50, 1:8] 3615 365 2212 2110 21198 ...
#>  - attr(*, "dimnames")=List of 2
#>   ..$ : chr [1:50] "Alabama" "Alaska" "Arizona" "Arkansas" ...
#>   ..$ : chr [1:8] "Population" "Income" "Illiteracy" "Life Exp" ...
{% endhighlight %}



{% highlight r %}
ds <- data.frame(state.x77)
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
var(ds$Life.Exp)
{% endhighlight %}



{% highlight text %}
#> [1] 1.80202
{% endhighlight %}



{% highlight r %}
cov(ds$Income, ds$HS.Grad)
{% endhighlight %}



{% highlight text %}
#> [1] 3076.769
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
library(broom)
tidy(t.test(ds$Population, ds$HS.Grad))
{% endhighlight %}



{% highlight text %}
#>   estimate estimate1 estimate2 statistic      p.value parameter conf.low
#> 1 4193.312   4246.42    53.108   6.64155 2.383442e-08  49.00032 2924.516
#>   conf.high                  method alternative
#> 1  5462.108 Welch Two Sample t-test   two.sided
{% endhighlight %}



{% highlight r %}
tidy(cor(state.x77))
{% endhighlight %}



{% highlight text %}
#>    .rownames  Population     Income  Illiteracy    Life.Exp     Murder
#> 1 Population  1.00000000  0.2082276  0.10762237 -0.06805195  0.3436428
#> 2     Income  0.20822756  1.0000000 -0.43707519  0.34025534 -0.2300776
#> 3 Illiteracy  0.10762237 -0.4370752  1.00000000 -0.58847793  0.7029752
#> 4   Life Exp -0.06805195  0.3402553 -0.58847793  1.00000000 -0.7808458
#> 5     Murder  0.34364275 -0.2300776  0.70297520 -0.78084575  1.0000000
#> 6    HS Grad -0.09848975  0.6199323 -0.65718861  0.58221620 -0.4879710
#> 7      Frost -0.33215245  0.2262822 -0.67194697  0.26206801 -0.5388834
#> 8       Area  0.02254384  0.3633154  0.07726113 -0.10733194  0.2283902
#>       HS.Grad      Frost        Area
#> 1 -0.09848975 -0.3321525  0.02254384
#> 2  0.61993232  0.2262822  0.36331544
#> 3 -0.65718861 -0.6719470  0.07726113
#> 4  0.58221620  0.2620680 -0.10733194
#> 5 -0.48797102 -0.5388834  0.22839021
#> 6  1.00000000  0.3667797  0.33354187
#> 7  0.36677970  1.0000000  0.05922910
#> 8  0.33354187  0.0592291  1.00000000
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



{% highlight r %}
ds2 <- iris
summary(aov(Sepal.Length ~ Species, data = ds2))
{% endhighlight %}



{% highlight text %}
#>              Df Sum Sq Mean Sq F value Pr(>F)    
#> Species       2  63.21  31.606   119.3 <2e-16 ***
#> Residuals   147  38.96   0.265                   
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
{% endhighlight %}



{% highlight r %}
tidy(aov(Sepal.Length ~ Species, data = ds2))
{% endhighlight %}



{% highlight text %}
#>        term  df    sumsq     meansq statistic      p.value
#> 1   Species   2 63.21213 31.6060667  119.2645 1.669669e-31
#> 2 Residuals 147 38.95620  0.2650082        NA           NA
{% endhighlight %}

