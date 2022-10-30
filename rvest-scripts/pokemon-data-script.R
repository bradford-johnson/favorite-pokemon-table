library(rvest)
library(tidyverse)

link <- "https://pokemondb.net/pokedex/all" 

page <- read_html(link) 

image <- page %>% 
  html_nodes(".icon-pkmn") %>% 
  html_attr("src")

dex_id <- page %>%
  html_nodes(".infocard-cell-data") %>%
  html_text()

pokemon_name <- page %>% 
  html_nodes(".cell-name") %>% 
  html_text() 

total <- page %>%
  html_nodes(".cell-total") %>%
  html_text()

hp <- page %>%
  html_nodes(".cell-total+ .cell-num") %>%
  html_text()

attack <- page %>%
  html_nodes(".cell-num:nth-child(6)") %>%
  html_text()

defense <- page %>%
  html_nodes(".cell-num:nth-child(7)") %>%
  html_text()

sp_atk <- page %>%
  html_nodes(".cell-num:nth-child(8)") %>%
  html_text()

sp_def <- page %>%
  html_nodes(".cell-num:nth-child(9)") %>%
  html_text()

speed <- page %>%
  html_nodes(".cell-num:nth-child(10)") %>%
  html_text()

pokemon_df <- data.frame(image, dex_id, pokemon_name, total, hp, attack, defense, sp_atk, sp_def, speed)

# write_csv(pokemon_df, "pokemon-data#.csv")    do not run, manual excel cleaning was done after scraping