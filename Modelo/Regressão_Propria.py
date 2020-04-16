# %%
import pandas as pd
import gme

# %%
df = pd.read_csv("Modelo_Completo/Modelo_Proprio.csv")

# %%
df.head()

# %%
df.drop(df.columns[0], axis=1, inplace=True)
df.head()

# %%
dados_gravidade = gme.EstimationData()
