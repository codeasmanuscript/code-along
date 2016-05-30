#!/usr/bin/Rscript
#
# Usage: ./send.R arg1 arg2
#
# arg1 = either Louisa or Emilia
# arg2 = workshop session file
#
args <- commandArgs(trailingOnly = TRUE)
params <- list()
params$to <- match.arg(args[1], c('Louisa', 'Emilia'))
params$file <- args[2]
if (length(args) > 2)
    stop('Only two arguments are needed.')

sender <- 'luke.johnston@mail.utoronto.ca'
subject <- 'Upcoming DNS R workshop'

if (params$to == 'Louisa') {
    recipient <- 'louisa.kung@utoronto.ca'
} else if (params$to == 'Emilia') {
    recipient <- 'e.dsouza@utoronto.ca'
}

knitr::knit('email.Rmd', envir = globalenv(), quiet = TRUE)
email <- readLines('email.md')
email_body <- paste(gsub(', ', ' and ', email), collapse = '\n')

# Initial email
command <- paste0("thunderbird -compose to='", recipient, "',from='",
              sender, "',subject='", subject,"',body='", email_body, "'")
system(command)

# Reminder email
subject <- 'Reminder: Upcoming DNS R workshop'
command <- paste0("thunderbird -compose to='", recipient, "',from='",
              sender, "',subject='", subject,"',body='", email_body, "'")
system(command)
