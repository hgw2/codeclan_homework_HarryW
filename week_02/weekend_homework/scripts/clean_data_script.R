# Packages ----------------------------------------------------------------

library(tidyverse)
library(janitor)
library(assertr)

# Read in data ------------------------------------------------------------

meteorite_landings <- read_csv("raw_data/meteorite_landings.csv")

meteorite_landings %>%
  verify(names(meteorite_landings) == c(
    "id",
    "name",
    "mass (g)",
    "fall",
    "year",
    "GeoLocation"
  )
  )

# Clean names ----------------------------------------------------------

meteorite_landings_clean <- clean_names(meteorite_landings)


# Split GeoLocation  ------------------------------------------------------

meteorite_landings_clean <- meteorite_landings_clean %>%
  mutate(geo_location = str_remove_all(geo_location, "\\(")) %>%
  mutate(geo_location = str_remove_all(geo_location, "\\)")) %>%
  separate(
    col = geo_location,
    into = c("latitude", "longitude"),
    sep = ", "
  ) %>%
  mutate(
    latitude = as.numeric(latitude),
    longitude = as.numeric(longitude)
  )




# Replace NAs -------------------------------------------------------------

meteorite_landings_clean <- meteorite_landings_clean %>%
  mutate(
    longitude =
      if_else(longitude > 180, NaN, longitude),
    longitude =
      if_else(longitude < -180, NaN, longitude),
    latitude =
      if_else(latitude > 90, NaN, latitude),
    latitude =
      if_else(latitude < -90, NaN, latitude)
  ) %>%
  mutate(
    latitude = coalesce(latitude, 0),
    longitude = coalesce(longitude, 0)
  )

meteorite_landings_clean %>%
  verify(latitude >= -90 & latitude <= 90) %>%
  verify(longitude >= -180 & longitude <= 180)

# Remove meteorites less than 1000g ---------------------------------------

meteorite_landings_clean_kg <- meteorite_landings_clean %>%
  filter(mass_g >= 1000)



# Order years -------------------------------------------------------------

meteorite_landings_clean_kg <- meteorite_landings_clean_kg %>%
  arrange(year)


meteorite_landings_clean <- meteorite_landings_clean %>%
  arrange(year)


# write CSV ---------------------------------------------------------------

meteorite_landings_clean_kg %>%
  write_csv("clean_data/meteorite_landings_clean_kg.csv")

meteorite_landings_clean %>%
  write_csv("clean_data/meteorite_landings_clean.csv")
