library(tidyverse)

# Ler os arquivos
distance <- read.csv("../Distanciamento/Distanciamento_Especificado.csv")
pib <- read.csv("../PIB_Nominal/PIB_especificado.csv")
export <- read.csv("../Exportações/Valor_Exportacao_Especificado.csv")
Notif <- read.csv("../Notificacoes/Objetivos_Agrupados.csv")
tarif <- read.csv("../Tarifas/Tarifas_Especificadas.csv")


# Retirar colunas indesejadas e renomear colunas em comum com outros dframes
tarif <- tarif %>%
  rename(Country.Name = Country) %>%
  select(c(-"Simple.Average", -"Imports.Value.in.1000.USD"))

# Deixar somente as colunas necessárias
distance <- distance %>%
  select(Country.Code, contig, distw)

# Reter somente os dois primeiros dígitos dos códigos SH
Notif$Commodity.Code <- Notif$Commodity.Code %>%
  substr(0, 2) %>%
  as.numeric()

# Reter somente as observações para os códigos SH relacionados a atividades
# agropecuárias
Notif <- Notif %>%
  filter(Commodity.Code < 16)

# Deixar o PIB em seu valor nominal normal
pib <- pib %>%
  mutate(PIB_.1000_US.. = PIB_.1000_US.. * 1000)

# Unir os data.frames em um só, retirar as observações com valores nulos, 
# transformar as variáveis que precisam ser logaritmadas
df <- left_join(pib, tarif, by = c("Country.Name", "Year")) %>%
  filter(Year > 1996) %>%
  left_join(distance, by = "Country.Code") %>%
  drop_na() %>%
  left_join(export) %>%
  right_join(Notif, by = c("Year", "Country.Code", "Commodity.Code")) %>%
  fill(c(
    "Country.Name", "Country.Code", "PIB_.1000_US..",
    "Weighted.Average", "Trade.Value..US..",
    "contig", "distw"
  )) %>%
  select(c(-"X.x", -"X.y", )) %>%
  mutate(
    ln_PIB = log(PIB_.1000_US.., ),
    ln_Tariff = log(1 + Weighted.Average),
    ln_Export = log(Trade.Value..US..)
  ) %>%
  select(-"PIB_.1000_US..")

# Escrever o data.frame num csv
write.csv(df, "Modelo_Proprio.csv")
