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

## Chapter 2.2.4 (A Picture Language) instructions:
* Add the following line below `#lang sicp` in your files to include the picture language:
    > (#%require sicp-pict)
* The [docs for the package](https://docs.racket-lang.org/sicp-manual/SICP_Picture_Language.html) are helpful.
* While you may be able to display the images in another editor in some way, I used DrRacket for this section.
* Run `(paint einstein)` and if you see a picture of Einstein, you're good to go!
* When combining painters, the `sicp-pict` implementation doesn't respect aspect ratio of the images, so expect to see some squished/stretched images with procedures such as `right-split`. I thought my `corner-split` wasn't right because of this since the corner looked off, but it was correct.