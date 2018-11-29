# install.packages("tm")
# install.packages("SnowballC")
# install.packages("wordcloud")
# install.packages("RColorBrewer")
# install.packages("RCurl")
# install.packages("XML")

library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)
library(RCurl)
library(XML)

# Global variables and functions are defined here to reduce clutter in server.R
all_ages <- read.csv("data/all-ages.csv", stringsAsFactors = FALSE)
# Entries are given in all caps. This will change the major names to be in "title case"
majors_list <- sapply(tolower(all_ages$Major), tools::toTitleCase)
majors_list <- as.data.frame(majors_list, stringsAsFactors = FALSE)$majors_list
# Function picks a major from the majors_list at random and returns it.
get_random_major <- function() {majors_list[sample(1:length(majors_list), 1)]}
r_major <- get_random_major()

# Filters out the all_ages dataset to just Majors and their total
majors <- select(all_ages, Major, Major_category, Total)
top_majors <- majors %>% arrange(desc(Total)) %>% select(Major, Total)
top_twenty <- top_majors[1:20,]
twenty_majors <- write.csv(top_twenty, file = "data/twenty_majors.csv")
file_path <- "data/twenty_majors.csv"
majors_twenty <- read.csv("data/twenty_majors.csv", stringsAsFactors = FALSE)
text <- readLines(file_path)
docs <- Corpus(VectorSource(text))