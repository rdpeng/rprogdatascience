# Getting Data In and Out of R





## Reading and Writing Data

[Watch a video of this section](https://youtu.be/Z_dc_FADyi4)

There are a few principal functions reading data into R. 

* `read.table`, `read.csv`, for reading tabular data 
* `readLines`, for reading lines of a text file
* `source`, for reading in R code files (`inverse` of `dump`) 
* `dget`, for reading in R code files (`inverse` of `dput`)
* `load`, for reading in saved workspaces
* `unserialize`, for reading single R objects in binary form

There are of course, many R packages that have been developed to read
in all kinds of other datasets, and you may need to resort to one of
these packages if you are working in a specific area.

There are analogous functions for writing data to files

* `write.table`, for writing tabular data to text files (i.e. CSV) or
  connections

* `writeLines`, for writing character data line-by-line to a file or
  connection

* `dump`, for dumping a textual representation of multiple R objects

* `dput`, for outputting a textual representation of an R object

* `save`, for saving an arbitrary number of R objects in binary format
  (possibly compressed) to a file.

* `serialize`, for converting an R object into a binary format for
  outputting to a connection (or file).


## Reading Data Files with `read.table()`

The `read.table()` function is one of the most commonly used functions
for reading data. The help file for `read.table()` is worth reading in
its entirety if only because the function gets used a lot (run
`?read.table` in R). I know, I know, everyone always says to read the
help file, but this one is actually worth reading.

The `read.table()` function has a few important arguments:

* `file`, the name of a file, or a connection
* `header`, logical indicating if the file has a header line
* `sep`, a string indicating how the columns are separated
* `colClasses`, a character vector indicating the class of each column
  in the dataset
* `nrows`, the number of rows in the dataset. By default
  `read.table()` reads an entire file.
* `comment.char`, a character string indicating the comment
  character. This defalts to `"#"`. If there are no commented lines in
  your file, it's worth setting this to be the empty string `""`.
* `skip`, the number of lines to skip from the beginning
* `stringsAsFactors`, should character variables be coded as factors?
  This defaults to `TRUE` because back in the old days, if you had
  data that were stored as strings, it was because those strings
  represented levels of a categorical variable. Now we have lots of
  data that is text data and they don't always represent categorical
  variables. So you may want to set this to be `FALSE` in those
  cases. If you *always* want this to be `FALSE`, you can set a global
  option via `options(stringsAsFactors = FALSE)`. I've never seen so
  much heat generated on discussion forums about an R function
  argument than the `stringsAsFactors` argument. Seriously.


For small to moderately sized datasets, you can usually call
read.table without specifying any other arguments


{line-numbers=off}
~~~~~~~~
> data <- read.table("foo.txt")
~~~~~~~~

In this case, R will automatically

* skip lines that begin with a #
* figure out how many rows there are (and how much memory needs to be
  allocated)
* figure what type of variable is in each column of the table. 

Telling R all these things directly makes R run faster and more
efficiently. The `read.csv()` function is identical to read.table
except that some of the defaults are set differently (like the `sep`
argument).


## Reading in Larger Datasets with read.table

[Watch a video of this section](https://youtu.be/BJYYIJO3UFI)

With much larger datasets, there are a few things that you can do that
will make your life easier and will prevent R from choking.

* Read the help page for read.table, which contains many hints

* Make a rough calculation of the memory required to store your
  dataset (see the next section for an example of how to do this). If
  the dataset is larger than the amount of RAM on your computer, you
  can probably stop right here.
* Set `comment.char = ""` if there are no commented lines in your file.
* Use the `colClasses` argument. Specifying this option instead of
  using the default can make ’read.table’ run MUCH faster, often twice
  as fast. In order to use this option, you have to know the class of
  each column in your data frame. If all of the columns are "numeric",
  for example, then you can just set `colClasses = "numeric"`. A quick
  an dirty way to figure out the classes of each column is the
  following:


{line-numbers=off}
~~~~~~~~
> initial <- read.table("datatable.txt", nrows = 100)
> classes <- sapply(initial, class)
> tabAll <- read.table("datatable.txt", colClasses = classes)
~~~~~~~~

* Set `nrows`. This doesn’t make R run faster but it helps with memory
  usage. A mild overestimate is okay. You can use the Unix tool `wc`
  to calculate the number of lines in a file.

In general, when using R with larger datasets, it’s also useful to
know a few things about your system.

* How much memory is available on your system?
* What other applications are in use? Can you close any of them?
* Are there other users logged into the same system? 
* What operating system ar you using? Some operating systems can limit
  the amount of memory a single process can access


## Calculating Memory Requirements for R Objects

Because R stores all of its objects physical memory, it is important
to be cognizant of how much memory is being used up by all of the data
objects residing in your workspace. One situation where it's
particularly important to understand memory requirements is when you
are reading in a new dataset into R. Fortunately, it's easy to make a
back of the envelope calculation of how much memory will be required
by a new dataset.

For example, suppose I have a data frame with 1,500,000 rows and 120
columns, all of which are numeric data. Roughly, how much memory is
required to store this data frame? Well, on most modern computers
[double precision floating point
numbers](http://en.wikipedia.org/wiki/Double-precision_floating-point_format)
are stored using 64 bits of memory, or 8 bytes. Given that
information, you can do the following calculation


| 1,500,000 × 120 × 8 bytes/numeric |  = 1,440,000,000 bytes |
| |  = 1,440,000,000 / 2^20^ bytes/MB  
| | = 1,373.29 MB
| | = 1.34 GB                     

So the dataset would require about 1.34 GB of RAM. Most computers
these days have at least that much RAM. However, you need to be aware
of

- what other programs might be running on your computer, using up RAM
- what other R objects might already be taking up RAM in your workspace

Reading in a large dataset for which you do not have enough RAM is one
easy way to freeze up your computer (or at least your R session). This
is usually an unpleasant experience that usually requires you to kill
the R process, in the best case scenario, or reboot your computer, in
the worst case. So make sure to do a rough calculation of memeory
requirements before reading in a large dataset. You'll thank me later.


# Using the `readr` Package

The `readr` package is recently developed by Hadley Wickham to deal
with reading in large flat files quickly. The package provides
replacements for functions like `read.table()` and `read.csv()`. The
analogous functions in `readr` are `read_table()` and
`read_csv()`. These functions are often *much* faster than their base
R analogues and provide a few other nice features such as progress
meters.

For the most part, you can read use `read_table()` and `read_csv()`
pretty much anywhere you might use `read.table()` and `read.csv()`. In
addition, if there are non-fatal problems that occur while reading in
the data, you will get a warning and the returned data frame will have
some information about which rows/observations triggered the
warning. This can be very helpful for "debugging" problems with your
data before you get neck deep in data analysis.

The importance of the `read_csv` function is perhaps better understood
from an historical perspective. R's built in `read.csv` function
similarly reads CSV files, but the `read_csv` function in `readr`
builds on that by removing some of the quirks and "gotchas" of
`read.csv` as well as dramatically optimizing the speed with which it
can read data into R. The `read_csv` function also adds some nice
user-oriented features like a progress meter and a compact method for
specifying column types.

A typical call to `read_csv` will look as follows.


{line-numbers=off}
~~~~~~~~
> library(readr)
> teams <- read_csv("data/team_standings.csv")
Parsed with column specification:
cols(
  Standing = col_integer(),
  Team = col_character()
)
> teams
# A tibble: 32 × 2
   Standing        Team
      <int>       <chr>
1         1       Spain
2         2 Netherlands
3         3     Germany
4         4     Uruguay
5         5   Argentina
6         6      Brazil
7         7       Ghana
8         8    Paraguay
9         9       Japan
10       10       Chile
# ... with 22 more rows
~~~~~~~~

By default, `read_csv` will open a CSV file and read it in line-by-line. It will also (by default), read in the first few rows of the table in order to figure out the type of each column (i.e. integer, character, etc.). From the `read_csv` help page:

> If 'NULL', all column types will be imputed from the first 1000 rows on the input. This is convenient (and fast), but not robust. If the imputation fails, you'll need to supply the correct types yourself.

You can specify the type of each column with the `col_types` argument.

In general, it's a good idea to specify the column types explicitly. This rules out any possible guessing errors on the part of `read_csv`. Also, specifying the column types explicitly provides a useful safety check in case anything about the dataset should change without you knowing about it.


{line-numbers=off}
~~~~~~~~
> teams <- read_csv("data/team_standings.csv", col_types = "cc")
~~~~~~~~

Note that the `col_types` argument accepts a compact representation. Here `"cc"` indicates that the first column is `character` and the second column is `character` (there are only two columns). Using the `col_types` argument is useful because often it is not easy to automatically figure out the type of a column by looking at a few rows (especially if a column has many missing values).

The `read_csv` function will also read compressed files automatically. There is no need to decompress the file first or use the `gzfile` connection function. The following call reads a gzip-compressed CSV file containing download logs from the RStudio CRAN mirror.


{line-numbers=off}
~~~~~~~~
> logs <- read_csv("data/2016-07-19.csv.bz2", n_max = 10)
Parsed with column specification:
cols(
  date = col_date(format = ""),
  time = col_time(format = ""),
  size = col_integer(),
  r_version = col_character(),
  r_arch = col_character(),
  r_os = col_character(),
  package = col_character(),
  version = col_character(),
  country = col_character(),
  ip_id = col_integer()
)
~~~~~~~~
Note that the warnings indicate that `read_csv` may have had some difficulty identifying the type of each column. This can be solved by using the `col_types` argument.


{line-numbers=off}
~~~~~~~~
> logs <- read_csv("data/2016-07-19.csv.bz2", col_types = "ccicccccci", n_max = 10)
> logs
# A tibble: 10 × 10
         date     time     size r_version r_arch         r_os    package
        <chr>    <chr>    <int>     <chr>  <chr>        <chr>      <chr>
1  2016-07-19 22:00:00  1887881     3.3.0 x86_64      mingw32 data.table
2  2016-07-19 22:00:05    45436     3.3.1 x86_64      mingw32 assertthat
3  2016-07-19 22:00:03 14259016     3.3.1 x86_64      mingw32    stringi
4  2016-07-19 22:00:05  1887881     3.3.1 x86_64      mingw32 data.table
5  2016-07-19 22:00:06   389615     3.3.1 x86_64      mingw32    foreach
6  2016-07-19 22:00:08    48842     3.3.1 x86_64    linux-gnu       tree
7  2016-07-19 22:00:12      525     3.3.1 x86_64 darwin13.4.0   survival
8  2016-07-19 22:00:08  3225980     3.3.1 x86_64      mingw32       Rcpp
9  2016-07-19 22:00:09   556091     3.3.1 x86_64      mingw32     tibble
10 2016-07-19 22:00:10   151527     3.3.1 x86_64      mingw32   magrittr
# ... with 3 more variables: version <chr>, country <chr>, ip_id <int>
~~~~~~~~

You can specify the column type in a more detailed fashion by using the various `col_*` functions. For example, in the log data above, the first column is actually a date, so it might make more sense to read it in as a Date variable. If we wanted to just read in that first column, we could do


{line-numbers=off}
~~~~~~~~
> logdates <- read_csv("data/2016-07-19.csv.bz2", 
+                      col_types = cols_only(date = col_date()),
+                      n_max = 10)
> logdates
# A tibble: 10 × 1
         date
       <date>
1  2016-07-19
2  2016-07-19
3  2016-07-19
4  2016-07-19
5  2016-07-19
6  2016-07-19
7  2016-07-19
8  2016-07-19
9  2016-07-19
10 2016-07-19
~~~~~~~~

Now the `date` column is stored as a `Date` object which can be used for relevant date-related computations (for example, see the `lubridate` package).

A> The `read_csv` function has a `progress` option that defaults to TRUE. This options provides a nice progress meter while the CSV file is being read. However, if you are using `read_csv` in a function, or perhaps embedding it in a loop, it's probably best to set `progress = FALSE`.





# Using Textual and Binary Formats for Storing Data

[Watch a video of this chapter](https://youtu.be/5mIPigbNDfk)

There are a variety of ways that data can be stored, including
structured text files like CSV or tab-delimited, or more complex
binary formats. However, there is an intermediate format that is
textual, but not as simple as something like CSV. The format is native
to R and is somewhat readable because of its textual nature.

One can create a more descriptive representation of an R object by
using the `dput()` or `dump()` functions. The `dump()` and `dput()`
functions are useful because the resulting textual format is
edit-able, and in the case of corruption, potentially
recoverable. Unlike writing out a table or CSV file, `dump()` and
`dput()` preserve the _metadata_ (sacrificing some readability), so
that another user doesn’t have to specify it all over again. For
example, we can preserve the class of each column of a table or the
levels of a factor variable.

Textual formats can work much better with version control programs
like subversion or git which can only track changes meaningfully in
text files. In addition, textual formats can be longer-lived; if there
is corruption somewhere in the file, it can be easier to fix the
problem because one can just open the file in an editor and look at it
(although this would probably only be done in a worst case
scenario!). Finally, textual formats adhere to the [Unix
philosophy](http://www.catb.org/esr/writings/taoup/), if that means
anything to you.

There are a few downsides to using these intermediate textual formats.
The format is not very space-efficient, because all of the metadata is
specified. Also, it is really only partially readable. In some
instances it might be preferable to have data stored in a CSV file and
then have a separate code file that specifies the metadata.


## Using `dput()` and `dump()`

One way to pass data around is by deparsing the R object with `dput()`
and reading it back in (parsing it) using `dget()`.


{line-numbers=off}
~~~~~~~~
> ## Create a data frame
> y <- data.frame(a = 1, b = "a")  
> ## Print 'dput' output to console
> dput(y)                          
structure(list(a = 1, b = structure(1L, .Label = "a", class = "factor")), .Names = c("a", 
"b"), row.names = c(NA, -1L), class = "data.frame")
~~~~~~~~

Notice that the `dput()` output is in the form of R code and that it
preserves metadata like the class of the object, the row names, and
the column names.

The output of `dput()` can also be saved directly to a file.


{line-numbers=off}
~~~~~~~~
> ## Send 'dput' output to a file
> dput(y, file = "y.R")            
> ## Read in 'dput' output from a file
> new.y <- dget("y.R")             
> new.y
  a b
1 1 a
~~~~~~~~

Multiple objects can be deparsed at once using the dump function and
read back in using `source`.


{line-numbers=off}
~~~~~~~~
> x <- "foo"
> y <- data.frame(a = 1L, b = "a")
~~~~~~~~

We can `dump()` R objects to a file by passing a character vector of
their names.


{line-numbers=off}
~~~~~~~~
> dump(c("x", "y"), file = "data.R") 
> rm(x, y)
~~~~~~~~

The inverse of `dump()` is `source()`.


{line-numbers=off}
~~~~~~~~
> source("data.R")
> str(y)
'data.frame':	1 obs. of  2 variables:
 $ a: int 1
 $ b: Factor w/ 1 level "a": 1
> x
[1] "foo"
~~~~~~~~

## Binary Formats

The complement to the textual format is the binary format, which is
sometimes necessary to use for efficiency purposes, or because there's
just no useful way to represent data in a textual manner. Also, with
numeric data, one can often lose precision when converting to and from
a textual format, so it's better to stick with a binary format. 

The key functions for converting R objects into a binary format are
`save()`, `save.image()`, and `serialize()`. Individual R objects can
be saved to a file using the `save()` function.


{line-numbers=off}
~~~~~~~~
> a <- data.frame(x = rnorm(100), y = runif(100))
> b <- c(3, 4.4, 1 / 3)
> 
> ## Save 'a' and 'b' to a file
> save(a, b, file = "mydata.rda") 
> 
> ## Load 'a' and 'b' into your workspace
> load("mydata.rda")              
~~~~~~~~

If you have a lot of objects that you want to save to a file, you can
save all objects in your workspace using the `save.image()` function.


{line-numbers=off}
~~~~~~~~
> ## Save everything to a file
> save.image(file = "mydata.RData")   
> 
> ## load all objects in this file
> load("mydata.RData")                
~~~~~~~~

Notice that I've used the `.rda` extension when using `save()` and the
`.RData` extension when using `save.image()`. This is just my personal
preference; you can use whatever file extension you want. The `save()`
and `save.image()` functions do not care. However, `.rda` and `.RData`
are fairly common extensions and you may want to use them because they
are recognized by other software.

The `serialize()` function is used to convert individual R objects
into a binary format that can be communicated across an arbitrary
connection. This may get sent to a file, but it could get sent over a
network or other connection.

When you call `serialize()` on an R object, the output will be a raw
vector coded in hexadecimal format.


{line-numbers=off}
~~~~~~~~
> x <- list(1, 2, 3)
> serialize(x, NULL)
 [1] 58 0a 00 00 00 02 00 03 03 02 00 02 03 00 00 00 00 13 00 00 00 03 00
[24] 00 00 0e 00 00 00 01 3f f0 00 00 00 00 00 00 00 00 00 0e 00 00 00 01
[47] 40 00 00 00 00 00 00 00 00 00 00 0e 00 00 00 01 40 08 00 00 00 00 00
[70] 00
~~~~~~~~

If you want, this can be sent to a file, but in that case you are
better off using something like `save()`. 

The benefit of the `serialize()` function is that it is the only way
to perfectly represent an R object in an exportable format, without
losing precision or any metadata. If that is what you need, then
`serialize()` is the function for you.




# Interfaces to the Outside World

[Watch a video of this chapter](https://youtu.be/Pb01WoJRUtY)

Data are read in using _connection_ interfaces. Connections can be
made to files (most common) or to other more exotic things.

- `file`, opens a connection to a file
- `gzfile`, opens a connection to a file compressed with gzip
- `bzfile`, opens a connection to a file compressed with bzip2 
- `url`, opens a connection to a webpage


In general, connections are powerful tools that let you navigate files
or other external objects. Connections can be thought of as a
translator that lets you talk to objects that are outside of R. Those
outside objects could be anything from a data base, a simple text
file, or a a web service API. Connections allow R functions to talk to
all these different external objects without you having to write
custom code for each object.


## File Connections

Connections to text files can be created with the `file()` function.


{line-numbers=off}
~~~~~~~~
> str(file)
function (description = "", open = "", blocking = TRUE, encoding = getOption("encoding"), 
    raw = FALSE, method = getOption("url.method", "default"))  
~~~~~~~~

The `file()` function has a number of arguments that are common to
many other connection functions so it's worth going into a little
detail here.

* `description` is the name of the file 
* `open` is a code indicating what mode the file should be opened in

The `open` argument allows for the following options:

- "r" open file in read only mode
- "w" open a file for writing (and initializing a new file)
- "a" open a file for appending
- "rb", "wb", "ab" reading, writing, or appending in binary mode (Windows)


In practice, we often don't need to deal with the connection interface
directly as many functions for reading and writing data just deal with
it in the background.

For example, if one were to explicitly use connections to read a CSV
file in to R, it might look like this,


{line-numbers=off}
~~~~~~~~
> ## Create a connection to 'foo.txt'
> con <- file("foo.txt")       
> 
> ## Open connection to 'foo.txt' in read-only mode
> open(con, "r")               
> 
> ## Read from the connection
> data <- read.csv(con)        
> 
> ## Close the connection
> close(con)                   
~~~~~~~~

which is the same as


{line-numbers=off}
~~~~~~~~
> data <- read.csv("foo.txt")
~~~~~~~~

In the background, `read.csv()` opens a connection to the file
`foo.txt`, reads from it, and closes the connection when it's done.

The above example shows the basic approach to using
connections. Connections must be opened, then the are read from or
written to, and then they are closed.


## Reading Lines of a Text File

Text files can be read line by line using the `readLines()`
function. This function is useful for reading text files that may be
unstructured or contain non-standard data. 


{line-numbers=off}
~~~~~~~~
> ## Open connection to gz-compressed text file
> con <- gzfile("words.gz")   
> x <- readLines(con, 10) 
> x
 [1] "1080"     "10-point" "10th"     "11-point" "12-point" "16-point"
 [7] "18-point" "1st"      "2"        "20-point"
~~~~~~~~

For more structured text data like CSV files or tab-delimited files,
there are other functions like `read.csv()` or `read.table()`.

The above example used the `gzfile()` function which is used to create
a connection to files compressed using the gzip algorithm. This
approach is useful because it allows you to read from a file without
having to uncompress the file first, which would be a waste of space
and time.

There is a complementary function `writeLines()` that takes a
character vector and writes each element of the vector one line at a
time to a text file.

## Reading From a URL Connection

The `readLines()` function can be useful for reading in lines of
webpages. Since web pages are basically text files that are stored on
a remote server, there is conceptually not much difference between a
web page and a local text file. However, we need R to negotiate the
communication between your computer and the web server. This is what
the `url()` function can do for you, by creating a `url` connection to
a web server.

This code might take time depending on your connection speed.


{line-numbers=off}
~~~~~~~~
> ## Open a URL connection for reading
> con <- url("http://www.jhsph.edu", "r")  
> 
> ## Read the web page
> x <- readLines(con)                      
> 
> ## Print out the first few lines
> head(x)                                  
[1] "<!DOCTYPE html>"                                               
[2] "<html lang=\"en\">"                                            
[3] ""                                                              
[4] "<head>"                                                        
[5] "<meta charset=\"utf-8\" />"                                    
[6] "<title>Johns Hopkins Bloomberg School of Public Health</title>"
~~~~~~~~

While reading in a simple web page is sometimes useful, particularly
if data are embedded in the web page somewhere. However, more commonly
we can use URL connection to read in specific data files that are
stored on web servers. 

Using URL connections can be useful for producing a reproducible
analysis, because the code essentially documents where the data came
from and how they were obtained. This is approach is preferable to
opening a web browser and downloading a dataset by hand. Of course,
the code you write with connections may not be executable at a later
date if things on the server side are changed or reorganized.
