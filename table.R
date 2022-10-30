library(tidyverse)
library(ggplot2)
library(gt)
library(purrr)
library(janitor)

# load in data
pokemon_df <- read_csv("pokemon-data.csv")

types_df <- read_csv("pokemon-types.csv")

pokemon_info <- read_csv("pokemon-info.csv")

# clean data for join
types_df$dex_id <- gsub("#", "", types_df$dex_id)

types_df$dex_id <- as.numeric(types_df$dex_id)

# join data frames
joined_df <- pokemon_df %>%
  inner_join(types_df, by = c("dex_id" = "dex_id")) %>%
  select(image, dex_id, pokemon, total, hp, attack, defense, sp_atk, sp_def, speed, type_1, type_2) %>%
  inner_join(pokemon_info, by = c("dex_id" = "dex_id")) %>%
  mutate(Image = image, ID = dex_id, Name = pokemon, Attack = attack, Defense = defense, HP = hp, Height = height_m, Weight = weight_kg, One = type_1, Two = type_2) %>%
  select(Image, ID, Name, One, Two, Attack, Defense, HP, Height, Weight)

# create filter
fav_mon <- c(113, 131, 870, 221, 248, 376, 473)

# prepare data for table
favorite_df <- joined_df %>%
  filter(ID %in% fav_mon)
favorite_df %>%
  gt() %>%
  tab_header(title = "My Favorite Pokémon") %>%
  text_transform(
    #Apply a function to a column
    locations = cells_body(c(Image)),
    fn = function(x) {
      #Return an image of set dimensions
      web_image(url = x, height = 50)}) %>%
  tab_spanner(label = md("<br> **Pokémon Info**"), columns = 1:3) %>%
  tab_spanner(label = md("<br> **Types**"), columns = 4:5) %>%
  tab_spanner(label = md("<br> **Stats**"), columns = 6:8) %>%
  tab_spanner(label = md("**Size** <br> *m* | *kg*"), columns = 9:10) %>%
  tab_style(
    style = cell_text(
      font = google_font("Saira"), 
      align = "left", 
      size = "xx-large"
    ),
    locations = cells_title("title")) %>%
  tab_style(
    style = cell_text(
      font = google_font("Ubuntu"), 
      size = "large"
    ),
    locations = list(
      cells_column_labels(everything()), 
      cells_body(columns = 1)
    ))