---
layout: post
title: Principles of effective data visualization (using R)
details: Learn how to best plot your data (applicable to most other graphic software).
location: FG423
date: 2017-03-01
time: '13:00'
topic: data visualization
packages: '"ggplot2"'
video: "https://www.youtube.com/watch?v=DXWWCTFmaDQ"
notes: true
---

## Some basic principles

Taken from various sources (see resources below)

- Show the (raw) data (e.g. individual data points)
- Minimize 'ink' and maximize 'data'
- Keep the graph as simple as is appropriate
- Make graph as self-explanatory as possible
- Emphasize comparisons between values and groups (e.g. same unit)
- Use 'small multiples' graphs to show differences between groups
- Pay attention to the meaning of the colour scheme (e.g. see [ColorBrewer](http://colorbrewer2.org/))
    - And think of colour blind people!
- Focus on the story the data is telling

## Things to avoid:

- Avoid bar plots: they hide the real data and distort the reality of the data
    - (unless the data is proportions/percents)
- Avoid SEM as error bars: isn't a good measure of spread
    - (use SD or interquartile range instead) 
- Avoid pie charts: can easily unintentionally distort the data
    - (use bar charts with groups side by side)
- Avoid 3D charts: they visually distort the data 
    - (sometimes 3D is needed e.g. with geography)

## Resources

- [Intro Data Viz](http://paldhous.github.io/ucb/2016/dataviz/week2.html)
- [Edward Tufte, data visualization expert](https://www.edwardtufte.com/tufte/)
    - [Principles (PDF)](http://stat.pugetsound.edu/courses/class13/dataVisualization.pdf)
    
## Code


{% highlight r %}
fake_data <- data.frame(
    Group = as.factor(c(rep('Treatment', 10), rep('Control', 10))),
    Weight = c(rnorm(10, mean = 50, sd = 4), rnorm(10, mean = 60, sd = 5))
)

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
summary_fake <- fake_data %>% 
    group_by(Group) %>% 
    summarize(mean = mean(Weight),
              se = sqrt(var(Weight) / length(Weight)))

library(ggplot2)
p1 <- ggplot(fake_data, aes(y = Weight, x = Group)) +
    geom_boxplot()

p2 <- ggplot(fake_data, aes(y = Weight, x = Group)) +
    geom_jitter(width = 0.25)

p3 <- ggplot(summary_fake, aes(y = mean, x = Group)) +
    geom_bar(stat = 'identity', width = 0.5)
    
p4 <- ggplot(summary_fake, aes(y = mean, x = Group)) +
    geom_bar(stat = 'identity', width = 0.5) +
    geom_errorbar(aes(ymax = mean + se, ymin = mean - se), width = 0.25)

library(gridExtra)
{% endhighlight %}



{% highlight text %}
#> 
#> Attaching package: 'gridExtra'
{% endhighlight %}



{% highlight text %}
#> The following object is masked from 'package:dplyr':
#> 
#>     combine
{% endhighlight %}



{% highlight r %}
grid.arrange(p1, p2, p3, p4, ncol = 2)
{% endhighlight %}

![plot of chunk unnamed-chunk-1]({{ site.github.url }}/images/2017-03-01-Principles-Data-Visualization/unnamed-chunk-1-1.png)

{% highlight r %}
library(ggthemes)
ggplot(fake_data, aes(y = Weight, x = Group)) +
    geom_jitter(width = 0.25) +
    geom_errorbar(stat = 'summary', fun.y = 'mean', width = 0.6, 
                  aes(ymax = ..y.., ymin = ..y..)) +
    theme_tufte(base_family = 'sans')
{% endhighlight %}

![plot of chunk unnamed-chunk-1]({{ site.github.url }}/images/2017-03-01-Principles-Data-Visualization/unnamed-chunk-1-2.png)

{% highlight r %}
ggplot(iris, aes(y = Petal.Length, x = Petal.Width)) +
    geom_point() +
    facet_grid(~ Species, ) +
    theme_tufte(base_family = 'sans') +
    theme(panel.spacing = unit(2.5, 'lines'))
{% endhighlight %}

![plot of chunk unnamed-chunk-1]({{ site.github.url }}/images/2017-03-01-Principles-Data-Visualization/unnamed-chunk-1-3.png)

