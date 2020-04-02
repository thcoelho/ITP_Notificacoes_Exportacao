library(gravity)

df = read.csv("Modelo/Modelo_Completo/Dados_modelo.csv")

modelo = gravity::ppml(
    dependent_variable = "Imports.Value.in.1000.USD",
    distance = "distw",
    additional_regressors = c("PIB_.(1000_US$)",
                            "contig", "colony",
                            "dist", "Weighted.Average"),
    code_origin = "Exp",
    code_destination = "Country",
    data = df
)