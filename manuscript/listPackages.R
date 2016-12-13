library(dplyr, warn.conflicts = FALSE)
local({
        files <- dir(pattern = glob2rx("*.Rmd"))
        code <- lapply(files, readLines) %>% unlist
        r <- regexec("^library\\((.*?)\\)", code, perl = TRUE)
        m <- regmatches(code, r)
        u <- sapply(m, length) > 0
        pkgs1 <- sapply(m[u], function(x) x[2])
        r <- regexec("([A-Za-z]+)::.*", code, perl = TRUE)
        m <- regmatches(code, r)
        u <- sapply(m, length) > 0
        pkgs2 <- sapply(m[u], function(x) x[2])
        pkgs <- unique(c(pkgs1, pkgs2)) %>% sort
        
        writeLines(pkgs, "_R_package_list.txt")
        
        int <- installed.packages()[, 1]
        ava <- available.packages() %>% rownames
        need <- setdiff(pkgs, int)
        need <- need[need %in% ava]
        if(length(need) > 0L) {
                install.packages(need)
        }
})

