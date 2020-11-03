library(mosaic)   # Load additional packages here
library(tidyverse)
library(knitr)
library(kableExtra)
library(lubridate)
library(stringr)

RefugeesMigrants <- readr::read_csv(
  "RefugeesAndMigrants.csv"
) %>%
  janitor::clean_names() %>%
  mutate(date_found_dead = as.Date(found_dead, "%d/%m/%y")) %>%
  mutate(inc_men = case_when(
    str_detect(name_gender_age, " man") ~ TRUE,
    str_detect(name_gender_age, "\\(man") ~ TRUE,
    str_detect(name_gender_age, " men") ~ TRUE,
    str_detect(name_gender_age, "\\(men") ~ TRUE,
    str_detect(name_gender_age, " \\(m\\)") ~ TRUE,
    TRUE ~ FALSE),
    inc_women = case_when(
      str_detect(name_gender_age, "wom.n") ~ TRUE,
      TRUE ~ FALSE),
    inc_children = case_when(
      str_detect(name_gender_age, "boy") ~ TRUE,
      str_detect(name_gender_age, "girl") ~ TRUE,
      str_detect(name_gender_age, "child") ~ TRUE,
      str_detect(name_gender_age, "boy") ~ TRUE,
      str_detect(name_gender_age, "baby") ~ TRUE,
      str_detect(name_gender_age, "babies") ~ TRUE,
      str_detect(name_gender_age, "teenager") ~ TRUE,
      str_detect(name_gender_age, "newborn") ~ TRUE,
      TRUE ~ FALSE)
  ) %>% select(date_found_dead, number, region_of_origin, country_of_incident,
               inc_men, inc_women, inc_children, cause_of_death,
               source, name_gender_age, found_dead)

usethis::use_data(RefugeesMigrants)
