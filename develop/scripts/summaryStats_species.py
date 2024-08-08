

import sys
import pandas as pd

# Retrieve the species name from command-line argument
species_name = sys.argv[1]

df = pd.read_csv("iris_with_binned_sepal_length.tsv", sep='\t', header=0)

# Filter data for the specified species
df_byspecies = df[df['species'] == species_name]
    
# Save summary statistics
summary_stats = df_byspecies.describe()
summary_stats.to_csv(f'{species_name}_summary_statistics.csv')

