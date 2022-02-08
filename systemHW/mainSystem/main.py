# Main Section (Data sets & Rainfall Algorithm)
import os
import pandas as pd

pokeData = pd.read_csv(os.readlink("F:\University Work\Year 2\SDGP\systemHW\mainSystem\pokemon_data.csv"))

print(pokeData.head(3))
