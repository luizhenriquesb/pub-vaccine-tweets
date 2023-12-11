
df |>
  filter(sentimento_geral == "Positivo") |> 
  separate_longer_delim(
    cols = emocao,
    delim = ", "
  ) |> 
  count(emocao) |> 
  drop_na() |>  pull(n) -> freq

df |>
  filter(sentimento_geral == "Positivo") |> 
  separate_longer_delim(
    cols = emocao,
    delim = ", "
  ) |> 
  count(emocao) |> 
  drop_na() |>  pull(emocao) -> palavras

par()
wordcloud(palavras, freq, min.freq = 1, colors = "white", random.order = FALSE)

library(wordcloud2)

df |>
  filter(sentimento_geral == "Positivo") |> 
  separate_longer_delim(
    cols = emocao,
    delim = ", "
  ) |> 
  count(emocao) |> 
  drop_na() |> arrange(desc(n)) -> positive

wordcloud2::wordcloud2(data = positive, 
                       size = .85, 
                       minSize = 0,
                       #gridSize = 2,
                       minRotation = 0,
                       maxRotation = 0,
                       color = "darkgrey")

df |>
  filter(sentimento_geral == "Negativo") |> 
  separate_longer_delim(
    cols = emocao,
    delim = ", "
  ) |> 
  count(emocao) |> 
  drop_na() |> arrange(desc(n)) -> negative

wordcloud2::wordcloud2(data = negative, 
                       size = .7,
                       #minSize = "aadadsdasd",
                       #gridSize = 2,
                       minRotation = 0,
                       maxRotation = 0,
                       color = "darkgrey")

#########
df |>
  separate_longer_delim(
    cols = emocao,
    delim = ", "
  ) |> 
  count(emocao) |> 
  drop_na() |> arrange(desc(n)) -> dfFreq

test <- tibble(
  col1 = c("a", "b", "c"),
  col2 = c("neg", "neg", "pos"),
  freq = c(2, 5, 9)
)

wordcloud2::wordcloud2(data = test |> select(col1, freq), color = "darkgrey")
