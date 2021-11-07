# Vectorized Operations

[Watch a video of this chapter](https://youtu.be/YH3qtw7mTyA)



Many operations in R are _vectorized_, meaning that operations occur
in parallel in certain R objects. This allows you to write code that
is efficient, concise, and easier to read than in non-vectorized
languages.

The simplest example is when adding two vectors together.


{line-numbers=off}
~~~~~~~~
> x <- 1:4
> y <- 6:9 
> z <- x + y
> z
[1]  7  9 11 13
~~~~~~~~

Natural, right? Without vectorization, you'd have to do something like


{line-numbers=off}
~~~~~~~~
z <- numeric(length(x))
for(i in seq_along(x)) {
      z[i] <- x[i] + y[i]
}
z
[1]  7  9 11 13
~~~~~~~~

If you had to do that every time you wanted to add two vectors, your
hands would get very tired from all the typing.

Another operation you can do in a vectorized manner is logical
comparisons. So suppose you wanted to know which elements of a vector
were greater than 2. You could do he following.


{line-numbers=off}
~~~~~~~~
> x
[1] 1 2 3 4
> x > 2
[1] FALSE FALSE  TRUE  TRUE
~~~~~~~~

Here are other vectorized logical operations.


{line-numbers=off}
~~~~~~~~
> x >= 2
[1] FALSE  TRUE  TRUE  TRUE
> x < 3
[1]  TRUE  TRUE FALSE FALSE
> y == 8
[1] FALSE FALSE  TRUE FALSE
~~~~~~~~

Notice that these logical operations return a logical vector of `TRUE`
and `FALSE`.


Of course, subtraction, multiplication and division are also vectorized.


{line-numbers=off}
~~~~~~~~
> x - y
[1] -5 -5 -5 -5
> x * y
[1]  6 14 24 36
> x / y
[1] 0.1666667 0.2857143 0.3750000 0.4444444
~~~~~~~~

## Vectorized Matrix Operations

Matrix operations are also vectorized, making for nicly compact
notation. This way, we can do element-by-element operations on
matrices without having to loop over every element.


{line-numbers=off}
~~~~~~~~
> x <- matrix(1:4, 2, 2)
> y <- matrix(rep(10, 4), 2, 2)
> 
> ## element-wise multiplication
> x * y       
     [,1] [,2]
[1,]   10   30
[2,]   20   40
> 
> ## element-wise division
> x / y       
     [,1] [,2]
[1,]  0.1  0.3
[2,]  0.2  0.4
> 
> ## true matrix multiplication
> x %*% y     
     [,1] [,2]
[1,]   40   40
[2,]   60   60
~~~~~~~~


