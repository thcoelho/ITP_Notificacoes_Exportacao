library(gravity)
library(broom)
library(dplyr)
library(tidyr)

df <- read.csv("Modelo_Completo/Modelo_Proprio.csv")

df$Origin <- "BRA"



modelo <- ppml(
  dependent_variable = "ln_Export",
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
    "ln_PIB",
    "ln_Tariff"
  ),
  code_origin = "Origin",
  code_destination = "Country.Code",
  
  data = df
)

augment(modelo)
