import sys
import pandas as pd
from sklearn.datasets import load_iris

# Load the Iris dataset (same as the notebook example)
iris = load_iris()
df = pd.DataFrame(data=iris.data, columns=iris.feature_names)
df['species'] = iris.target_names[iris.target]

# Retrieve the species name from command-line argument
species_name = sys.argv[1]

# Filter data for the specified species
df_species = df[df['species'] == species_name]
    
# Save summary statistics
summary_stats = df_species.describe()
summary_stats.to_csv(f'{species_name}_summary_statistics.csv')

