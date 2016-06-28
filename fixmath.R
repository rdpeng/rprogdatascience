
fixmath <- function(infile) {
        doc0 <- readLines(infile)
        
        doc <- sub("^\\\\\\[$", "{\\$\\$}", doc0, perl = TRUE)
        doc <- sub("^\\\\\\]$", "{\\/\\$\\$}", doc, perl = TRUE)
        doc <- gsub("\\$(\\S+)\\$", "{\\$\\$}\\1{\\/\\$\\$}", doc, perl = TRUE)
        
        writeLines(doc, infile)
}