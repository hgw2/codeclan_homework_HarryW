# Packages ----------------------------------------------------------------

library(tidyverse)
library(janitor)
library(assertr)

# 1. Read in data ------------------------------------------------------------

meteorite_landings <- read_csv("raw_data/meteorite_landings.csv")


# 2. Clean names ----------------------------------------------------------

meteorite_landings_clean <- clean_names(meteorite_landings)


# Split GeoLocation  ------------------------------------------------------

meteorite_landings_clean <- meteorite_landings_clean %>% 
  mutate(geo_location = str_remove_all(geo_location, "\\(")) %>% 
  mutate(geo_location = str_remove_all(geo_location, "\\)")) %>% 
  separate(col = geo_location, 
           into = c("latitude", "longitude"), 
           sep =", ") %>% 
  mutate(latitude = as.numeric(latitude), 
         longitude = as.numeric(longitude))
  

# Replace NAs -------------------------------------------------------------

meteorite_landings_clean <- meteorite_landings_clean %>% 
mutate(
  latitude = coalesce(latitude, 0),
  longitude = coalesce(longitude, 0)
) 
