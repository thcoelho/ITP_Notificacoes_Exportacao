library(gravity)
library(broom)
library(tidyr)
library(xtable)
library(dplyr)
library(purrr)

setwd("C:/Users/Thiago/Desktop/Google Drive/ITP/Modelo")

cepii <- read.csv("Modelo_Completo/Dados_Cepii_Especificados.csv")

cepii <-cepii %>% 
    select(-1)

PPML_REG <- function(df) {
    ppml(
        dependent_variable = "ln_trade",
        distance = "distw",
        additional_regressors = c(
            "Animal.health",
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
            "eu_d",
            "ln_Tariff",
            "contig"),
        code_origin = "Origin",
        code_destination = "Country.Code",
        data = df)
}


commodities <- cepii %>% 
    group_by(Commodity.Code) %>% 
    nest() %>% 
    arrange(Commodity.Code)

modelos <-map(commodities$data, PPML_REG)

resultados <- map(modelos, tidy)

