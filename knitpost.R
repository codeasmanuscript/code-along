#!/usr/bin/Rscript --vanilla

# compiles all .Rmd files in _drafts directory into .md files in the _posts
# directory, if the input file is older than the output file.
# run ./knitpost.R to update all knitr files that need to be updated.

KnitPost <- function(input) {
    # this function is a modified version of an example here:
    # http://jfisher-usgs.github.com/r/2012/07/03/knitr-jekyll/
    outfile <- rename_to_post(input)
    knitr::opts_knit$set(base.url = '/')
    fig.path <- paste0("images/", sub(".Rmd$", "", basename(input)), "/")
    knitr::opts_chunk$set(fig.path = fig.path,
                          comment = '#>')
    knitr::render_jekyll()
    knitr::knit(input, outfile, envir = parent.frame())
}

if_newer <- function(draft, post)
    !file.exists(post) | file.info(draft)$mtime > file.info(post)$mtime

posts_to_update <- function(draft) {
    post <- rename_to_post(draft)
    draft[if_newer(draft = draft, post = post)]
}

rename_to_post <- function(draft)
    paste0("_posts/", sub(".Rmd$", ".md", basename(draft)))

drafts <- list.files("_drafts", pattern = "*.Rmd", full.names = TRUE)
sapply(posts_to_update(drafts), KnitPost)
