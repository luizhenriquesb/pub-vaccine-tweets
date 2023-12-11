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

# Base só com os tweets que tiveram discordancia
base_completa |> 
  filter(tweet_id %in% tt_revisao) |> 
  distinct(tweet_id, content) |> 
  arrange(tweet_id) -> tt_para_revisar

tt_para_revisar

# Salvando na area de transferencia a base acima para colar no excel
library(clipr)
write_clip(tt_para_revisar)

# Classficacao que fiz na ultima rodada (que teve +100 tweets)
minha_classificacao <- read_csv("dados/COVID-19 Vaccine Tweets - Sentimento - luizh.batista@usp.br - getting_examples.csv") |> 
  select(tweet_id, content, sentimento_geral, sarcasmo, sentimento_palavra,
         dificuldade, emocao)

minha_classificacao

# Classificao que fiz filtrada pelos tweets que tiveram discordancia com as outras classificacoes
minha_classificacao |> 
  filter(tweet_id %in% tt_revisao) -> minha_classificacao

# Base completa filtrada pelos tweets que tiveram discordancia e sem as minhas classificacoes
# base_completa |> 
#   select(tweet_id, sentimento_geral, avaliador) |> 
#   filter(tweet_id %in% tt_revisao) |> 
#   filter(avaliador != "luizh.batista@usp.br") -> base_completa

base_completa_filtrada <- base_completa |> 
  select(tweet_id, content, sentimento_geral, avaliador) |> 
  filter(tweet_id %in% tt_revisao)

# Base somente com os tweets que eu e a evelyn discordamos
base_completa_filtrada |> 
  pivot_wider(
    names_from = avaliador,
    values_from = sentimento_geral
  ) |> 
  filter(`evelynrosa@usp.br` != `luizh.batista@usp.br`) |> view()
  
  