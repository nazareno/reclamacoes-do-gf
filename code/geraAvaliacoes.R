library(tidyverse)
library(rvest)
library(stringr)

setwd("/Users/raquelvl/Documents/GitHub/reclamacoes-do-gf/")

avaliacoes <- read_csv("data/3-avaliacao-humana/avaliacoes-20180610.csv")

glimpse(avaliacoes)

avaliacoes <- avaliacoes %>% select(matricula = "Matricula", 
                                    id.reclamacao = "ID da reclamação", 
                                    avaliacao = "Grau de insatisfação")

avaliacoes <- avaliacoes %>% select(id.reclamacao, avaliacao) %>% 
              group_by(id.reclamacao) %>% 
              summarise(mediana=median(avaliacao))

reclamacoes.avaliadas <- read_csv("data/1-reclamacoes-selecionadas/reclamacoes-avaliadas.csv")

names(reclamacoes.avaliadas)
names(avaliacoes)


reclamacoes <- left_join(reclamacoes.avaliadas, avaliacoes, 
                         by = c("id" = "id.reclamacao"))

reclamacoes %>%  write_csv("data/1-reclamacoes-selecionadas/reclamacoes-avaliadas.csv")
