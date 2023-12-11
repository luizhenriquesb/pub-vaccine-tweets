library(tidyverse)
library(wordcloud)

df <- read_delim("dados/COVID-19 Vaccine Tweets - Sentimento - luizh.batista@usp.br - getting_examples.csv")

# Horizontal version MODELO ------------------------------------------------
ggplot(df, aes(x=x, y=y)) +
  geom_segment( aes(x=x, xend=x, y=0, yend=y), color="skyblue") +
  geom_point( color="blue", size=4, alpha=0.6) +
  theme_light() +
  coord_flip() +
  theme(
    panel.grid.major.y = element_blank(),
    panel.border = element_blank(),
    axis.ticks.y = element_blank()
  )
# --------------------------------------------------------------------------

df |>
  filter(sentimento_geral == "Positivo") |> 
  separate_longer_delim(
    cols = emocao,
    delim = ", "
  ) |>
  count(emocao) |> 
  drop_na() |>
  arrange(n) |> pull(emocao) -> vector

df |>
  filter(sentimento_geral == "Positivo") |> 
  separate_longer_delim(
    cols = emocao,
    delim = ", "
  ) |> 
  count(emocao) |> 
  drop_na() |> 
  mutate(emocao = fct(emocao, levels = vector)) |> 
  ggplot() +
  aes(x = emocao, y = n) +
  geom_segment(aes(x = emocao, xend = emocao, y = 0, yend = n)) +
  geom_point() +
  theme_light() +
  coord_flip()

df |>
  filter(sentimento_geral == "Positivo") |> 
  count(emocao) |> 
  separate_longer_delim(
    cols = emocao,
    delim = ","
    ) |>
  drop_na() |>
  mutate(emocao = fct(emocao, levels = vector)) |> 
  ggplot() +
  aes(x = emocao, y = n) +
  geom_segment(aes(x = emocao, xend = emocao, y = 0, yend = n)) +
  geom_point() +
  theme_light() +
  coord_flip()


#######################

theme_set(theme_classic(base_family = "Calibri"))

theme_update(
  axis.line = element_line(color = "black", linewidth = .6),
  axis.ticks = element_line(color = "black", linewidth = .6),
  #axis.title.y = element_blank(),
  axis.text = element_text(size = 11, color = "black"),
  plot.margin = margin(10, 15, 10, 15),
  plot.subtitle = element_text(colour = "grey30")
)


df |> 
  select(sentimento_geral, emocao) |>
  separate_longer_delim(
    cols = emocao, 
    delim = ", "
  ) |> 
  count(sentimento_geral, emocao) |> 
  drop_na() |> 
  arrange(n) |> 
  mutate(emocao = stringi::stri_trans_general(emocao, "Latin-ASCII")) |> 
  pull(emocao) -> vector

df |> 
  select(sentimento_geral, emocao) |>
  separate_longer_delim(
    cols = emocao, 
    delim = ", "
  ) |> 
  count(sentimento_geral, emocao) |> 
  drop_na() |> 
  mutate(emocao = stringi::stri_trans_general(emocao, "Latin-ASCII"),
         emocao = fct(emocao, levels = vector)) |> 
  ggplot() +
  aes(x = emocao, y = n, color = sentimento_geral) +
  geom_segment(aes(x = emocao, xend = emocao, y = 0, yend = n),
               size = .8,
               #colour = "curve"
               #lineend = "round",
               #linewidth =1
               ) +
  geom_point(aes(
    #colour = "orange"
    )
    ) +
  coord_flip() +
  scale_y_continuous(breaks = seq(0,10, by =1)) +
  scale_color_manual(values = c("grey20", "grey60")) +
  labs(
    title = "Emotions",
    subtitle = "Associated with negative and positive sentiments",
    x = "",
    y = "",
    color = "Sentimento geral"
  ) +
  theme(
    legend.position = c(.905, 0.1)
  )
  
