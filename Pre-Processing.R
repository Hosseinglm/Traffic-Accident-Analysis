library(knitr)
library(ggplot2)
library(tidyverse)
library(dplyr)
library(readr)
library(Amelia)

df1 <- read.csv("traffic_Accident.csv",header =T,na.strings=c(""))
head(df1)


glimpse(df1)
any(is.na(df1))
missmap(df1)


colSums(is.na(df1)|df1=='')
#Impute the missing "Accident_Severity" value by the mean of the feature
df1$Accident_severity[is.na(df1$Accident_severity)==TRUE] = round(mean(df1$Accident_severity, na.rm = TRUE))


#Impute the missing "Age_Categories" values by the Mode the feature

getmode <- function(a) {
  uniqage <- unique(a)
  uniqage[which.max(tabulate(match(a, uniqage)))]
}

df1$Age_Categories[is.na(df1$Age_Categories)==TRUE]= getmode(df1$Age_Categories)
print( getmode(df1$Age_Categories))
#Impute the missing "Educational_level" values by the Mode function of column.
df1$Educational_level[is.na(df1$Educational_level)==TRUE]= getmode(df1$Educational_level)
print( getmode(df1$Educational_level))

#Impute the missing "Driving_experience" values by the Mode function of column.
df1$Driving_experience[is.na(df1$Driving_experience)==TRUE] = getmode(df1$Driving_experience)
print(getmode(df1$Driving_experience))

#Impute the missing "Lanes_or_Medians" values by the Mode function of column.
df1$Lanes_or_Medians[is.na(df1$Lanes_or_Medians)==TRUE] = getmode(df1$Lanes_or_Medians)
print(getmode(df1$Lanes_or_Medians))



#Impute the missing "Road_surface_type", "Type_of_collision","Cause_of_accident","Types_of_Junction ","Vehicle_movement","Vehicle_driver_relation","Weather_conditions", "Sex_of_driver" values by the "Unknown" keyword because of
#the importance and high sensitivity of the columns' values in the analysis stage and obviously making a better decision based on them.

df1$Road_surface_type[is.na(df1$Road_surface_type)==TRUE]= "Unknown"

df1$Type_of_collision[is.na(df1$Type_of_collision)==TRUE]= "Unknown"

df1$Cause_of_accident[is.na(df1$Cause_of_accident)==TRUE]= "Unknown"

df1$Types_of_Junction [is.na(df1$Types_of_Junction )==TRUE]= "Unknown"

df1$Vehicle_movement[is.na(df1$Vehicle_movement)==TRUE]= "Unknown"

df1$Vehicle_driver_relation[is.na(df1$Vehicle_driver_relation)==TRUE]= "Unknown"

df1$Weather_conditions[is.na(df1$Weather_conditions)==TRUE]= "Unknown"

df1$Sex_of_driver[is.na(df1$Sex_of_driver)==TRUE]= "Unknown"


colSums(is.na(df1)==TRUE|df1=='')


dim(df1)

write.csv(df1, file = "traffice_Accident_Cleaned.csv")


