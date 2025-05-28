
import numpy as np
from sklearn.datasets import make_classification
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier, plot_tree
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report, accuracy_score
import matplotlib.pyplot as plt

def decision_tree_model():
    print("=== Decision Tree Classifier ===")
    X, y = make_classification(n_samples=300, n_features=4, n_informative=3, n_redundant=0, random_state=42)
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

    dt_model = DecisionTreeClassifier(max_depth=5, random_state=42)
    dt_model.fit(X_train, y_train)
    y_pred = dt_model.predict(X_test)
    print("Accuracy:", accuracy_score(y_test, y_pred))
    print("Classification Report:", classification_report(y_test, y_pred))
    plt.figure(figsize=(16, 10))
    plot_tree(dt_model, feature_names=[f'Feature {i}' for i in range(X.shape[1])],
              class_names=['Class 0', 'Class 1'], filled=True, rounded=True)
    plt.title("Decision Tree Visualization")
    plt.show()

def random_forest_model():
    print("=== Random Forest Classifier ===")
    X, y = make_classification(n_samples=300, n_features=4, n_informative=3, n_redundant=0, random_state=42)
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

    rf_model = RandomForestClassifier(n_estimators=100, max_depth=5, random_state=42)
    rf_model.fit(X_train, y_train)
    y_pred = rf_model.predict(X_test)
    print("Accuracy:", accuracy_score(y_test, y_pred))
    print("Classification Report:", classification_report(y_test, y_pred))

    feature_importances = rf_model.feature_importances_
    plt.bar(range(len(feature_importances)), feature_importances, tick_label=[f'Feature {i}' for i in range(len(feature_importances))])
    plt.title("Feature Importances in Random Forest")
    plt.xlabel("Features")
    plt.ylabel("Importance")
    plt.show()

decision_tree_model()
random_forest_model()
