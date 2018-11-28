library(tidyverse)
library(ggplot2)
theme_set(theme_bw())

setwd("/Users/raquelvl/Documents/GitHub/reclamacoes-do-gf/")

avaliacoes  <- read_csv("data/3-avaliacao-humana/avaliacoes-20180610.csv")
reclamacoes <-  read_csv("data/1-reclamacoes-selecionadas/reclamacoes-avaliadas.csv")

#inserindo colunas comprimento da reclamacao e do titulo
reclamacoes <- reclamacoes %>% mutate(reclamacao.length = str_length(reclamacao), titulo.length = str_length(titulo))

# insere coluna com número de letras em capslock
reclamacoes$numero.de.capslock <- str_count(reclamacoes$reclamacao, "\\b[A-Z]{2,}\\b")

# insere coluna com número de exclamações no titulo e na reclamação
reclamacoes$numero.de.exclamacoes <- str_count(reclamacoes$reclamacao, "!")

# cria um data frame para cada orgão
reclamacoes_anac <- filter(reclamacoes, reclamacoes$orgao=="anac-agencia-nacional-de-aviacao-civil")
reclamacoes_inss <- filter(reclamacoes, reclamacoes$orgao=="inss-ministerio-da-previdencia-social")

# Das avaliações realizadas, quantas foram feitas para cada nível de insatisfação?
(ggplot(avaliacoes, aes(x=`Grau de insatisfação`))
+geom_bar(width=0.5)
+labs(title="Número de avaliações por grau de insatisfação", x="Grau de insatisfação", y="Quantidade de avaliações")
)

# Ver nota média das medianas da ANAC e do INSS
mean(reclamacoes_anac$mediana)
mean(reclamacoes_inss$mediana)

# Ver proporção do tamanho da reclamação para cada nível de insatisfação em relação a ANAC e INSS
(ggplot(reclamacoes, aes(x=mediana, y=reclamacao.length, colour=orgao))
+geom_point()
+labs(title="Tamanho das reclamações por grau de insatisfação", x="Grau de insatisfação geral", y="Quantidade de caracteres da reclamação")
+facet_grid(orgao ~ .)
)
cor_anac <- cor(reclamacoes_anac$mediana, reclamacoes_anac$reclamacao.length)
cor_inss <- cor(reclamacoes_inss$mediana, reclamacoes_inss$reclamacao.length)
mat <- matrix(c(cor_anac, cor_inss), nrow=1, ncol=2)
colnames(mat) <- c("cor_anac", "cor_inss")
mat

# Ver proporção da quantidade de exclamações pra cada nível de insatisfação em relação a ANAC e INSS
(ggplot(reclamacoes, aes(x=mediana, y=numero.de.exclamacoes, colour=orgao))
+geom_point()
+labs(title="Quantidade de exclamações por grau de insatisfação", x="Grau de insatisfação geral", y="Quantidade de exclamações")
+facet_grid(orgao ~ .)
)
cor_anac <- cor(reclamacoes_anac$mediana, reclamacoes_anac$numero.de.exclamacoes)
cor_inss <- cor(reclamacoes_inss$mediana, reclamacoes_inss$numero.de.exclamacoes)
mat <- matrix(c(cor_anac, cor_inss), nrow=1, ncol=2)
colnames(mat) <- c("cor_anac", "cor_inss")
mat

# Ver proporção da quantidade de letras maiúsculas pra cada nível de insatisfação em relação a ANAC e INSS
(ggplot(reclamacoes, aes(x=mediana, y=numero.de.capslock, colour=orgao))
+geom_point() 
+labs(title="Quantidade de letras em caixa alta por grau de insatisfação", x="Grau de insatisfação geral", y="Quantidade de palavras em caixa alta")
+facet_grid(orgao ~ .)
)
cor_anac <- cor(reclamacoes_anac$mediana, reclamacoes_anac$numero.de.capslock)
cor_inss <- cor(reclamacoes_inss$mediana, reclamacoes_inss$numero.de.capslock)
mat <- matrix(c(cor_anac, cor_inss), nrow=1, ncol=2)
colnames(mat) <- c("cor_anac", "cor_inss")
mat
