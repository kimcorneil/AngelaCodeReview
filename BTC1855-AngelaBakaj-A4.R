### BTC1855 ASSIGNMENT 4
### ANGELA BAKAJ

library(dplyr)
library(tidyr)

# Reading in the UFO sightings dataset 

ufo_dataset <- read.csv("~/Downloads/ufo_subset.csv", header = TRUE)
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




# Removing the Hoax sightings:
# 






