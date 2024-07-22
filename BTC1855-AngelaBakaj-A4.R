### BTC1855 ASSIGNMENT 4
### ANGELA BAKAJ

## REVIEWER COMMENTS ##
#' Good job! Everything ran smoothly
#' Your explanations were clear and I liked the use of logical reasoning when cleaning up the length of a UFO sighting column
#' Your removal of potential hoaxes was simple and well communicated, good job! The only suggestion I would have is to further
#' justify by removing based off of "NUFORC" instead of hoax (that dataset does make this diffuclt as sometimes NUFORC comments
#' do not specify if they think it was a hoax but othertimes the word hoax is missing) but a bit more justifcation may have been helpful
#' For the histogram was there a reason you used log base e (log in R) vs log base 10? 
#' Overall great work!

library(dplyr)
library(tidyr)
library(stringr)
library(lubridate)

# Reading in the UFO sightings dataset 
ufo_dataset <- read.csv("~/Downloads/ufo_subset.csv", header = TRUE)
# Assessing the dataset visually:
View(ufo_dataset)
head(ufo_dataset, 10)


# Seeing that there are missing values, I want to assign these as NAs
ufo_dataset[ufo_dataset == ""] <- NA


# Checking "Country" 
# The missing values were already accounted for in the previous step.
# I want to now check if there are any illegitimate entries for the countries.
unique(ufo_dataset$country)
# Using the "unique" function, I see that there are valid country entries: US, GB, CA, AU, DE.

# Checking "Shape"
# I will check for any illegitimate entries in the shape column as well.
unique(ufo_dataset$shape)
# Using the "unique" function again, I do not identify any invalid shape entries, other than the missing values I already accounted for. 
# These missing values could be the result of failure to record known shapes OR that the shapes of these sighting were truly unknown.

# Checking "Duration Seconds"
# First, I'll check if there were any NAs in the "duration.seconds" column to begin with.
which(is.na(ufo_dataset$duration.seconds))
# Using the "range" function, I see that there exists extremely small and large values.
range(ufo_dataset$duration.seconds)
# Logically speaking, a UFO sighting should not last longer than a few minutes, on average (according to Google)
# For good measure, I will extend this window of time to say, 8 hours; any duration longer than this is likely an inconsistent result.
new_duration.seconds <- filter(ufo_dataset, ufo_dataset$duration.seconds < 28800)
new_duration.seconds


# Removing the Hoax sightings:
# I will subset the "comments" section to exclude the sightings identified by NUFORC.
# Note: I am using the "str_detect" function to select these hoax sightings commented by NUFORC.
new_comments <- filter(new_duration.seconds, !str_detect(comments, "NUFORC"))


# Adding "report_delay" column to the dataset and populate it with the following measurement for each observation:
# The time difference in days, between the date of the sighting and the date it was reported.

# First, I need to convert both "datetime" and "date_posted" to POSIX format.
new_comments$datetime <- as.POSIXct(ymd_hm(new_comments$datetime))
new_comments$date_posted <- as.POSIXct(dmy(new_comments$date_posted))                                  

# Now, I will add the new column "report_delay" using the "mutate" function and taking the difference between the two newly converted POSIX dates:
ufo_dataset2 <- mutate(new_comments, 
                   report_delay = new_comments$date_posted - new_comments$datetime)

# The values given in the new "report_delay" column are in seconds, I want to convert this to days:
# Note: each day contains 86400 seconds
ufo_dataset3 <- ufo_dataset2
ufo_dataset3$report_delay <- as.numeric(ufo_dataset3$report_delay / 86400)

# Removing the rows where the sighting was reported before it happened:
# Note: Logically, this would remove the negative values in the newly created "report_delay" column.
ufo_dataset4 <- filter(ufo_dataset3, report_delay > 0)


# Creating a table with the average report_delay per country:
# I am using the "summarize" and "group_by" functions to create this table from the data frame.
rp_per_country <- summarize(group_by(ufo_dataset4, country), average = mean(report_delay))

# Creating a histogram using the 'duration seconds' column:
# Note: due to the highly skewed nature of the dataset, I made the choice to take the logarithm of the dataset using the "log" function
# The log helps to compress the very large values, making the smaller values more visable in the histogram.
# I labelled the histogram and its axis for increased clarity and readability.
hist(log(new_duration.seconds$duration.seconds), xlab = "Duration in Seconds", ylab = "Frequency", main = "Histogram of the Durations(sec) of UFO Sightings")

