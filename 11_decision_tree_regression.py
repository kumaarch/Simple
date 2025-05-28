
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.tree import DecisionTreeRegressor
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error, r2_score

np.random.seed(42)
X = np.random.rand(100, 1) * 10
y = 3 * X**2 + 2 * X + 5 + np.random.randn(100, 1) * 10

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

regressor = DecisionTreeRegressor(max_depth=5, random_state=42)
regressor.fit(X_train, y_train)

y_pred = regressor.predict(X_test)

mse = mean_squared_error(y_test, y_pred)
r2 = r2_score(y_test, y_pred)
print(f"Mean Squared Error: {mse:.2f}")
print(f"R^2 Score: {r2:.2f}")

plt.scatter(X_test, y_test, color="blue", label="Actual Data")
plt.scatter(X_test, y_pred, color="red", label="Predicted Data")
plt.title("Decision Tree Regression")
plt.xlabel("Feature")
plt.ylabel("Target")
plt.legend()
plt.show()

X_grid = np.arange(min(X), max(X), 0.1).reshape(-1, 1)
y_grid = regressor.predict(X_grid)

plt.plot(X_grid, y_grid, color="orange", label="Decision Tree Prediction")
plt.scatter(X, y, color="blue", label="Actual Data")
plt.title("Decision Tree Regression (Non-linear Relationship)")
plt.xlabel("Feature")
plt.ylabel("Target")
plt.legend()
plt.show()
