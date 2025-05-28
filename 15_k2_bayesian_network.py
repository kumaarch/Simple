
import numpy as np
import pandas as pd
from pgmpy.models import BayesianNetwork
from pgmpy.estimators import HillClimbSearch, K2Score, MaximumLikelihoodEstimator
from pgmpy.inference import VariableElimination
import matplotlib.pyplot as plt
import networkx as nx
from sklearn.datasets import load_iris

data = load_iris()
X = data.data
y = data.target
df = pd.DataFrame(X, columns=data.feature_names)
df['target'] = y

k2_score = K2Score(df)
hc = HillClimbSearch(df)
best_model_structure = hc.estimate(scoring_method=k2_score)
best_model = BayesianNetwork(best_model_structure.edges())

print("Learned Bayesian Network Structure:")
print(best_model.edges())

G = nx.DiGraph()
for node in best_model.nodes():
    G.add_node(node)
for edge in best_model.edges():
    G.add_edge(edge[0], edge[1])

plt.figure(figsize=(10, 7))
pos = nx.spring_layout(G, seed=42)
nx.draw_networkx_nodes(G, pos, node_size=3000, node_color='lightblue', alpha=0.6)
nx.draw_networkx_edges(G, pos, width=2, alpha=0.7, edge_color='gray')
nx.draw_networkx_labels(G, pos, font_size=12, font_weight='bold')
plt.title('Learned Bayesian Network Structure')
plt.show()

best_model.fit(df, estimator=MaximumLikelihoodEstimator)
inference = VariableElimination(best_model)
predicted_prob = inference.query(variables=['target'], evidence={'sepal length (cm)': 5.1})
print("\nPredicted Probability Distribution for 'target' given 'sepal length (cm)'=5.1:")
print(predicted_prob)
