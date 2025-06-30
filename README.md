# 🎯 Segmentação de Consumidores para Campanhas Customizadas de Marketing

Este projeto tem como objetivo identificar **grupos de consumidores com perfis semelhantes** para apoiar **campanhas de marketing personalizadas**. Utilizando algoritmos de **Clustering (K-Means)** em R, exploramos dados de clientes para encontrar padrões de comportamento que auxiliem em estratégias mais eficazes de marketing.

---

## 📊 Objetivo

> Encontrar segmentos de consumidores com base em suas características (idade, salário e pontuação de gasto) para campanhas de marketing mais assertivas.

---

## 🛠️ Tecnologias e Pacotes

- Linguagem: **R**
- Principais pacotes:
  - `factoextra`, `cluster`, `fpc`, `NbClust`, `clValid`, `eclust`, `hopkins`
- Visualizações: histogramas, boxplots, clusplots, fviz_cluster

---

## 🔍 Etapas do Projeto

### 1. Análise Exploratória
- Distribuição de sexo, idade e pontuação de gasto
- Comparações por gênero: média salarial e pontuação

### 2. Pré-processamento
- Remoção de variáveis não numéricas
- Padronização dos dados

### 3. Tendência de Agrupamento
- Estatística de Hopkins aplicada
- Identificação de "clusterizabilidade"

### 4. Escolha do Número Ideal de Clusters
- Usamos métodos `silhouette` e `NbClust`
- Resultado: 4 clusters definidos

### 5. Modelagem com K-Means
- Modelo treinado com 4 clusters
- Cada cliente foi atribuído a um grupo

### 6. Análise dos Grupos
- Média de idade, salário e pontuação por cluster
- Perfil detalhado por sexo e comportamento

### 7. Visualizações
- Plots de dispersão por cluster
- fviz_cluster (factoextra)
- clusplot com destaque por grupo

---

## 📌 Principais Insights

- 💰 **Clientes com maiores salários tendem a ter menor pontuação de gasto**
- 👩 **O cluster com maior pontuação de gasto tem maioria feminina e salário menor**
- 🎯 **Segmentos bem definidos podem gerar campanhas mais eficazes e personalizadas**

---

## 📂 Estrutura dos Arquivos

| Arquivo                      | Descrição                                         |
|-----------------------------|---------------------------------------------------|
| `dados_clientes.csv`        | Base de dados com informações de consumidores     |
| `segmentacao_clientes.R`    | Script principal com EDA, clustering e visualizações |
| `README.md`                 | Descrição do projeto                              |

---

## 🚀 Próximos Passos

- Aplicar modelos em dados reais de campanhas
- Avaliar conversões por cluster
- Integrar com dashboards em Power BI ou Shiny

---

## 💡 Sobre Mim

👩‍💻 Olá! Sou Thayla Oliveira, apaixonada por transformar dados em decisões.  
Este projeto faz parte da minha jornada prática em Data Science e Marketing Analytics.

📫 Vamos conectar?  
[![LinkedIn](https://img.shields.io/badge/-LinkedIn-0A66C2?logo=linkedin&logoColor=white)](https://www.linkedin.com/in/thaylaoliveira)  
🌐 [Meu GitHub](https://github.com/ThaylaOliveira)

---
