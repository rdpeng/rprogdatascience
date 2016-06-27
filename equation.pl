#!/usr/bin/perl -i

while(<>) {
    s/\\\[/{\$\$}/;
    s/\\\]/{\/\$\$}/;
    print;
}
