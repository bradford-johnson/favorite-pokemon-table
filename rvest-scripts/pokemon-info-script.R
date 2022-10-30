library(rvest)
library(tidyverse)
library(stringr)

link <- "https://pokemondb.net/pokedex/stats/height-weight" 

page <- read_html(link) 

dex_id <- page %>%
  html_nodes(".infocard-cell-data") %>%
  html_text()

height_m <- page %>%
  html_nodes(".cell-num:nth-child(5)") %>%
  html_text()

weight_kg <- page %>%
  html_nodes(".cell-num:nth-child(7)") %>%
  html_text()

pokemon_info <- data.frame(dex_id, height_m, weight_kg)

write_csv(pokemon_info, "pokemon-info.csv")