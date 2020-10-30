# Packages ----------------------------------------------------------------

library(tidyverse)
library(janitor)
library(assertr)

# 1. Read in data ------------------------------------------------------------

meteorite_landings <- read_csv("raw_data/meteorite_landings.csv")


# 2. Clean names ----------------------------------------------------------

meteorite_landings_clean <- clean_names(meteorite_landings)
