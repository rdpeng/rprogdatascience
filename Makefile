all: 			overview.md example.md nutsbolts.md subsetting.md readwritedata.md vectorized.md dates.md dplyr.md control.md functions.md scoping.md coding.md apply.md debugging.md simulation.md profiler.md regex.md parallel.md

book_codefiles.zip:	all
			./codefiles.R
			cat codefiles_output.txt |xargs zip $@

book_datasets.zip:	chicago.rds homicides.txt book_datasets/pm25_data/RD_501_88101_1999-0.txt book_datasets/pm25_data/RD_501_88101_2012-0.txt book_datasets/words.gz specdata/*.csv
			zip -r $@ $^

parallel.md:		parallel.Rmd
			knit.R $<
			R --no-save --args $@ < fixmath.R

regex.md:		regex.Rmd
			knit.R $<
			perl -npi -e 's/```r/{line-numbers=off}\n~~~~~~~~/' $@
			perl -npi -e 's/```/~~~~~~~~/' $@

dplyr.md:		dplyr.Rmd
			knit.R $<
			perl -npi -e 's/```r/{line-numbers=off}\n~~~~~~~~/' $@
			perl -npi -e 's/```/~~~~~~~~/' $@

simulation.md:		simulation.Rmd
			knit.R $<
			R --no-save --args $@ < fixmath.R
			perl -npi -e 's/```r/{line-numbers=off}\n~~~~~~~~/' $@
			perl -npi -e 's/```/~~~~~~~~/' $@
			./equation.pl $@

profiler.md:		profiler.Rmd
			knit.R $<
			perl -npi -e 's/```r/{line-numbers=off}\n~~~~~~~~/' $@
			perl -npi -e 's/```/~~~~~~~~/' $@


debugging.md:		debugging.Rmd
			knit.R $<
			perl -npi -e 's/```r/{line-numbers=off}\n~~~~~~~~/' $@
			perl -npi -e 's/```/~~~~~~~~/' $@

apply.md:		apply.Rmd
			knit.R $<
			R --no-save --args $@ < fixmath.R
			perl -npi -e 's/```r/{line-numbers=off}\n~~~~~~~~/' $@
			perl -npi -e 's/```/~~~~~~~~/' $@

scoping.md:		scoping.Rmd
			knit.R $<
			perl -npi -e 's/```r/{line-numbers=off}\n~~~~~~~~/' $@
			perl -npi -e 's/```/~~~~~~~~/' $@

coding.md:		coding.Rmd
			knit.R $<

dates.md:		dates.Rmd
			knit.R $<
			perl -npi -e 's/```r/{line-numbers=off}\n~~~~~~~~/' $@
			perl -npi -e 's/```/~~~~~~~~/' $@

functions.md:		functions.Rmd
			knit.R $<
			perl -npi -e 's/```r/{line-numbers=off}\n~~~~~~~~/' $@
			perl -npi -e 's/```/~~~~~~~~/' $@

control.md:		control.Rmd
			knit.R $<
			perl -npi -e 's/```r/{line-numbers=off}\n~~~~~~~~/' $@
			perl -npi -e 's/```/~~~~~~~~/' $@

vectorized.md:		vectorized.Rmd
			knit.R $<
			perl -npi -e 's/```r/{line-numbers=off}\n~~~~~~~~/' $@
			perl -npi -e 's/```/~~~~~~~~/' $@

subsetting.md:		subsetting.Rmd
			knit.R $<
			R --no-save --args $@ < fixmath.R
			perl -npi -e 's/```r/{line-numbers=off}\n~~~~~~~~/' $@
			perl -npi -e 's/```/~~~~~~~~/' $@

nutsbolts.md:		nutsbolts.Rmd
			knit.R $<
			perl -npi -e 's/```r/{line-numbers=off}\n~~~~~~~~/' $@
			perl -npi -e 's/```/~~~~~~~~/' $@

example.md: 		example.Rmd
			knit.R $<
			perl -npi -e 's/```r/{line-numbers=off}\n~~~~~~~~/' $@
			perl -npi -e 's/```/~~~~~~~~/' $@

overview.md: 		overview.Rmd
			knit.R $<
			perl -npi -e 's/```r/{line-numbers=off}\n~~~~~~~~/' $@
			perl -npi -e 's/```/~~~~~~~~/' $@

readwritedata.md:	readwritedata.Rmd
			knit.R $<
			perl -npi -e 's/```r/{line-numbers=off}\n~~~~~~~~/' $@
			perl -npi -e 's/```/~~~~~~~~/' $@
