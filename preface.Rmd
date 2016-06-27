# Preface

I started using R in 1998 when I was a college undergraduate working
on my senior thesis. The version was 0.63. I was an applied
mathematics major with a statistics concentration and I was working
with Dr. Nicolas Hengartner on an analysis of word frequencies in
classic texts (Shakespeare, Milton, etc.). The idea was to see if we
could identify the authorship of each of the texts based on how
frequently they used certain words. We downloaded the data from
Project Gutenberg and used some basic linear discriminant analysis for
the modeling. The work was [eventually
published](http://amstat.tandfonline.com/doi/abs/10.1198/000313002100#.VQGiSELpagE)
and was my first ever peer-reviewed publication. I guess you could
argue it was my first real "data science" experience.

Back then, no one was using R. Most of my classes were taught with
Minitab, SPSS, Stata, or Microsoft Excel. The cool people on the
cutting edge of statistical methodology used S-PLUS. I was working on
my thesis late one night and I had a problem. I didn't have a copy of
any of those software packages because they were expensive and I was a
student. I didn't feel like trekking over to the computer lab to use
the software because it was late at night.

But I had the Internet! After a couple of Yahoo! searches I found a
web page for something called R, which I figured was just a play on
the name of the S-PLUS package. From what I could tell, R was a
"clone" of S-PLUS that was free. I had already written some S-PLUS
code for my thesis so I figured I would try to download R and see if I
could just run the S-PLUS code.

It didn't work. At least not at first. It turns out that R is not
exactly a clone of S-PLUS and quite a few modifications needed to be
made before the code would run in R. In particular, R was missing a
lot of statistical functionality that had existed in S-PLUS for a long
time already. Luckily, R's programming language was pretty much there
and I was able to more or less re-implement the features that were
missing in R.

After college, I enrolled in a PhD program in statistics at the
University of California, Los Angeles. At the time the department was
brand new and they didn't have a lot of policies or rules (or classes,
for that matter!). So you could kind of do what you wanted, which was
good for some students and not so good for others. The Chair of the
department, Jan de Leeuw, was a big fan of XLisp-Stat and so all of
the department's classes were taught using XLisp-Stat. I diligently
bought my copy of [Luke Tierney's
book](http://www.amazon.com/LISP-STAT-Object-Oriented-Environment-Statistical-Probability/dp/0471509167/)
and learned to really love XLisp-Stat. It had a number of features
that R didn't have at all, most notably dynamic graphics.

But ultimately, there were only so many parentheses that I could type,
and still all of the research-level statistics was being done in
S-PLUS. The department didn't really have a lot of copies of S-PLUS
lying around so I turned back to R. When I looked around at my fellow
students, I realized that I was basically the only one who had any
experience using R. Since there was a budding interest in R around the
department, I decided to start a "brown bag" series where every week
for about an hour I would talk about something you could do in R
(which wasn't much, really). People seemed to like it, if only because
there wasn't really anyone to turn to if you wanted to learn about R. 

By the time I left grad school in 2003, the department had essentially
switched over from XLisp-Stat to R for all its work (although there
were a few hold outs). Jan discusses the rationale for the transition
in a [paper](http://www.jstatsoft.org/v13/i07) in the *Journal of
Statistical Software*.

In the next step of my career, I went to the [Department of
Biostatistics](http://www.biostat.jhsph.edu) at the Johns Hopkins
Bloomberg School of Public Health, where I have been for the past 12
years. When I got to Johns Hopkins people already seemed into R. Most
people had abandoned S-PLUS a while ago and were committed to using R
for their research. Of all the available statistical packages, R had
the most powerful and expressive programming language, which was
perfect for someone developing *new* statistical methods.

However, we didn't really have a class that taught students how to use
R. This was a problem because most of our grad students were coming
into the program having never heard of R. Most likely in their
undergraduate programs, they used some other software package. So along
with Rafael Irizarry, Brian Caffo, Ingo Ruczinski, and Karl Broman, I
started a new class to teach our graduate students R and a number of
other skills they'd need in grad school.

The class was basically a weekly seminar where one of us talked about
a computing topic of interest. I gave some of the R lectures in that
class and when I asked people who had heard of R before, almost no one
raised their hand. And no one had actually used it before.  The main
selling point at the time was "It's just like S-PLUS but it's free!"
A lot of people had experience with SAS or Stata or SPSS. A number of
people had used something like Java or C/C++ before and so I often
used that a reference frame. No one had ever used a functional-style
of programming language like Scheme or Lisp.

To this day, I still teach the class, known a Biostatistics 140.776
("Statistical Computing"). However, the nature of the class has
changed quite a bit over the past 10 years. The population of students
(mostly first-year graduate students) has shifted to the point where
many of them have been introduced to R as undergraduates. This trend
mirrors the overall trend with statistics where we are seeing more and
more students do undergraduate majors in statistics (as opposed to,
say, mathematics). Eventually, by 2008--2009, when I'd asked how many
people had heard of or used R before, everyone raised their
hand. However, even at that late date, I still felt the need to
convince people that R was a "real" language that could be used for
real tasks.

R has grown a lot in recent years, and is being used in so many places
now, that I think it's essentially impossible for a person to keep
track of everything that is going on. That's fine, but it makes
"introducing" people to R an interesting experience. Nowadays in
class, students are often teaching me something new about R that I've
never seen or heard of before (they are quite good at Googling around
for themselves). I feel no need to "bring people over" to R. In fact
it's quite the opposite--people might start asking questions if I
*weren't* teaching R.

This book comes from my experience teaching R in a variety of settings
and through different stages of its (and my) development. Much of the
material has been taken from by Statistical Computing class as well
as the [R Programming](https://www.coursera.org/course/rprog) class I
teach through Coursera.

I'm looking forward to teaching R to people as long as people will let
me, and I'm interested in seeing how the next generation of students
will approach it (and how my approach to them will change). Overall,
it's been just an amazing experience to see the widespread adoption of
R over the past decade. I'm sure the next decade will be just as
amazing.

