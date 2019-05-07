# Coding Standards for R

[Watch a video of this chapter](http://youtu.be/MSPKE1y3cyQ)

Coding standards are by no means universal and are often the subject of irrational flame wars on various language- or project-specific mailing lists. Nevertheless, I will just give you the standards that I use and the rationale behind them.

**Always use text files / text editor**. I think we can all agree on this one. Using text files and a text editor is fundamental to coding. If you're writing your code in an editor like Microsoft Word, you need to stop. Interactive development environments like RStudio have nice text editors built in, but there are many others out there.

**Indent your code**. Indenting is very important for the readability of your code. Some programming languages actually require it as part of their syntax, but R does not. Nevertheless, indenting is very important. How much you should indent is up for debate, but I think each indent should be a minimum of 4 spaces, and ideally **it should be 8 spaces**.

**Limit the width of your code**. I like to limit the width of my text editor so that the code I write doesn't fly off into the wilderness on the right hand side. This limitation, along with the 8 space indentation, forces you to write code that is clean, readable, and naturally broken down into modular units. In particular, this combination limits your ability to write very long functions with many different levels of nesting.

**Limit the length of individual functions**. If you are writing functions, it's usually a good idea to not let your functions run for pages and pages. Typically, purpose of a function is to execute one activity or idea. If your function is doing lots of things, it probably needs to be broken into multiple functions. My rule of thumb is that a function should not take up more than one page of your editor (of course, this depends on the size of your monitor).

