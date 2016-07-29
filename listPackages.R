library(dplyr, warn.conflicts = FALSE)
pkgs <- local({
        files <- dir(pattern = glob2rx("*.Rmd"))
        code <- lapply(files, readLines) %>% unlist
        r <- regexec("^library\\((.*?)\\)", code, perl = TRUE)
        m <- regmatches(code, r)
        u <- sapply(m, length) > 0
        sapply(m[u], function(x) x[2]) %>% unique
})
writeLines(pkgs, "_R_package_list.txt")

int <- installed.packages()[, 1]
need <- setdiff(pkgs, int)
if(length(need) > 0L) {
        install.packages(need)
}
