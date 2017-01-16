---
layout: post
title: Principles of managing and analyzing data
details: Learn the principles of managing data from storing to analyzing. No coding this session.
location: FG423
date: 2017-01-11
time: '13:00'
topic: data management
permalink: /404
---

In R, as in most statistical and programming languages, how your data is
structured and stored impacts how or whether you can do your analysis. The best
form for a dataset is in a tidy format. Tidy datasets are where each column
contains a variable measurements and each row contains a single observation at a
specific time. So, if you work with animals, each row would be the animal. For
cells, each row would be the cell plate/dish. For humans, each row would be an
individual. If you collect multiple time points on the animals/humans, they
would take up a new row for each measurement time.

This tidy format for the data makes it easier to analyze the dataset and to plot
it. It also makes it very easy to import into R. The best time to start using
this format for storing your data is right away! But, sometimes your data is
created by a machine or from the measurement instrument. In those cases, you'll
have to wrangle ('manipulate') the data into the appropriate tidy format before
analyzing it.

## Code used

Quick note: If you want to know more about a command (aka. function), use `?`. 
For instance, use `?install.packages` to learn more about the
`install.packages()` function.




{% highlight r %}
# install the package if you haven't already
# install.packages('readr')
# Load the readr package
library(readr)
{% endhighlight %}

We'll be using `read_csv()` from the `readr` package, which is similar to the
`read.csv()` function in base R but is slower and does more things that you
usually don't want. We can use `read_csv()` to also get a csv file, which is a
comma separated value file, from the internet. To get a better look at the csv
file, we can save it to a file by using `write_csv()`. The two datasets below
are fake datasets I made up.


{% highlight r %}
# This is an example of a messy dataset
web_link <- "http://codeasmanuscript.github.io/code-along/data/tidy-data-1.csv"
tidy_data <- read_csv(web_link)
{% endhighlight %}



{% highlight text %}
#> Warning: Missing column names filled in: 'X1' [1], 'X3' [3], 'X4' [4],
#> 'X5' [5], 'X6' [6], 'X7' [7], 'X9' [9], 'X10' [10], 'X11' [11], 'X12' [12],
#> 'X13' [13]
{% endhighlight %}



{% highlight text %}
#> Parsed with column specification:
#> cols(
#>   X1 = col_character(),
#>   Exercise = col_integer(),
#>   X3 = col_integer(),
#>   X4 = col_integer(),
#>   X5 = col_integer(),
#>   X6 = col_integer(),
#>   X7 = col_integer(),
#>   Control = col_integer(),
#>   X9 = col_integer(),
#>   X10 = col_integer(),
#>   X11 = col_integer(),
#>   X12 = col_integer(),
#>   X13 = col_integer()
#> )
{% endhighlight %}



{% highlight r %}
# Save it into the data/ folder using write_csv
#write_csv(tidy_data, 'data/tidy-data-1.csv')

# Assign the tidy-data into the object ds using <-
# Import directly from a file:
ds <- read_csv('data/tidy-data-1.csv')
{% endhighlight %}



{% highlight text %}
#> Warning: Missing column names filled in: 'X1' [1], 'X3' [3], 'X4' [4],
#> 'X5' [5], 'X6' [6], 'X7' [7], 'X9' [9], 'X10' [10], 'X11' [11], 'X12' [12],
#> 'X13' [13]
{% endhighlight %}



{% highlight text %}
#> Parsed with column specification:
#> cols(
#>   X1 = col_character(),
#>   Exercise = col_integer(),
#>   X3 = col_integer(),
#>   X4 = col_integer(),
#>   X5 = col_integer(),
#>   X6 = col_integer(),
#>   X7 = col_integer(),
#>   Control = col_integer(),
#>   X9 = col_integer(),
#>   X10 = col_integer(),
#>   X11 = col_integer(),
#>   X12 = col_integer(),
#>   X13 = col_integer()
#> )
{% endhighlight %}



{% highlight r %}
# Let's take a peek at this file too.
web_link2 <- "http://codeasmanuscript.github.io/code-along/data/tidy-data-2.csv"
read_csv(web_link2)
{% endhighlight %}



{% highlight text %}
#> Parsed with column specification:
#> cols(
#>   ID_case = col_integer(),
#>   weight_case = col_integer(),
#>   testosterone_case = col_integer(),
#>   ID_control = col_integer(),
#>   weight_control = col_integer(),
#>   testosterone_control = col_integer()
#> )
{% endhighlight %}



{% highlight text %}
#> # A tibble: 3 × 6
#>   ID_case weight_case testosterone_case ID_control weight_control
#>     <int>       <int>             <int>      <int>          <int>
#> 1    1241         110                34       2144            200
#> 2    1456         150                56       2315            140
#> 3    2679         165                43       3245            160
#> # ... with 1 more variables: testosterone_control <int>
{% endhighlight %}

If you have a dataset that is tab separated, you can use `read_tsv()`. Since
this is a tab separated (or just plain text, txt, file), we need to save it to
the computer using `writeLines()`.


{% highlight r %}
read_tsv("http://codeasmanuscript.github.io/code-along/data/tidy-data-3.txt")
{% endhighlight %}



{% highlight text %}
#> Parsed with column specification:
#> cols(
#>   `##BLOCKS= 1` = col_character()
#> )
{% endhighlight %}



{% highlight text %}
#> Warning: 11 parsing failures.
#> row col  expected     actual
#>   1  -- 1 columns 23 columns
#>   2  -- 1 columns 16 columns
#>   3  -- 1 columns 16 columns
#>   4  -- 1 columns 16 columns
#>   5  -- 1 columns 16 columns
#> ... ... ......... ..........
#> See problems(...) for more details.
{% endhighlight %}



{% highlight text %}
#> # A tibble: 12 × 1
#>    `##BLOCKS= 1`
#>            <chr>
#> 1         Plate:
#> 2           <NA>
#> 3           <NA>
#> 4           <NA>
#> 5           <NA>
#> 6           <NA>
#> 7           <NA>
#> 8           <NA>
#> 9           <NA>
#> 10          <NA>
#> 11          <NA>
#> 12          ~End
{% endhighlight %}



{% highlight r %}
# Save it using:
# writeLines(
#     read_lines("http://codeasmanuscript.github.io/code-along/data/tidy-data-3.txt"), 
#     'data/tidy-data-3.txt')
{% endhighlight %}

These next two datasets are data Zhila in our lab collected for PROMISE, which is
the completely raw data file sent out from the machine she was using for measurements.
You can see when you open the `tidy-data-3.txt` file that there is a bunch of
stuff you probably don't need. So, tell R to not include these stuff when importing.
Each arguments (options) in the `read_tsv()` function is explained below:

- `comment` argument says that anything starting with `#` can be ignored
- `skip` says to skip the first line when importing
- `n_max` says to only import 8 lines *after* the header line (i.e. the column
names)
- `[-1:-2]` is called indexing (see `?'['`) and says to *exclude* (minus) the
first two columns
- `[c(-13, -14)]` (or `[-13:-14]`) takes the previous index results and says to
*exclude* columns 13 and 14


{% highlight r %}
ds <- read_tsv("http://codeasmanuscript.github.io/code-along/data/tidy-data-3.txt",
               comment = '#', skip = 1, n_max = 8)[-1:-2][c(-13, -14)]
{% endhighlight %}



{% highlight text %}
#> Warning: Missing column names filled in: 'X1' [1], 'X15' [15], 'X16' [16]
{% endhighlight %}



{% highlight text %}
#> Error in make.names(x): invalid multibyte string 1
{% endhighlight %}



{% highlight r %}
# This adds a column called PlateRow to the ds object
ds$PlateRow <- 1:8
{% endhighlight %}



{% highlight text %}
#> Error in `$<-.data.frame`(`*tmp*`, "PlateRow", value = 1:8): replacement has 8 rows, data has 3
{% endhighlight %}



{% highlight r %}
ds
{% endhighlight %}



{% highlight text %}
#> # A tibble: 3 × 13
#>      X1 Exercise    X3    X4    X5    X6    X7 Control    X9   X10   X11
#>   <chr>    <int> <int> <int> <int> <int> <int>   <int> <int> <int> <int>
#> 1 DietA       34   132    54    65    33    NA      31    12   124    45
#> 2 DietB      111    24    38    12    NA    NA      23     8    23   213
#> 3 DietC       43   150   123    43   500   321     425    23   235   534
#> # ... with 2 more variables: X12 <int>, X13 <int>
{% endhighlight %}

In this case, to get a tidy dataset, we'll need to re-arrange the dataset using
another package.


{% highlight r %}
#install.packages('tidyr')
library(tidyr)
# gather takes a wide dataset can converts it to a long dataset. In this case
# I don't want PlateRow to be converted, just all other columns.
ds2 <- gather(ds, PlateColumn, Wavelength, -PlateRow)
{% endhighlight %}



{% highlight text %}
#> Error in eval(expr, envir, enclos): object 'PlateRow' not found
{% endhighlight %}



{% highlight r %}
ds2
{% endhighlight %}



{% highlight text %}
#> Error in eval(expr, envir, enclos): object 'ds2' not found
{% endhighlight %}

And lastly, to look at this next dataset:


{% highlight r %}
# Save it using:
# writeLines(
#     read_lines("http://codeasmanuscript.github.io/code-along/data/tidy-data-4.csv"), 
#     'data/tidy-data-4.csv')

# [1:20, ] means to keep only the first 20 *rows*, in which a comma must follow
read_csv("http://codeasmanuscript.github.io/code-along/data/tidy-data-4.csv",
         skip = 22)[1:20, ]
{% endhighlight %}



{% highlight text %}
#> Parsed with column specification:
#> cols(
#>   `Plate Name` = col_character(),
#>   Sample = col_character(),
#>   Assay = col_character(),
#>   Well = col_character(),
#>   Spot = col_integer(),
#>   Dilution = col_integer(),
#>   Concentration = col_double(),
#>   Signal = col_integer(),
#>   `Adjusted Signal` = col_integer(),
#>   Mean = col_integer(),
#>   `Adj. Sig. Mean` = col_double(),
#>   CV = col_double(),
#>   `% Recovery` = col_double(),
#>   `% Recovery Mean` = col_double(),
#>   `Calc. Concentration` = col_double(),
#>   `Calc. Conc. Mean` = col_double(),
#>   `Calc. Conc. CV` = col_double()
#> )
{% endhighlight %}



{% highlight text %}
#> # A tibble: 20 × 17
#>        `Plate Name` Sample       Assay  Well  Spot Dilution Concentration
#>               <chr>  <chr>       <chr> <chr> <int>    <int>         <dbl>
#> 1  Plate_25E5MAPB94   S001 Adiponectin   A01     1       NA      1.28e-02
#> 2  Plate_25E5MAPB94   S001 Adiponectin   A02     1       NA      1.28e-02
#> 3  Plate_25E5MAPB94   S002 Adiponectin   B02     1       NA      6.40e-02
#> 4  Plate_25E5MAPB94   S002 Adiponectin   B01     1       NA      6.40e-02
#> 5  Plate_25E5MAPB94   S003 Adiponectin   C02     1       NA      3.20e-01
#> 6  Plate_25E5MAPB94   S003 Adiponectin   C01     1       NA      3.20e-01
#> 7  Plate_25E5MAPB94   S004 Adiponectin   D01     1       NA      1.60e+00
#> 8  Plate_25E5MAPB94   S004 Adiponectin   D02     1       NA      1.60e+00
#> 9  Plate_25E5MAPB94   S005 Adiponectin   E02     1       NA      8.00e+00
#> 10 Plate_25E5MAPB94   S005 Adiponectin   E01     1       NA      8.00e+00
#> 11 Plate_25E5MAPB94   S006 Adiponectin   F01     1       NA      4.00e+01
#> 12 Plate_25E5MAPB94   S006 Adiponectin   F02     1       NA      4.00e+01
#> 13 Plate_25E5MAPB94   S007 Adiponectin   G01     1       NA      2.00e+02
#> 14 Plate_25E5MAPB94   S007 Adiponectin   G02     1       NA      2.00e+02
#> 15 Plate_25E5MAPB94   S008 Adiponectin   H02     1       NA      1.00e+03
#> 16 Plate_25E5MAPB94   S008 Adiponectin   H01     1       NA      1.00e+03
#> 17 Plate_25E5MAPB94   U001 Adiponectin   A03     1        1            NA
#> 18 Plate_25E5MAPB94   U001 Adiponectin   A04     1        1            NA
#> 19 Plate_25E5MAPB94   U002 Adiponectin   A05     1        1            NA
#> 20 Plate_25E5MAPB94   U002 Adiponectin   A06     1        1            NA
#> # ... with 10 more variables: Signal <int>, `Adjusted Signal` <int>,
#> #   Mean <int>, `Adj. Sig. Mean` <dbl>, CV <dbl>, `% Recovery` <dbl>, `%
#> #   Recovery Mean` <dbl>, `Calc. Concentration` <dbl>, `Calc. Conc.
#> #   Mean` <dbl>, `Calc. Conc. CV` <dbl>
{% endhighlight %}

# Resources

- [Tidy data paper](https://www.jstatsoft.org/index.php/jss/article/view/v059i10/v59i10.pdf)
- [A code heavier version of the Tidy Data paper](https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html)
- [`readr` documentation](https://github.com/hadley/readr/blob/master/README.md)
- [Cheatsheat on aspects of working with data (including tidy data)](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)


## Outline:

- show examples of tidy data piped into analyzed data
- use package `data.tree` to make example folder structure.
    - see also http://stackoverflow.com/questions/36094183/how-to-build-a-dendrogram-from-a-directory-tree
