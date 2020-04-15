library(dplyr)
library(tidyr)

df <- read.csv("../Datasets_Completos/CEPII_Notif.csv")
df2 <- read.csv("Dados_modelo.csv")

df2 <- df2 %>% 
    mutate(ln_Tariff = log(1 + Weighted.Average)) %>% 
    select(contig, ln_Tariff, Year, Country.Code, Commodity.Code) %>% 
    as_tibble()

df <- df %>% 
    select(-X.1,-X) %>% 
    as_tibble()
    
data <- left_join(df, df2)

data <- data %>% 
    fill(contig) %>% 
    replace_na(list(ln_Tariff = 0))

write.csv(data, "Dados_Cepii_Expecificados.csv")
