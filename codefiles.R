#!/Users/rdpeng/bin/Rscript

library(knitr)

files <- readLines("Book.txt")
files <- sub("md$", "Rmd", files, perl = TRUE)
use <- file.exists(files) & files != "overview.Rmd"

if(sum(use) == 0L) {
        stop("no files")
}

files <- files[use]
output <- character(length(files))

for(i in seq_along(files)) {
        output[i] <- knit(files[i], tangle = TRUE)
}

writeLines(output, "codefiles_output.txt")
