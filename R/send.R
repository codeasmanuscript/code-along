#!/usr/bin/Rscript
#
# Usage: ./send.R arg1 arg2
#
# arg1 = either Louisa or Emilia
# arg2 = workshop session file
#

# Read in commandline arguments -------------------------------------------

args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 2)
    stop('Please supply two args: Louisa/Emilia and the session file.')
if (!file.exists(args[2]))
    stop('Please supply a file that actually exists.')

params <- list()
params$to <- match.arg(args[1], c('Louisa', 'Emilia'))
params$file <- args[2]

# Extract yaml data from post ---------------------------------------------

library(yaml)
library(readr)
pre <- read_lines(params$file, skip = 1)
file_contents <- head(pre, grep('---', pre)[1]-1)
workshop <- yaml.load(paste(file_contents, collapse = '\n'))
ws_time <- format(strptime(workshop$time, format='%H:%M'), '%I:%M %p')
ws_date <- format(as.Date(workshop$date), '%A %B %d')

pkgs <- ''
if (!is.null(workshop$packages)) {
    pkgs <- gsub('c|\\(|\\)|"', '', workshop$packages)
    pkgs <- paste0(' as well as these package(s): ', pkgs)
}

# Set email details -------------------------------------------------------

sender <- 'luke.johnston@mail.utoronto.ca'
topic <- paste0(toupper(substr(workshop$topic, 1, 1)),
                substr(workshop$topic, 2, nchar(workshop$topic)))
subject <- paste0('Upcoming DNS R workshop: ', topic)

if (params$to == 'Louisa') {
    recipient <- 'louisa.kung@utoronto.ca'
} else if (params$to == 'Emilia') {
    recipient <- 'e.dsouza@utoronto.ca'
}

knitr::knit('email.Rmd', envir = globalenv(), quiet = TRUE)
email <- readLines('email.md')
email_body <- paste(gsub(', ', ' and ', email), collapse = '\n')

# Create initial email of session -----------------------------------------

command <- paste0("thunderbird -compose to='", recipient, "',from='",
              sender, "',subject='", subject,"',body='", email_body, "'")
system(command)

# Create reminder email of session ----------------------------------------

subject <- 'Reminder: Upcoming DNS R workshop'
command <- paste0("thunderbird -compose to='", recipient, "',from='",
              sender, "',subject='", subject,"',body='", email_body, "'")
system(command)
