library(gravity)
library(broom)
library(tidyr)
library(xtable)
library(dplyr)

setwd("C:/Users/Thiago/Desktop/Google Drive/ITP/Modelo")

cepii <- read.csv("Datasets_Completos/CEPII_Notif.csv")

cepii <- cepii %>%
    tidyr::fill(Trade.Value..US..) %>%
    filter(Year < 2016) %>%
    mutate(
        ln_gdp_o = log(gdp_o), ln_gdp_d = log(gdp_d),
        ln_trade = log(Trade.Value..US..),
        ln_dist = log(distw)
    ) 

write.csv(cepii, "Datasets_Completos/CEPII_Notif.csv")

modelo_cepii = gravity::ppml(
    dependent_variable = "ln_trade",
    distance = "distw",
    additional_regressors = c("Animal.health",
                            "Consumer.information",
                            "Cost.saving",
                            "Food.safety",
                            "Harmonization",
                            "Labelling",
                            "Lower.barriers.to.trade",
                            "National.security.requirements",
                            "Not.specified",
                            "Other",
                            "Plant.protection",
                            "Prevention.of.deceptive.practices.and.consumer.protection",
                            "Protect.humans.from.animal.plant.pest.or.disease",
                            "Protect.territory.from.other.damage.from.pests",
                            "Protection.of.Human.health.or.Safety",
                            "Protection.of.animal.or.plant.life.or.health",
                            "Protection.of.the.environment",
                            "Quality.requirements",
                            "ln_gdp_d",                                                   
                            "ln_gdp_o",                                                   
                            "comrelig",                                                
                            "gatt_d",                                                  
                            "gatt_o",                                                   
                            "eu_d",),
    code_origin = "Origin",
    code_destination = "Country.Code",
    data = cepii
)

print(xtable(modelo_cepii, booktabs=TRUE))

# Dataset criado
meu_dataset <- read.csv("Modelo_Completo/Dados_modelo.csv")
meu_dataset <- meu_dataset %>% 
    mutate(ln_Tarif = log(1 + Weighted.Average))

modelo <- ppml(dependent_variable = 
    
)
