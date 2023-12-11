library(tidyverse)
library(readxl)

# Vetor de tt para revisao
tt_revisao <- read_excel("dados/resultado_parcial_081223_tweets_p_revisar.xlsx", 
                                                        sheet = "tweets para revisar") |> 
  janitor::clean_names() |> 
  filter(freq == 3) |> 
  pull(id)

tt_revisao

# Base completa: todos os tt revisados por todos os revisores
base_completa <- read_excel("dados/resultado_parcial_081223_tweets_p_revisar.xlsx", 
                                                        sheet = "Base completa") |> 
  janitor::clean_names()

base_completa

# Base completa filtrada pelos tweets que precisam ser revistos, ou seja, que
# tiveram discordancia
base_completa_filtrada <- base_completa |> 
  select(tweet_id, content, sentimento_geral, avaliador) |> 
  filter(tweet_id %in% tt_revisao)

base_completa_filtrada

# Base somente com os tweets que eu e a evelyn discordamos
base_completa_filtrada |> 
  pivot_wider(
    names_from = avaliador,
    values_from = sentimento_geral
  ) |> 
  filter(`evelynrosa@usp.br` != `luizh.batista@usp.br`)
  