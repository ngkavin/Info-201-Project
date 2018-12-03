# Global variables and functions are defined here to reduce clutter in server.R

all_ages <- read.csv("data/all-ages.csv", stringsAsFactors = FALSE)
grad <- read.csv("data/grad-students.csv", stringsAsFactors = FALSE)

# Entries are given in all caps. This will change the major names to be in "title case"
majors_list <- sapply(tolower(grad$Major), tools::toTitleCase)
majors_list <- as.data.frame(majors_list, stringsAsFactors = FALSE)$majors_list
# Function picks a major from the majors_list at random and returns it.
get_random_major <- function() {majors_list[sample(1:length(majors_list), 1)]}
select_choices <- split(majors_list, grad$Major_category)

# Filters out the all_ages dataset to just Majors and their total in descending order
majors <- select(all_ages, Major, Major_category, Total)
all_majors <- majors %>% arrange(desc(Total)) %>% select(Major, Total)
all_majors$Major[1] <- gsub('BUSINESS MANAGEMENT AND ADMINISTRATION', 'BUSINESS MGMT', all_majors$Major[1])
colnames(all_majors)[2] <- "freq"
colnames(all_majors)[1] <- "word"


# Reads in Recent Grads data file 
recent_grads <- read.csv("data/recent-grads.csv", stringsAsFactors = FALSE)
gender_grads1 <- recent_grads %>%
  select(Men, Women, Major)

all_majors <- majors %>% arrange(desc(Total)) %>% select(Major, Total)
all_majors$Major[1] <- gsub('BUSINESS MANAGEMENT AND ADMINISTRATION', 'BUSINESS MGMT', all_majors$Major[1])
