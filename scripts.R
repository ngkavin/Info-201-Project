# Global variables and functions are defined here to reduce clutter in server.R

all_ages <- read.csv("data/all-ages.csv", stringsAsFactors = FALSE)
grad <- read.csv("data/grad-students.csv", stringsAsFactors = FALSE)
women_stem <- read.csv("data/women-stem.csv", stringsAsFactors = FALSE)

# Entries are given in all caps. This will change the major names to be in "title case"
majors_list <- sapply(tolower(grad$Major), tools::toTitleCase)
majors_list <- as.data.frame(majors_list, stringsAsFactors = FALSE)$majors_list
# Function picks a major from the majors_list at random and returns it.
get_random_major <- function(m_list) {m_list[sample(1:length(m_list), 1)]}

# Filters out the all_ages dataset to just Majors and their total in descending order
majors <- select(all_ages, Major, Major_category, Total)
all_majors <- majors %>% arrange(desc(Total)) %>% select(Major, Total)
all_majors$Major[1] <- gsub('BUSINESS MANAGEMENT AND ADMINISTRATION', 'BUSINESS MGMT', all_majors$Major[1])
colnames(all_majors)[2] <- "freq"
colnames(all_majors)[1] <- "word"

# Entries are given in all caps. This will change the stem major names to be in "title case"
stem_majors_list <- sapply(tolower(women_stem$Major), tools::toTitleCase)
stem_majors_list <- as.data.frame(stem_majors_list, stringsAsFactors = FALSE)$stem_majors_list
# Function picks a major from the stem_majors_list at random and returns it.
select_stem_choices <- split(stem_majors_list, women_stem$Major_category)

# Splits majors categories
select_choices <- split(majors_list, grad$Major_category)
select_choices_stem <- split(stem_majors_list, women_stem$Major_category)

# Selects the Men and Women column in STEM Majors
gender_stem_grads <- women_stem %>% select(Men, Women, Major)

# Reads in Recent Grads data file 
recent_grads <- read.csv("data/recent-grads.csv", stringsAsFactors = FALSE)
gender_grads1 <- recent_grads %>%
  select(Men, Women, Major)

# color palette for word cloud
w_color <-c(
  "#64EDD9",
  "#5FE6CD",
  "#5AE0C1",
  "#55D9B5",
  "#50D3A9",
  "#4BCC9D",
  "#46C691",
  "#41BF85",
  "#3CB979",
  "#37B36D",
  "#32AC61",
  "#2DA655",
  "#289F49",
  "#1E9231",
  "#198C25",
  "#15861A"
)