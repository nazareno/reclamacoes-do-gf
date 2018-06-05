# Análise de sentimento de reclamações do Governo Federal 

Análise da precisão de métodos de análise de sentimentos para estimar o grau de insatisfação nas reclamações recebidas pelos órgãos do Gov Federal via ReclameAqui.

## O projeto

Há três fontes de dados para o projeto: 

1. Um conjunto conteúdos de reclamações raspados do ReclameAqui, 
2. Avaliações do grau de insatisfação feitas por voluntários, e 
3. Estimativas da instatisfação derivadas de métodos de análise de sentimento.

## Organização desse repositório

* `data/` - Todos os dados do projeto
    * `data/0-reclamacoes-raw` - Conteúdos de reclamações raspados do ReclameAqui
    * `data/1-reclamacoes-selecionadas` - Reclamações selecionadas dentre as raspadas, com colunas úteis para o experimento
    * `data/2-avaliacao-humana-preliminar` - Avaliação da insatisfação feita por um grupo de voluntários em um conjunto pequeno de reclamações para verificar se há concordância. 
    * `data/3-avaliacao-humana` - Avaliação da insatisfação feita por humanos no conjunto de reclamações em `data/1-reclamacoes-selecionadas`
    * `data/4-estimativa-automatica` - Estimativa via algoritmos da insatisfação nas reclamações em `data/1-reclamacoes-selecionadas`

## Dependências

O código é em R. Rode: 

```
deps = c("tidyverse", "rvest", "stringr")
install.packages(deps)
```
