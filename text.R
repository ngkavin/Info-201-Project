# Welcome!
summary <- "This is a preview of what our project is about as it contains:
<ul>Information about the <b>majors</b> that college students have taken</ul>
<ul>Statistics about these students such as a breakdown in <i>gender</i> and <i>wages</i>.</ul>

<br>Three questions that our project will answer are:
<ol>1) What are the employment statistics for a given major?</ol>
<ol>2) What is the male to female ratio for given majors?</ol>
<ol>3) Does the popularity of majors correlate to wages?</ol>

These questions will benefit our <font color = 'green'>target</font> audience which are
<i>students who have yet to declare their major</i> (<i>or incoming college students</i>).<br><br>
This app is based on a college majors data dataset provided by FiveThirtyEight through their
<a href ='https://github.com/fivethirtyeight/data/tree/9e9cee37d0695ccc6866c67f38373675231758ab/college-majors'>Github </a>
repository, with data that originated from the US Census' 2010-2012 
<a href = 'https://www.census.gov/programs-surveys/acs/data/pums.html'>Public Use Microdata Series.</a>"

# Word cloud description
cloud_summary <- "<font size = '2'>Note: The word cloud displayed shows all the majors based on their popularity. The most popular major is
<font color = '#64EDD9'><b>Business Management And Administration</b></font> with <i>3,123,510 students</i>.
The least popular major is <font color = '#64EDD9'><b>School Student Counseling</b></font> with <i>2,396 students</i>.</font>"

# Popularity and Wages
pop1 <- "This graph shows the relationship between the popularity of a major,
and the wages that graduates are earning. The plot can be adjusted to display
the earnings of those who have earned a graduate degree or an undergraduate
degree. The yearly wages can be adjusted to be the 25th, 75th, or 50th percentile
(median) of earnings for their respective major.
<br><br>
Looking at undergraduate <b>median</b> wages, there does <i>not</i> seem to be a
significant correlation with the popularity of a major, and the wages
that the degree holder earns. At the extremes, petroleum engineers
have by far the highest median wage with <b>$126k</b>, but the major ranks
as the <b>134th</b> most popular out of the 173 majors tracked.
Business Management and Administration is <i>by far</i> the most popular major
with just under <b>3 million</b> undergraduate degree holders, but at a median
wage of <b>$60k</b> a year, it is only the 62nd highest earning major. This
by no means is low, but it does not explain the popularity of this
particular major.
<br><br>
There are only <i>22</i> majors with more than 500,000 undergraduate degree
holders, and they earn an average of <b>$58,909.09</b> a year, which is only <b>$325.57</b>
more than the average median wage across all of the majors, <b>$58,583.82</b>, a
0.55% difference.
<br><br>
These results are similar among the graduate degree holders where there is
no significant correlation between the popularity of a major and the wages
earned. The most popular major, Psychology ranks 133 in wages, and the highest
earning major, Health and Medical Preparatory programs, ranks 50th in popularity.
However, graduates do earn more than undergraduates with an average median wage of
<b>$79,363.64</b> compared to <b>$58,909.09</b>, a <b>$20,454.55</b> a year difference.
(29.59% higher).
"

# Gender
gender <- "This pie chart shows the ratio of men to women that are recent college
graduates from a particular major. The pie chart can be adjusted to show the ratio 
of men to women in any of the listed majors the user desires to view.
<br><br>
Looking at the ratio of men to women graduates from <b>engineering</b> majors it seems that
the general trend is that women only make up ~25%, while men make up ~75%. In contrast, the 
ratio of men to women in the <b>social sciences </b> and <b>arts</b> are flipped, where women make up
the majority of those graduates.<br><br>
Overall, as shown on the pie chart <font color = 'red'>women</font> dominate 
<font color = 'blue'>men</font> with all the majors as <i>57.5%</i> of women
are recent college graduates whereas men make up <i>42.5%</i>.<br><br>
However, for STEM Majors only, men dominate by small percentage compared to women as the ratio
for recent college graduates in STEM make up <i>50.2%</i> of men and <i>49.8%</i> of women."

# Employment
employment <- "This bar chart shows the amount of recent graduates that are <b>employed</b> compared to those
that are <b>unemployed</b> based on the major they graduated with. The chart breaks down to those that are
employed full-time, full-time-year-round, and part-time employed.
<br><br>
For the majority of majors listed, students who graduate end up with a full-time job and few students in each
major end up unemployed. These numbers do vary from major to major due to the sample size that was 
collected for each major varying."
