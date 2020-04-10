library(gravity)

df = read.csv("Modelo/Modelo_Completo/Teste_objetivos.csv")

modelo = gravity::ppml(
    dependent_variable = "Imports.Value.in.1000.USD",
    distance = "distw",
    additional_regressors = c("PIB_.1000_US..",
                            "contig", "colony",
                            "Weighted.Average","Animal.health",
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
                            "Quality.requirements"),
    code_origin = "Exp",
    code_destination = "Country",
    data = df

)