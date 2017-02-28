---
layout: post
title: Process your raw data into useable data in R
details: Learn to use R programming to convert your raw data into analyzable data.
location: FG423
date: 2017-02-15
time: '13:00'
topic: data processing
packages: '"readr"'
video: "https://www.youtube.com/watch?v=bwUlFEifP38&list=UUCGj40G8pajVVu4jE14su3Q&index=1"
notes: true
---

## Notes from session:

Assumption about the data:

- The raw data is in a plain text format (.txt, .csv, .tsv) meaning it does not
need special software to open (i.e. .xls, .xlsx, etc).

First let's load up the package we'll use to actually import the data into R.


{% highlight r %}
library(readr)
{% endhighlight %}

Next we use `read_lines` to import just the lines (not as a dataset) into R to
look at it. Then we use `read_csv` to import the data as a dataframe. `skip=22`
means skip the first 22 lines.


{% highlight r %}
head(read_lines("https://codeasmanuscript.github.io/code-along/data/tidy-data-4.csv"))
{% endhighlight %}



{% highlight text %}
#> [1] "Name,Value,,,,,,,,,,,,,,,"                           
#> [2] "User,Administrator,,,,,,,,,,,,,,,"                   
#> [3] "Creation Time,01/20/2016 13:39:14 EST,,,,,,,,,,,,,,,"
#> [4] "Read Time,01/20/2016 13:40:36 EST,,,,,,,,,,,,,,,"    
#> [5] "Layout,Standard,,,,,,,,,,,,,,,"                      
#> [6] "Type,96 Multi-Spot 4,,,,,,,,,,,,,,,"
{% endhighlight %}



{% highlight r %}
d4_1 <- read_csv("https://codeasmanuscript.github.io/code-along/data/tidy-data-4.csv",
         skip = 22)
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



{% highlight r %}
head(d4_1)
{% endhighlight %}



{% highlight text %}
#> # A tibble: 6 × 17
#>       `Plate Name` Sample       Assay  Well  Spot Dilution Concentration
#>              <chr>  <chr>       <chr> <chr> <int>    <int>         <dbl>
#> 1 Plate_25E5MAPB94   S001 Adiponectin   A01     1       NA        0.0128
#> 2 Plate_25E5MAPB94   S001 Adiponectin   A02     1       NA        0.0128
#> 3 Plate_25E5MAPB94   S002 Adiponectin   B02     1       NA        0.0640
#> 4 Plate_25E5MAPB94   S002 Adiponectin   B01     1       NA        0.0640
#> 5 Plate_25E5MAPB94   S003 Adiponectin   C02     1       NA        0.3200
#> 6 Plate_25E5MAPB94   S003 Adiponectin   C01     1       NA        0.3200
#> # ... with 10 more variables: Signal <int>, `Adjusted Signal` <int>,
#> #   Mean <int>, `Adj. Sig. Mean` <dbl>, CV <dbl>, `% Recovery` <dbl>, `%
#> #   Recovery Mean` <dbl>, `Calc. Concentration` <dbl>, `Calc. Conc.
#> #   Mean` <dbl>, `Calc. Conc. CV` <dbl>
{% endhighlight %}

We can load the dplyr package to continue cleaning/processing the data.


{% highlight r %}
library(dplyr)
d4_2 <- select(d4_1, Sample, Assay,
       CalcConcMean = `Calc. Conc. Mean`)
head(d4_2)
{% endhighlight %}



{% highlight text %}
#> # A tibble: 6 × 3
#>   Sample       Assay CalcConcMean
#>    <chr>       <chr>        <dbl>
#> 1   S001 Adiponectin   0.01276879
#> 2   S001 Adiponectin   0.01276879
#> 3   S002 Adiponectin   0.06626848
#> 4   S002 Adiponectin   0.06626848
#> 5   S003 Adiponectin   0.31419062
#> 6   S003 Adiponectin   0.31419062
{% endhighlight %}

Now we have just the data we need to continue with the later analysis!

Let's do a slightly more complicated raw dataset. Looks ugly right?


{% highlight r %}
d3_1 <- read_lines("https://codeasmanuscript.github.io/code-along/data/tidy-data-3.txt")
head(d3_1)
{% endhighlight %}



{% highlight text %}
#> [1] "##BLOCKS= 1          "                                                                                            
#> [2] "Plate:\tPlate#1\t1.3\tPlateFormat\tEndpoint\tAbsorbance\tRaw\tFALSE\t1\t\t\t\t\t\t1\t450\t1\t12\t96\t1\t8\tNone\t"
#> [3] "\tTemperature(\xa1C)\t1\t2\t3\t4\t5\t6\t7\t8\t9\t10\t11\t12\t\t"                                                     
#> [4] "\t27.60\t0.0602\t0.0614\t1.9891\t2.1723\t2.5887\t2.8214\t1.2459\t1.448\t2.9775\t3.1386\t1.4335\t1.853\t\t"        
#> [5] "\t\t0.0598\t0.0649\t1.8082\t1.7893\t2.3488\t2.3806\t1.1902\t1.2293\t3.0736\t3.3023\t1.4445\t1.8378\t\t"           
#> [6] "\t\t0.0913\t0.0851\t1.8503\t1.8329\t1.6559\t1.6604\t2.2684\t2.4955\t1.5287\t1.4449\t1.6892\t1.696\t\t"
{% endhighlight %}



{% highlight r %}
# write_lines saves the dataset as a file. This lets you look at the data more
# closely, and in a less ugly format.
# write_lines(d3_1, 'tidy-data-3.txt')
{% endhighlight %}

We only want the data in the rectangular format, the values arranged in the 8 by
12 rows and columns. Since we don't want the first 3 rows (`skip`), only want 8
rows (`n_max`), and we want to drop the first 2 and last two columns
(`col_names` with a `D` in front), we include these options when importing the
data.


{% highlight r %}
d3_2 <-
    read_tsv(
        "https://codeasmanuscript.github.io/code-along/data/tidy-data-3.txt",
        skip = 3,
        n_max = 8,
        col_names = c('D1', 'D2', paste0('X', 1:12), 'D3', 'D4')
    )
{% endhighlight %}



{% highlight text %}
#> Parsed with column specification:
#> cols(
#>   D1 = col_character(),
#>   D2 = col_double(),
#>   X1 = col_double(),
#>   X2 = col_double(),
#>   X3 = col_double(),
#>   X4 = col_double(),
#>   X5 = col_double(),
#>   X6 = col_double(),
#>   X7 = col_double(),
#>   X8 = col_double(),
#>   X9 = col_double(),
#>   X10 = col_double(),
#>   X11 = col_double(),
#>   X12 = col_double(),
#>   D3 = col_character(),
#>   D4 = col_character()
#> )
{% endhighlight %}



{% highlight r %}
head(d3_2)
{% endhighlight %}



{% highlight text %}
#> # A tibble: 6 × 16
#>      D1    D2     X1     X2     X3     X4     X5     X6     X7     X8
#>   <chr> <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>
#> 1  <NA>  27.6 0.0602 0.0614 1.9891 2.1723 2.5887 2.8214 1.2459 1.4480
#> 2  <NA>    NA 0.0598 0.0649 1.8082 1.7893 2.3488 2.3806 1.1902 1.2293
#> 3  <NA>    NA 0.0913 0.0851 1.8503 1.8329 1.6559 1.6604 2.2684 2.4955
#> 4  <NA>    NA 0.0979 0.0964 1.7215 1.6750 1.2098 1.1608 1.6460 1.5933
#> 5  <NA>    NA 0.1408 0.1447 2.5481 2.5791 2.8296 3.0958 1.9730 2.3451
#> 6  <NA>    NA 0.3730 0.3336 2.1894 2.3848 2.4301 2.6690 2.1148 2.4622
#> # ... with 6 more variables: X9 <dbl>, X10 <dbl>, X11 <dbl>, X12 <dbl>,
#> #   D3 <chr>, D4 <chr>
{% endhighlight %}

Let's extract only the 3rd to 14th columns (using `[3:14]`), dropping the first
two and last two columns.


{% highlight r %}
d3_3 <- d3_2[3:14]
head(d3_3)
{% endhighlight %}



{% highlight text %}
#> # A tibble: 6 × 12
#>       X1     X2     X3     X4     X5     X6     X7     X8     X9    X10
#>    <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>
#> 1 0.0602 0.0614 1.9891 2.1723 2.5887 2.8214 1.2459 1.4480 2.9775 3.1386
#> 2 0.0598 0.0649 1.8082 1.7893 2.3488 2.3806 1.1902 1.2293 3.0736 3.3023
#> 3 0.0913 0.0851 1.8503 1.8329 1.6559 1.6604 2.2684 2.4955 1.5287 1.4449
#> 4 0.0979 0.0964 1.7215 1.6750 1.2098 1.1608 1.6460 1.5933 1.5394 1.6764
#> 5 0.1408 0.1447 2.5481 2.5791 2.8296 3.0958 1.9730 2.3451 1.5426 1.5113
#> 6 0.3730 0.3336 2.1894 2.3848 2.4301 2.6690 2.1148 2.4622 2.2446 2.6634
#> # ... with 2 more variables: X11 <dbl>, X12 <dbl>
{% endhighlight %}

This is still in a rather messy format. Let's use the tidyr package to continue
cleaning. The `%>%` pipe is like an actual pipe... it takes the data from
`d3_3`, puts it into the `mutate` command, which continues into the `gather`
command. `mutate` creates a new column, while `gather` converts from wide to
long format.


{% highlight r %}
library(tidyr)

d3_4 <- d3_3 %>%
    mutate(PlateRow = LETTERS[1:8]) %>%
    gather(PlateColumn, Signal, -PlateRow)
head(d3_4)
{% endhighlight %}



{% highlight text %}
#> # A tibble: 6 × 3
#>   PlateRow PlateColumn Signal
#>      <chr>       <chr>  <dbl>
#> 1        A          X1 0.0602
#> 2        B          X1 0.0598
#> 3        C          X1 0.0913
#> 4        D          X1 0.0979
#> 5        E          X1 0.1408
#> 6        F          X1 0.3730
{% endhighlight %}

The power of using code instead of manual becomes more obvious when you have to
do this same steps for many other files. We'll do an example. Try the code on
your own to see how it works!


{% highlight r %}
write_lines(d3_1, 'tidy-data-01.tsv')
write_lines(d3_1, 'tidy-data-02.tsv')
write_lines(d3_1, 'tidy-data-03.tsv')

data_files <- list.files(pattern = '*.tsv')

import_tsv_file <- function(filename) {
    data <- read_tsv(
        filename,
        skip = 3,
        n_max = 8,
        col_names = c('D1', 'D2', paste0('X', 1:12), 'D3', 'D4')
    )

    data <- data[3:14]

    data <- data %>%
        mutate(PlateRow = LETTERS[1:8]) %>%
        gather(PlateColumn, Signal, -PlateRow) %>%
        mutate(MachineRun = substr(filename,
                                   nchar(filename) - 5,
                                   nchar(filename) - 4))

    return(data)
}

data_combined <- lapply(data_files, import_tsv_file) %>%
    bind_rows()

data_combined
{% endhighlight %}
