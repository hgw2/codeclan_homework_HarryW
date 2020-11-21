library(readxl)
library(tidyverse)
library(janitor)
library(here)

players <- read_excel(here("raw_data/six_nations_2019.xlsx"), sheet = "players") %>% 
  clean_names()

players_longer <- players %>% 
  select(-(six_nations_won:rpi_score)) %>% 
  relocate(club, .after = player) %>% 
  pivot_longer(six_nations_matches:x2019_red_cards,
               names_to = "stat",
               values_to ="count") %>% 
  drop_na(count)

players_longer %>% 
  write_csv("clean_data/players.csv")