library(tidyverse)
library(rvest)
library(stringr)

#setwd("/Users/raquelvl/Documents/raquel/disciplinas/2018.1/MC/projeto/reclamacoes-do-gf-master/")

avaliacoes <- read_csv("data/avaliacoes/avaliacoes-20180610.csv")

glimpse(avaliacoes)

avaliacoes <- avaliacoes %>% select(matricula = "Matricula", 
                                    id.reclamacao = "ID da reclamação", 
                                    avaliacao = "Grau de insatisfação")

avaliacoes <- avaliacoes %>% select(id.reclamacao, avaliacao) %>% 
              group_by(id.reclamacao) %>% 
              summarise(mediana=median(avaliacao))

reclamacoes.avaliadas <- read_csv("data/avaliacoes/reclamacoes-avaliar.csv")

names(reclamacoes.avaliadas)
names(avaliacoes)

reclamacoes.avaliadas <- reclamacoes.avaliadas %>% select(-X1)

reclamacoes <- left_join(reclamacoes.avaliadas, avaliacoes, 
                         by = c("id" = "id.reclamacao"))

reclamacoes %>%  write_csv("data/reclamacoes-raw/reclamacoes-avaliadas.csv")
