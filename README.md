Here are my solutions to the exercises in Structure and Interpretation of Computer Programs. Work in progress.

The version of the book I've been using most is [this HTML5 rendition](https://github.com/sarabander/sicp)

## Cross-platform setup:
1. [Download and install Racket]()
2. Install the [sicp package](https://pkgs.racket-lang.org/package/sicp)
    * if `raco` is in your path now, type the following to install it:
    > raco pkg install sicp
3. Either
    1. use the Racket GUI for editing, running, and REPL, or
    2. use your favorite editor and the `racket` command to start a REPL.
        * Once the REPL is started, type `,enter filename` where filename is the
        relative path to your exercise. This will run the file and plop you back into the REPL with all the definitions from the file loaded. You'll have to repeat the command whenever you make changes to the file.
4. Add the following line to the top of every file you run through Racket so it knows to use the `sicp` package's specification of Scheme instead of defaulting to racket-lang:
    > #lang sicp

## Supporting Code
The [code for the chapters](https://mitpress.mit.edu/sites/default/files/sicp/code/index.html) which includes supporting code, is very helpful. Sometimes exercises require some extra code to actually execute, and the Complete Code will provide it. I also found exercise 2.77 much more straightforward when being able to see all the code in one place and not be left guessing what previous snippets were implied to be in play.

## Chapter 2.2.4 (A Picture Language) instructions:
* Add the following line below `#lang sicp` in your files to include the picture language:
    > (#%require sicp-pict)
* The [docs for the package](https://docs.racket-lang.org/sicp-manual/SICP_Picture_Language.html) are helpful.
* While you may be able to display the images in another editor in some way, I used DrRacket for this section.
* Run `(paint einstein)` and if you see a picture of Einstein, you're good to go!
* When combining painters, the `sicp-pict` implementation doesn't respect aspect ratio of the images, so expect to see some squished/stretched images with procedures such as `right-split`. I thought my `corner-split` wasn't right because of this since the corner looked off, but it was correct.
* `sicp-pict` doesn't work for exercise 2.49, so you will have to look up a way around it. I used a solution that utilized the lib `racket/draw` and saved pictures to the filesystem, based heavily on [this solution](https://github.com/slobodin/SICP/blob/master/ch2/ex2-49.scm).