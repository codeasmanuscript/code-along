---
title: Linear regression in depth
details: A detailed look at the most common and powerful statistical technique.
location: FG423
date: 2017-04-12
time: '13:00'
topic: linear regression
notes: true
video: "https://www.youtube.com/watch?v=R3cMEEehj_Y"
---

Much of this I wrote about in a [blog post](http://blog.lukewjohnston.com/variance-linear-regression/)
when I wanted to get a better understanding of linear regression. Check out the 
[video](https://www.youtube.com/watch?v=R3cMEEehj_Y) to hear more on it.

So, the simple formula for linear regression is:

$$ Y = \alpha + X\beta + \varepsilon $$

Written another way, with common alphabetic letters is:

$$ y = m + Xb + e $$

In the case of multiple linear regression, it is expanded to:

$$ y = m + x_1b_1 + x_2b_b +...+ x_nb_n + e $$

In R, this is done using `lm`. First, lets get a dataset and see the contents of it.


{% highlight r %}
ds <- as.data.frame(state.x77)
names(ds)
{% endhighlight %}



{% highlight text %}
#> [1] "Population" "Income"     "Illiteracy" "Life Exp"   "Murder"    
#> [6] "HS Grad"    "Frost"      "Area"
{% endhighlight %}

Here, we run the linear regression and see the results.


{% highlight r %}
fit1 <- lm(Murder ~ Income, data = ds)
summary(fit1)
{% endhighlight %}



{% highlight text %}
#> 
#> Call:
#> lm(formula = Murder ~ Income, data = ds)
#> 
#> Residuals:
#>     Min      1Q  Median      3Q     Max 
#> -6.0495 -2.8033 -0.2727  3.0730  6.5999 
#> 
#> Coefficients:
#>               Estimate Std. Error t value Pr(>|t|)    
#> (Intercept) 13.5093092  3.7782753   3.576  0.00081 ***
#> Income      -0.0013822  0.0008439  -1.638  0.10797    
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 3.63 on 48 degrees of freedom
#> Multiple R-squared:  0.05294,	Adjusted R-squared:  0.03321 
#> F-statistic: 2.683 on 1 and 48 DF,  p-value: 0.108
{% endhighlight %}

If we convert this into the equation, it is:

$$ Murder = Intercept + (Income \times Beta) $$
Let's substitute in the numbers:

$$ Murder = 13.5 + (Income \times 0.0013) $$

The above is for a simple, two variable linear regression. What about if we have 
multiple predictor ($x$) variables? We do:


{% highlight r %}
fit2 <- lm(Murder ~ Income + Population, data = ds)
summary(fit2)
{% endhighlight %}



{% highlight text %}
#> 
#> Call:
#> lm(formula = Murder ~ Income + Population, data = ds)
#> 
#> Residuals:
#>     Min      1Q  Median      3Q     Max 
#> -5.0041 -2.1438 -0.4352  2.2270  8.7953 
#> 
#> Coefficients:
#>               Estimate Std. Error t value Pr(>|t|)    
#> (Intercept) 14.3433789  3.4906599   4.109 0.000158 ***
#> Income      -0.0018943  0.0007947  -2.384 0.021240 *  
#> Population   0.0003384  0.0001094   3.094 0.003320 ** 
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 3.343 on 47 degrees of freedom
#> Multiple R-squared:  0.2132,	Adjusted R-squared:  0.1797 
#> F-statistic: 6.368 on 2 and 47 DF,  p-value: 0.003572
{% endhighlight %}

Converted to the formula:

$$ Murder = 14.34 + (Income \times -0.0189) + (Population \times 0.0003384) $$

Nearly all statistical techniques (at least the basic/common ones) can be
considered a special case of linear regression. Let's take ANOVA as an example.
ANOVA is where the $y$ is a continuous variable and the $x$ is a discrete
variable (usually with at least three categories). In my opinion, using linear
regression is more useful from a scientific and interpretation perspective than
using ANOVA. Here's how you do it:


{% highlight r %}
fit3 <- lm(Petal.Length ~ Species, data = iris)
# To see the different categories of Species
summary(iris$Species)
{% endhighlight %}



{% highlight text %}
#>     setosa versicolor  virginica 
#>         50         50         50
{% endhighlight %}


{% highlight r %}
summary(fit3)
{% endhighlight %}



{% highlight text %}
#> 
#> Call:
#> lm(formula = Petal.Length ~ Species, data = iris)
#> 
#> Residuals:
#>    Min     1Q Median     3Q    Max 
#> -1.260 -0.258  0.038  0.240  1.348 
#> 
#> Coefficients:
#>                   Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)        1.46200    0.06086   24.02   <2e-16 ***
#> Speciesversicolor  2.79800    0.08607   32.51   <2e-16 ***
#> Speciesvirginica   4.09000    0.08607   47.52   <2e-16 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 0.4303 on 147 degrees of freedom
#> Multiple R-squared:  0.9414,	Adjusted R-squared:  0.9406 
#> F-statistic:  1180 on 2 and 147 DF,  p-value: < 2.2e-16
{% endhighlight %}

Converted to an equation. Setosa isn't here because it is considered the
'intercept' since if you set Versicolor and Virginica to zero, the remaining
'category' is Setosa. These are known as dummy variables.

$$ Petal.Length = 1.46 + (Versicolor \times 2.79) + (Virginica \times 4.09) $$

The estimates from the linear regression as the same as the means of each group
(each estimate + the intercept). 


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
iris %>%
    group_by(Species) %>% 
    summarize(means = mean(Petal.Length))
{% endhighlight %}



{% highlight text %}
#> # A tibble: 3 × 2
#>      Species means
#>       <fctr> <dbl>
#> 1     setosa 1.462
#> 2 versicolor 4.260
#> 3  virginica 5.552
{% endhighlight %}

Linear regression and correlation are also tightly linked, and are the same if
the variables have been scaled (mean-centered and standardized).


{% highlight r %}
ds <- iris %>%
    mutate_each(funs(scale), Petal.Length, Sepal.Length)
summary(ds)
{% endhighlight %}



{% highlight text %}
#>    Sepal.Length.V1     Sepal.Width      Petal.Length.V1     Petal.Width   
#>  Min.   :-1.8637803   Min.   :2.000   Min.   :-1.5623422   Min.   :0.100  
#>  1st Qu.:-0.8976739   1st Qu.:2.800   1st Qu.:-1.2224563   1st Qu.:0.300  
#>  Median :-0.0523308   Median :3.000   Median : 0.3353541   Median :1.300  
#>  Mean   : 0.0000000   Mean   :3.057   Mean   : 0.0000000   Mean   :1.199  
#>  3rd Qu.: 0.6722490   3rd Qu.:3.300   3rd Qu.: 0.7602115   3rd Qu.:1.800  
#>  Max.   : 2.4836986   Max.   :4.400   Max.   : 1.7798692   Max.   :2.500  
#>        Species  
#>  setosa    :50  
#>  versicolor:50  
#>  virginica :50  
#>                 
#>                 
#> 
{% endhighlight %}


{% highlight r %}
cor(ds$Petal.Length, ds$Sepal.Length)
{% endhighlight %}



{% highlight text %}
#>           [,1]
#> [1,] 0.8717538
{% endhighlight %}


{% highlight r %}
summary(lm(Petal.Length ~ Sepal.Length, data = ds))
{% endhighlight %}



{% highlight text %}
#> 
#> Call:
#> lm(formula = Petal.Length ~ Sepal.Length, data = ds)
#> 
#> Residuals:
#>      Min       1Q   Median       3Q      Max 
#> -1.40343 -0.33463 -0.00379  0.34263  1.41343 
#> 
#> Coefficients:
#>               Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  4.644e-16  4.014e-02    0.00        1    
#> Sepal.Length 8.718e-01  4.027e-02   21.65   <2e-16 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 0.4916 on 148 degrees of freedom
#> Multiple R-squared:   0.76,	Adjusted R-squared:  0.7583 
#> F-statistic: 468.6 on 1 and 148 DF,  p-value: < 2.2e-16
{% endhighlight %}
