import pandas as pd
from sklearn.datasets import load_iris
import matplotlib.pyplot as plt


# Load the Iris dataset (same as the notebook example)
iris = load_iris()
df = pd.DataFrame(data=iris.data, columns=iris.feature_names)
df['species'] = iris.target_names[iris.target]

# Plot scatter plot of the species
_, ax = plt.subplots()
scatter = ax.scatter(iris.data[:, 0], iris.data[:, 1], c=iris.target)
ax.set(xlabel=iris.feature_names[0], ylabel=iris.feature_names[1])
_ = ax.legend(
    scatter.legend_elements()[0], iris.target_names, loc="lower right", title="Classes"
)

# Save the plot to a file without displaying it
plt.savefig("iris_scatter_plot.png", dpi=300)
plt.close()

# Feature engineering
df['sepal_area'] = df['sepal length (cm)'] * df['sepal width (cm)']
df['petal_area'] = df['petal length (cm)'] * df['petal width (cm)']
df['sepal_length_bin'] = pd.cut(df['sepal length (cm)'], bins=3, labels=["short", "medium", "long"])

df.to_csv("iris_with_binned_sepal_length.tsv", sep='\t', index=False)
