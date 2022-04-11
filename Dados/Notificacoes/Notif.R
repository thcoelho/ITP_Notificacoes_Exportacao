library(dplyr)
library(tidyr)

df <- read.csv("EPING_Notifications.csv")

agrupado <- df %>% 
    group_by(Year, Country.Code, Commodity.Code, Objectives) %>% 
    tally() %>% 
    filter(Country.Code != "") %>% 
    spread(Objectives, n)

agrupado[is.na(agrupado)] = 0

write.csv(agrupado, "Objetivos_Agrupados.csv")
