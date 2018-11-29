# Global variables and functions are defined here to reduce clutter in server.R
all_ages <- read.csv("data/all-ages.csv", stringsAsFactors = FALSE)
majors_list <- sapply(tolower(all_ages$Major), tools::toTitleCase)
majors_list <- as.data.frame(majors_list, stringsAsFactors = FALSE)$majors_list

get_random_major <- function() {majors_list[sample(1:length(majors_list), 1)]}
r_major <- get_random_major()