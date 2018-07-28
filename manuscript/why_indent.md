Why I Indent My Code 8 Spaces
=============================

As mentioned previously in this book, my general indenting policy for R
code is to use 8 spaces per indent. In my experience, people tend to
find this a rather extreme indentation policy, with maybe 4 spaces being
at the outer limit of what they could imagine. But I’ve been using 8
spaces for a long time now and I’ve found that it has a number of
benefits.

First off, I did not make up the 8 space indent. I got it from the
[Linux kernal coding style
document](https://www.kernel.org/doc/Documentation/process/coding-style.rst).
Chapter 1 says:

> Tabs are 8 characters, and thus indentations are also 8 characters.
> There are heretic movements that try to make indentations 4 (or even
> 2!) characters deep, and that is akin to trying to define the value of
> PI to be 3.

I've found the Linux kernal coding style to be pretty useful for my R
programming, but a lot of it is C-specific and so not relevant.
Nevertheless, it's worth a quick peruse.

Personally, I've found 8 spaces is good for my aging eyes. I think my
rule is that the appropriate number of spaces of indentation is
proportional to the square of my age (I'm still working on that model
though). At this point, code with a 2 space indent is indistinguishable
from flush left.

Before going on, I have to emphasize that the 8 space indent cannot
exist in isolation. It has to be coupled with a right-hand side limit of
80 columns. Otherwise, you could just indent yourself off to infinity
and there would be no consequences. An 80 column limit forces you to
keep your code within reasonable limits. Also, if someone ever needs to
read your code on a PDP/11 you'll be A-okay.

Most importantly though, I've found that the 8 space indent serves as a
kind of early warning system for "smelly" code. Jenny gave some smelly
examples in her talk and I thought I'd reproduce them here. This first
example, as Jenny describes, suffers from not using the available class
predicate functions to test for "numeric" or "integer". Here's the
example with a 2 space indent.

    bizarro <- function(x) {
      if (class(x)[[1]] == "numeric" || class(x)[[1]] == "integer") {
        -x
      } else if (class(x)[[1]] == "logical") {
        !x
      } else { 
        stop(...) 
      }
    }

That first `if` state sticks out a little bit because it's rather long.
Better code might use the `is.numeric()` and `is.integer()` functions.

Here's the same example with an 8 space indent.

    bizarro <- function(x) {
            if (class(x)[[1]] == "numeric" || class(x)[[1]] == "integer") {
                    -x
            } else if (class(x)[[1]] == "logical") {
                    !x
            } else { 
                    stop(...) 
            }
    }

Although, it's not egregious, that first line is pushing up against the
80 column limit on the right-hand side. You might not do anything about
it in this case, but the purpose of the indenting system is to at least
trigger a reaction.

The next example from Jenny's talk is a bit more obvious. Here she gives
a lesson in excessive `if-else` statements. The original code with 2
space indent is here.

    get_some_data <- function(config, outfile) {
      if (config_ok(config)) {
        if (can_write(outfile)) {
          if (can_open_network_connection(config)) {
            data <- parse_something_from_network()
            if(makes_sense(data)) {
              data <- beautify(data)
              write_it(data, outfile)
              return(TRUE)
            } else {
              return(FALSE)
            }
          } else {
            stop("Can't access network")
          }
        } else {
          ## uhm. What was this else for again?
        }
      } else {
        ## maybe, some bad news about ... the config?
      } 
    }

Now, it's fair to say that this code already looks a bit smelly
(fishy?), but it's maybe passable from a visual standpoint. Let's take a
look at it with 8 space indents.

    get_some_data <- function(config, outfile) {
            if (config_ok(config)) {
                    if (can_write(outfile)) {
                            if (can_open_network_connection(config)) {
                                    data <- parse_something_from_network()
                                    if(makes_sense(data)) {
                                            data <- beautify(data)
                                            write_it(data, outfile)
                                            return(TRUE)
                                    } else {
                                            return(FALSE)
                                    }
                            } else {
                                    stop("Can't access network")
                            }
                    } else {
                            ## uhm. What was this else for again?
                    }
            } else {
                    ## maybe, some bad news about ... the config?
            } 
    }

Now the code looks downright absurd, practically crying out for
refactoring, and rightly so! The five levels of nesting will be
unreadable as soon as you blink your eyes.

That's basically it. I've found zero downsides to using an 8 space
indent and a number of upsides, including cleaner, more modular code.
Because the visual indicator penalizes against lots of indenting, you
are usually forced to write out separate functions to handle different
tasks rather than go one more level in. This not only has the benefit of
being modular, but it's also useful for things like profiling (it can be
very uninformative to profile a single monolithic function).
