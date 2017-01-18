---
layout: post
title: Principles of managing and analyzing data
details: Learn the principles of managing data from storing to analyzing. No coding this session.
location: FG423
date: 2017-01-18
time: '13:00'
topic: data management
output: slidy_presentation
video: "https://www.youtube.com/watch?v=P6fzSXVUmRc"
---

# Main points

1. Have a plan and structure in place *before* you start collecting the data!
2. Keep raw data *raw and untouched*
3. Use plain text/open source file formats (csv, txt)
4. Use version control
5. Use scripts* to process/clean your data
6. Avoid spreadsheets
7. Keep data 'tidy'
8. Have a single folder to store the master copy of the data
9. Have a data dictionary/metadata
10. Put your data online (or at least pretend you will eventually)

# The foundation: folders and files!

- Look into a Data Management Plan (DMP) before collecting data
- Use a consistent file and folder naming system and date format (use the
international standard! ISO 8601, YYYY-MM-DD). 

## Example:





{% highlight text %}
                               levelName
1 project-name                          
2  °--data-raw                          
3      ¦--protein-measure-2017-01-17.txt
4      ¦--protein-measure-2017-01-18.txt
5      ¦--protein-measure-2017-01-19.txt
6      ¦--anthropometrics.csv           
7      °--blood-measures.csv            
{% endhighlight %}

# Data entry

- Use rules for data entry to prevent data entry errors
    - Maybe have two people do data entry to cross-check?
    - Use tools such as Google Forms to force proper data type (only numbers,
    only less than 10, etc)
- Use 'flat' files as often as you can (csv, spreadsheet-style)
    - Has only rows and columns, 2-dimensional
    - First row is the column/variable names
    - Variable names informative and CamelCase (e.g. FatIntake)
- Avoid spreadsheets as much as you can since they often (wrongly) try to guess
what the user wants (e.g. change date formats on you)
- Use international standard for dates (YYYY-MM-DD)
    
# Storing the data

- Keep the raw data *completely* raw and untouched
    - Prevents accidental deletion
- Look into the FAIR concept (Findable, **Accessible**, **Interoperable**, Re-useable)
- Use plain text or open source file formats (txt, csv, sqlite)
    - *NOT* xls, xlsx, Access database, etc (these are not FAIR since they
    depend on purchased software)
    - Allows re-use in future, inter-platform (Mac, Windows, Linux), software
    independent (don't need Word, etc)
- **Strongly recommended**: Keep under version control
([Git](https://git-scm.com/), or use backups frequently)
- (optional) Have a single 'master' data file, then a copy in your folder for
your manuscript, etc.

# Version control

- Form of managing changes to your files and data
- Git is the most popular and has the most documentation for using it
- Prevents accidental deletion of values in the data or of files
- (this is a whole topic on it's own)


{% highlight text %}
                               levelName
1 project-name                          
2  ¦--data-raw                          
3  ¦   ¦--protein-measure-2017-01-17.txt
4  ¦   ¦--protein-measure-2017-01-18.txt
5  ¦   ¦--protein-measure-2017-01-19.txt
6  ¦   ¦--anthropometrics.csv           
7  ¦   °--blood-measures.csv            
8  °--.git                              
{% endhighlight %}

# Use scripts (like R) to process and clean data




{% highlight text %}
                                levelName
1  project-name                          
2   ¦--data-raw                          
3   ¦   ¦--protein-measure-2017-01-17.txt
4   ¦   ¦--protein-measure-2017-01-18.txt
5   ¦   ¦--protein-measure-2017-01-19.txt
6   ¦   ¦--anthropometrics.csv           
7   ¦   °--blood-measures.csv            
8   ¦--.git                              
9   ¦--R                                 
10  ¦   ¦--process-protein.R             
11  ¦   ¦--process-blood-measures.R      
12  ¦   °--merge-data.R                  
13  °--data                              
14      °--project-data.csv              
{% endhighlight %}

- This is a well established workflow to use, so use it! :D

# Structuring the data:

- Use informative column names
- Each column should be a single data type (only numbers or only letters)
- If there are notes, create a new column (don't use the note feature in Excel)
- Try to keep it 'tidy' (see paper on 'tidy' data)
    - Each row is an observation at one time
    - Each column is (fairly) unique (e.g. don't use `WeightAt10`, `WeightAt15`,
    `WeightAt20`, etc, use `Weight` and `Age`)

# Structuring the data, examples

- Multiple time points per subject (e.g. blood draws):


{% highlight text %}
   SubjectID Time BloodGlucose
1          1    1         6.66
2          1    2         6.78
3          1    3         5.84
4          1    4         6.48
5          1    5         4.67
6          2    1         5.65
7          2    2         6.87
8          2    3         6.97
9          2    4         6.31
10         2    5         5.43
{% endhighlight %}

# Structuring the data, examples

- Multiple time points once per subject (e.g. taking the brain, which of course only happens once):


{% highlight text %}
   MouseID Week BrainWeightG
1        1   10       138.84
2        2   10       140.18
3        3   10       123.87
4        4   10       142.96
5        5   10       133.36
6        6   15       123.35
7        7   15       132.81
8        8   15       141.17
9        9   15       149.23
10      10   15       149.22
{% endhighlight %}

# Structuring the data, examples

- Or if it's a cross-sectional study:


{% highlight text %}
   ParticipantID WeightKg PercentFatIntake
1              1     84.4             49.0
2              2     52.5             41.3
3              3     69.1             32.9
4              4     59.2             43.7
5              5     66.7             38.9
6              6     63.2             28.4
7              7     65.9             33.6
8              8     96.0             30.2
9              9     60.0             42.3
10            10     66.1             34.4
{% endhighlight %}

# Structuring the data, examples

- Or multiple time points for a clinical trial:


{% highlight text %}
   ParticipantID Months BloodPressure PercentFatIntake
1              1      6         112.1             35.6
2              1     12         107.2             33.4
3              2      6          97.1             35.6
4              2     12         112.7             49.3
5              3      6         102.9             36.1
6              3     12          94.8             42.8
7              4      6         102.5             29.2
8              4     12          96.8             35.7
9              5      6         113.8             26.2
10             5     12          97.1             30.3
{% endhighlight %}

# Write up a data dictionary/metadata

- As often as possible, have the information about the data inside the data itself:
    - Example: For simple units, include in variable name like `WeightKg` or `TimeWeeks`
    - Example: For categorical variables (sex, ethnicity), include the actual
    meaning in the data like `"European", "African", "East Asian"` etc rather
    than 1, 2, 3
- If not possible, write up a data dictionary (this saves soooo much time later)
    - Use plain text (txt, csv, markdown) rather than Word Doc or Excel etc.
    This ensures *everyone*, using any software, can read it or use it.
    
# Consider putting your data online 

- Or at least pretend you will be asked to do that
- Biggest advantage: It *forces* you to make sure you are managing the data in
as correct way as possible and to be careful with your data. No one wants the
embarassment of someone else seeing your data and saying... what's going on
here? 
    - (but don't let this fear stop you! Simple fact that you put it up will
    earn you respect and you'll likely get good feedback on how to improve the
    data)
- Use public repositories like GitHub, figshare, Dryad
- No evidence that you will get scoped. There is evidence you will get more
citations by doing so.

# Use scripts to re-arranging/wrangling your data

- if you need to re-arrange or prep the data to be used for the statistical
technique, make sure to use scripts, as they keep a history of what you've done
to the data. Spreadsheets do *not* do that, so be very very wary of them.

- Learn about 'tidy' data for analyzing, plotting, and exploring your data at
the exploration/analysis stage. (link tidy paper Hadley)

<!--
    - plan beforehand and record what each missing value means (e.g. missing =
    didn't answer or didn't know or didn't measure) and have (maybe!) another
    column with a section for notes (avoid using 99 or whatever. Keep it empty
    if it's missing).
- (for collection) I would recommend for any data collection type to use survey
software such as Google Forms to enter your data after you've collected it.
Making the form gives the data a structure and allows you to add conditions that
throw an error if you entered the data wrong (like if it should be a number but
you typed in a letter, or if the value is impossible to be higher than for
instance weight at 1000 pounds or something to prevent you from having a typo..
Trust me, these types of data entry errors if not dealt with right away are not
a major pain to deal with later.)
-->

# Resources

- FAIR concept:
    - (http://www.science.gc.ca/eic/site/063.nsf/eng/h_83F7624E.html?OpenDocument)
    - http://www.nature.com/articles/sdata201618
    - https://www.ncbi.nlm.nih.gov/pubmed/26978244
- ['Tidy' data concept paper](https://www.jstatsoft.org/index.php/jss/article/view/v059i10/v59i10.pdf)
