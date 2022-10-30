library(rvest)
library(tidyverse)
library(stringr)

link <- "https://pokemondb.net/pokedex/national" 

page <- read_html(link) 

dex_id <- page %>%
  html_nodes("small:nth-child(1)") %>%
  html_text()

pokemon <- page %>%
  html_nodes(".ent-name") %>%
  html_text()

types <- page %>%
  html_nodes("br+ small") %>%
  html_text()

pokemon_types_df <- data.frame(dex_id, pokemon, types)

pokemon_types_df[c("type_1", "type_2")] <- str_split_fixed(pokemon_types_df$types, " · ", 2)

pokemon_types_df <- pokemon_types_df %>%
  select(dex_id, pokemon, type_1, type_2)

write_csv(pokemon_types_df, "pokemon-types.csv")