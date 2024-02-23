# Segmentação de Consumidores Para Campanhas Customizadas de Marketing
# Objetivo: Encontrar segmentos de consumidores para campanhas personalizadas de Marketing.

# Definindo o diretório de trabalho
getwd()
setwd("C:/FCD/Machine Learning/10. Cluster")

# Pacotes
#install.packages("factoextra")
#install.packages("cluster")
#install.packages("fpc")
#install.packages("NbClust")
#install.packages("clValid")
#install.packages("clustertend")
#install.packages("eclust")
library(factoextra)
library(cluster)
library(fpc)
library(NbClust)
library(clValid)
library(magrittr)
library(hopkins)
library(eclust)

# Carregando os dados
dados_clientes <- read_csv("Cluster-R/dados_clientes.csv")
names(dados_clientes)
str(dados_clientes)
summary(dados_clientes)

# Analise Exploratória

# Proporção dos sexos
table_sex = table(dados_clientes$Sexo)
table_sex
barplot(table_sex,
        main = "Proporção de Sexo dos Clientes",
        ylab = "Total",
        xlab = "Sexo",
        col = rainbow(2),
        legend = rownames(table_sex))

# idade
summary(dados_clientes$Idade)
mean(dados_clientes$Idade)
hist(dados_clientes$Idade,
     main = "Histograma das idades",
     ylab ="frequencia",
     xlab = "idade",
     labels = TRUE)

# Pontuação
summary(dados_clientes$Pontuacao_Gasto)
boxplot(dados_clientes$Pontuacao_Gasto,
        horizontal = TRUE,
        main = "Boxplot das Pontuação dos Gastos")

hist(dados_clientes$Pontuacao_Gasto,
     labels = TRUE)

# Média da salario por sexo
mean_salario <- tapply(dados_clientes$Salario_Mensal_Milhar,dados_clientes$Sexo, mean)

# Méda da pontuação por sexo
mean_pontuação <- tapply(dados_clientes$Pontuacao_Gasto, dados_clientes$Sexo,mean)


# Pre-processamento dos dados

# Remoção da variavel id e sexo
dados_clientes2 <- dados_clientes[,-c(1,2)]
head(dados_clientes2)

# Padronização
dados_clientes2_scaled <- scale(dados_clientes2)
head(dados_clientes2_scaled)

# Avaliando a Tendência de Cluster
# Estatística Hopkins para o conjunto de dados: avalia a distanci entre os pontos de dados
# Valores > .5 significam que o dataset não é "clusterizável"
# Valores < .5 significam que o dataset é "clusterizável"
# Quanto mais próximo de zero, melhor. 
linhas <- nrow(dados_clientes2_scaled)

set.seed(123)
hopkins(dados_clientes2_scaled, n=nrow(dados_clientes2_scaled)-1)
# Valor = 0.3121986 indica que o dataset é "clusteriável"

# K-means - Determinando o Número Ideal de Clusters

# Pacote NbClust: 30 índices para determinar o número de clusters em um conjunto de dados.
# Se index = 'all' - Executa 30 índices para determinar o número ideal de clusters.
# Se index = "silhouette" - Usa uma medida para estimar a diferença entre clusters.
# Um valor de silhueta mais alto é preferido para determinar o número ideal de clusters

# Opção 1:
num_clusters_opt1 <- NbClust(dados_clientes2_scaled,  
                             distance = "euclidean",
                             min.nc = 2, 
                             max.nc = 15, 
                             method = "kmeans",
                             index = "silhouette")

num_clusters_opt1$Best.nc
num_clusters_opt1$All.index


# Opção 2:
num_clusters_opt2 <- NbClust(dados_clientes2_scaled,  
                             distance = "euclidean", 
                             min.nc = 2, 
                             max.nc = 15, 
                             method = "kmeans",
                             index = "all")

# Um método recomenda 6 clusters e o outro recomenda 2. Usaremos 4 clusters.

# Criação do modelo K-Means e Análise de Cluster
modelo <- kmeans(dados_clientes2_scaled,4)
print(modelo)

# Tamanho dos clusters
modelo$size

# Centroides
modelo$centers

# Associando cada cliente a cada cluster
modelo$cluster
dados_clientes$cluster <- modelo$cluster
View(dados_clientes)

# Média de idade por cluster
aggregate(data = dados_clientes, Idade ~ cluster, mean)

# Média de salário por cluster
aggregate(data = dados_clientes, Salario_Mensal_Milhar ~ cluster, mean)

# Média de pontuação de gasto por cluster
aggregate(data = dados_clientes, Pontuacao_Gasto ~ cluster, mean)

### os clientes que possuem maiores salários tem as menores pontuações

# Média de idade e salário por cluster
aggregate(data = dados_clientes, cbind(Idade, Salario_Mensal_Milhar) ~ cluster, mean)

# Total de pessoas por sexo e por cluster
with(dados_clientes, table(Sexo, cluster))

### O grupo 4 tem mais mulheres que homem. E o mesmo grupo que possui
### maior pontuação de gasto mesmo com salário menor. Vale a pena estudar mais a fundo o perfil dessas mulheres


# Plot do Modelo
plot(dados_clientes2_scaled, col = modelo$cluster, pch = 15) 

# Melhorando a Visualização
?eclust
cluster_viz <- eclust(dados_clientes2_scaled, "kmeans", k = 4, nstart = 25, graph = FALSE)

# Visualizando Clusters K-Means
?fviz_cluster
fviz_cluster(cluster_viz, geom = "point", ellipse.type = "norm")

# Outra opção de visualização
?clusplot
par(c(1,1))
clusplot(dados_clientes, dados_clientes$cluster, color=TRUE, shade=TRUE, labels=5, lines=0)

