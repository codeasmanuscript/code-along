---
layout: post
title: Basic statistics and R commands
details: Learn about common R and statistic commands.
location: FG423
date: 2016-10-14
time: '13:00'
topic: basic stats and R
packages: '"broom"'
video: "https://www.youtube.com/watch?v=eZbMtHAUMXQ"
---

This is the code that we went over during the session.

Outline of statistics code we used:

- mean: mean
- sd: standard deviation
- median: median
- IQR: Interquartile range
- cor: correlation
- cor.test: correlation with p-value
- aov: ANOVA
- glm: linear regression

## Loading the data!

Import the data from the Code As Manuscript website to use in this session.


{% highlight r %}
ds <- read.csv("http://codeasmanuscript.org/states_data.csv")
names(ds)
{% endhighlight %}



{% highlight text %}
#>  [1] "StateName"  "Population" "Income"     "Illiteracy" "LifeExp"   
#>  [6] "Murder"     "HSGrad"     "Frost"      "Area"       "Region"    
#> [11] "Division"   "Longitude"  "Latitude"
{% endhighlight %}

## Simple descriptive statistics

The `$` tells R to take a column from the dataset. So `ds$Population` tells R to
take the Population column from the ds object.


{% highlight r %}
mean(ds$Population)
{% endhighlight %}



{% highlight text %}
#> [1] 4246.42
{% endhighlight %}



{% highlight r %}
sd(ds$Population)
{% endhighlight %}



{% highlight text %}
#> [1] 4464.491
{% endhighlight %}



{% highlight r %}
round(median(ds$LifeExp), 1)
{% endhighlight %}



{% highlight text %}
#> [1] 70.7
{% endhighlight %}



{% highlight r %}
IQR(ds$LifeExp)
{% endhighlight %}



{% highlight text %}
#> [1] 1.775
{% endhighlight %}

You can use R code inline too:

    The median of Life Expectancy in the States dataset is: 70.7

The median of Life Expectancy in the States dataset is: 70.7

You can put the results of the statistical output into an object called `Corr` (R is *case-sensitive*). And if we load the `broom` package, we can use the `tidy()` function 


{% highlight r %}
cor(ds$Population, ds$LifeExp)
{% endhighlight %}



{% highlight text %}
#> [1] -0.06805195
{% endhighlight %}



{% highlight r %}
Corr <- cor.test(ds$Population, ds$LifeExp)
library(broom)
Corr2 <- tidy(Corr)
{% endhighlight %}

Again, you can use inline R code to convert to text:

    The correlation is -0.068052 and it is not significant (p=0.6386594).

The correlation is -0.068052 and it is not significant (p=0.6386594).

Running an ANOVA uses a slightly different syntax: the `~` (tilde) is used in R
to indicate that it is a formula. So in this case, you are seeing the role of
`Division` (the X variable as a factor/discrete) on `Population` (the y variable
as a continuous variable).


{% highlight r %}
AOV <- aov(Population ~ Division, data = ds)
summary(AOV)
{% endhighlight %}



{% highlight text %}
#>             Df    Sum Sq  Mean Sq F value  Pr(>F)   
#> Division     8 422922254 52865282   3.914 0.00164 **
#> Residuals   41 553730250 13505616                   
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
{% endhighlight %}



{% highlight r %}
AOV2 <- tidy(AOV)
{% endhighlight %}

    There is a significant difference in Population between Divisions (p=0.0016447). The table is below:

There is a significant difference in Population between Divisions (p=0.0016447). The table is below:

You can put the ANOVA results into a table too!


{% highlight r %}
knitr::kable(AOV2)
{% endhighlight %}



|term      | df|     sumsq|   meansq| statistic|   p.value|
|:---------|--:|---------:|--------:|---------:|---------:|
|Division  |  8| 422922254| 52865282|  3.914318| 0.0016447|
|Residuals | 41| 553730250| 13505616|        NA|        NA|

Linear regression uses the same notation as ANOVA with the `~`. In this case, since this is a linear regression you need to use a Gaussian distribution, as `LifeExp` (the y variable) is continuous.


{% highlight r %}
fit <- glm(LifeExp ~ Income, data = ds, family = gaussian)
summary(fit)
{% endhighlight %}



{% highlight text %}
#> 
#> Call:
#> glm(formula = LifeExp ~ Income, family = gaussian, data = ds)
#> 
#> Deviance Residuals: 
#>      Min        1Q    Median        3Q       Max  
#> -2.96547  -0.76381  -0.03428   0.92876   2.32951  
#> 
#> Coefficients:
#>              Estimate Std. Error t value Pr(>|t|)    
#> (Intercept) 6.758e+01  1.328e+00  50.906   <2e-16 ***
#> Income      7.433e-04  2.965e-04   2.507   0.0156 *  
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> (Dispersion parameter for gaussian family taken to be 1.62659)
#> 
#>     Null deviance: 88.299  on 49  degrees of freedom
#> Residual deviance: 78.076  on 48  degrees of freedom
#> AIC: 170.18
#> 
#> Number of Fisher Scoring iterations: 2
{% endhighlight %}



{% highlight r %}
fit2 <- tidy(fit)
knitr::kable(fit2)
{% endhighlight %}



|term        |   estimate| std.error| statistic|   p.value|
|:-----------|----------:|---------:|---------:|---------:|
|(Intercept) | 67.5813178| 1.3275714|  50.90597| 0.0000000|
|Income      |  0.0007433| 0.0002965|   2.50694| 0.0156173|

You can use math formulas inside R Markdown files too:

    $$y = Xb + e$$
    
The regression formula is similar to the formula style in R with the `~`.
    
$$y = Xb + e$$
    
If you want to go through each step of how linear regression works, I wrote a 
[blog on understanding linear regression](http://blog.lukewjohnston.com/variance-linear-regression). Check it.

We can add covariates (confounders, etc) to the model, just like the math formula.

$$y = x1b + x2b + e$$

And in R:


{% highlight r %}
fit_covar <- glm(LifeExp ~ Income + Population, data = ds, family = gaussian)
summary(fit_covar)
{% endhighlight %}



{% highlight text %}
#> 
#> Call:
#> glm(formula = LifeExp ~ Income + Population, family = gaussian, 
#>     data = ds)
#> 
#> Deviance Residuals: 
#>     Min       1Q   Median       3Q      Max  
#> -3.2591  -0.8579  -0.0185   0.9485   2.2235  
#> 
#> Coefficients:
#>               Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  6.747e+01  1.330e+00  50.724   <2e-16 ***
#> Income       8.094e-04  3.029e-04   2.673   0.0103 *  
#> Population  -4.366e-05  4.168e-05  -1.047   0.3003    
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> (Dispersion parameter for gaussian family taken to be 1.623308)
#> 
#>     Null deviance: 88.299  on 49  degrees of freedom
#> Residual deviance: 76.295  on 47  degrees of freedom
#> AIC: 171.02
#> 
#> Number of Fisher Scoring iterations: 2
{% endhighlight %}



{% highlight r %}
fit_covar2 <- tidy(fit_covar)
knitr::kable(fit_covar2)
{% endhighlight %}



|term        |   estimate| std.error| statistic|   p.value|
|:-----------|----------:|---------:|---------:|---------:|
|(Intercept) | 67.4737218| 1.3302039| 50.724345| 0.0000000|
|Income      |  0.0008094| 0.0003028|  2.672564| 0.0103146|
|Population  | -0.0000437| 0.0000417| -1.047401| 0.3002713|

If you want to select just certain variables to display in a table, you can more easily do that using the package `dplyr`:


{% highlight r %}
library(dplyr)
{% endhighlight %}



{% highlight text %}
#> 
#> Attaching package: 'dplyr'
{% endhighlight %}



{% highlight text %}
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
{% endhighlight %}



{% highlight text %}
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
{% endhighlight %}



{% highlight r %}
fit_covar2 %>% 
    select(Variable = term, 
           Beta = estimate, 
           P = p.value) %>% 
    knitr::kable()
{% endhighlight %}



|Variable    |       Beta|         P|
|:-----------|----------:|---------:|
|(Intercept) | 67.4737218| 0.0000000|
|Income      |  0.0008094| 0.0103146|
|Population  | -0.0000437| 0.3002713|

