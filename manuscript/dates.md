# Dates and Times





R has developed a special representation for dates and times. Dates are represented by the `Date` class and times are represented by the `POSIXct` or the `POSIXlt` class. Dates are stored internally as the number of days since 1970-01-01 while times are stored internally as the number of seconds since 1970-01-01. 

It's not important to know the internal representation of dates and times in order to use them in R. I just thought those were fun facts.

## Dates in R

[Watch a video of this section](https://youtu.be/opYexVgjwkE)

Dates are represented by the `Date` class and can be coerced from a character string using the `as.Date()` function. This is a common way to end up with a `Date` object in R.


{line-numbers=off}
~~~~~~~~
> ## Coerce a 'Date' object from character
> x <- as.Date("1970-01-01")   
> x
[1] "1970-01-01"
~~~~~~~~

You can see the internal representation of a `Date` object by using the `unclass()` function.


{line-numbers=off}
~~~~~~~~
> unclass(x)
[1] 0
> unclass(as.Date("1970-01-02"))
[1] 1
~~~~~~~~

## Times in R

[Watch a video of this section](https://youtu.be/8HENCYXwZoU)

Times are represented by the `POSIXct` or the `POSIXlt` class. `POSIXct` is just a very large integer under the hood. It use a useful class when you want to store times in something like a data frame. `POSIXlt` is a list underneath and it stores a bunch of other useful information like the day of the week, day of the year, month, day of the month. This is useful when you need that kind of information.

There are a number of generic functions that work on dates and times to help you extract pieces of dates and/or times.

- `weekdays`: give the day of the week
- `months`: give the month name
- `quarters`: give the quarter number (“Q1”, “Q2”, “Q3”, or “Q4”)

Times can be coerced from a character string using the `as.POSIXlt` or `as.POSIXct` function.


{line-numbers=off}
~~~~~~~~
> x <- Sys.time()
> x
[1] "2020-09-03 17:18:31 EDT"
> class(x)   ## 'POSIXct' object
[1] "POSIXct" "POSIXt" 
~~~~~~~~

The `POSIXlt` object contains some useful metadata.


{line-numbers=off}
~~~~~~~~
> p <- as.POSIXlt(x)
> names(unclass(p))
 [1] "sec"    "min"    "hour"   "mday"   "mon"    "year"   "wday"   "yday"  
 [9] "isdst"  "zone"   "gmtoff"
> p$wday     ## day of the week
[1] 4
~~~~~~~~

You can also use the `POSIXct` format.


{line-numbers=off}
~~~~~~~~
> x <- Sys.time()
> x             ## Already in ‘POSIXct’ format
[1] "2020-09-03 17:18:31 EDT"
> unclass(x)    ## Internal representation
[1] 1599167912
> x$sec         ## Can't do this with 'POSIXct'!
Error in x$sec: $ operator is invalid for atomic vectors
> p <- as.POSIXlt(x)
> p$sec         ## That's better
[1] 31.6434
~~~~~~~~

Finally, there is the `strptime()` function in case your dates are
written in a different format. `strptime()` takes a character vector that has dates and times and converts them into to a `POSIXlt` object.



{line-numbers=off}
~~~~~~~~
> datestring <- c("January 10, 2012 10:40", "December 9, 2011 9:10")
> x <- strptime(datestring, "%B %d, %Y %H:%M")
> x
[1] "2012-01-10 10:40:00 EST" "2011-12-09 09:10:00 EST"
> class(x)
[1] "POSIXlt" "POSIXt" 
~~~~~~~~

The weird-looking symbols that start with the `%` symbol are the formatting strings for dates and times. I can _never_ remember the formatting strings. Check `?strptime` for details. It's probably not worth memorizing this stuff.


## Operations on Dates and Times

[Watch a video of this section](https://youtu.be/vEmWJrpP1KM)

You can use mathematical operations on dates and times. Well, really just + and -. You can do comparisons too (i.e. ==, <=)


{line-numbers=off}
~~~~~~~~
> x <- as.Date("2012-01-01")
> y <- strptime("9 Jan 2011 11:34:21", "%d %b %Y %H:%M:%S") 
> x-y
Warning: Incompatible methods ("-.Date", "-.POSIXt") for "-"
Error in x - y: non-numeric argument to binary operator
> x <- as.POSIXlt(x) 
> x-y
Time difference of 356.3095 days
~~~~~~~~

The nice thing about the date/time classes is that they keep track of all the annoying things about dates and times, like leap years, leap seconds, daylight savings, and time zones.

Here's an example where a leap year gets involved.


{line-numbers=off}
~~~~~~~~
> x <- as.Date("2012-03-01") 
> y <- as.Date("2012-02-28") 
> x-y
Time difference of 2 days
~~~~~~~~

Here's an example where two different time zones are in play (unless you live in GMT timezone, in which case they will be the same!).


{line-numbers=off}
~~~~~~~~
> ## My local time zone
> x <- as.POSIXct("2012-10-25 01:00:00")     
> y <- as.POSIXct("2012-10-25 06:00:00", tz = "GMT") 
> y-x
Time difference of 1 hours
~~~~~~~~


## Summary

- Dates and times have special classes in R that allow for numerical and statistical calculations
- Dates use the `Date` class
- Times use the `POSIXct` and `POSIXlt` class
- Character strings can be coerced to Date/Time classes using the `strptime` function or the `as.Date`, `as.POSIXlt`, or `as.POSIXct`
