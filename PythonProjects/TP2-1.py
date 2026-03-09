import pandas as pd
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.svm import SVR
from sklearn.tree import DecisionTreeRegressor
from sklearn.neural_network import MLPRegressor
from sklearn.metrics import mean_squared_error
from math import sqrt
from sklearn.impute import SimpleImputer
from sklearn.preprocessing import StandardScaler

def clean_numeric(value):
    if pd.isna(value):
        return float('nan')

    if isinstance(value, (int, float)):
        return float(value)

    try:
        return float(str(value).replace(',', '.')) if pd.notna(value) else float('nan')
    except ValueError:
        return float('nan')

def import_and_clean_data(filename, target_column):
    data = pd.read_csv(filename, on_bad_lines='skip', sep=',')
    data = data.applymap(clean_numeric)
    data = data.dropna(subset=[target_column])

    return data

def train_model(model, X_train, y_train, X_test):
    if 'Support Vector Machine' in str(model):
        scaler = StandardScaler()
        X_train = scaler.fit_transform(X_train)
        X_test = scaler.transform(X_test)
    
    model.fit(X_train, y_train)
    return model.predict(X_test)

def predict_and_plot(model_name, model, X_train, y_train, X_test, y_test, label, feature_names, ax):
    predictions = train_model(model, X_train, y_train, X_test)
    rmse = sqrt(mean_squared_error(y_test, predictions))
    
    # Plot des prédictions
    for i, feature in enumerate(feature_names):
        ax[i].scatter(X_test[feature], predictions, label=label, alpha=0.5, color='b', edgecolors='k')
        ax[i].set_title(f'{model_name} - Predictions vs. Actual {label}')
        ax[i].set_xlabel(feature)
        ax[i].set_ylabel(label)

    return {'rmse': rmse, 'predictions': predictions}

def train_and_predict(data, target_column, features, model_type):
    target = target_column

    imputer = SimpleImputer(strategy='mean')
    data[features] = imputer.fit_transform(data[features])

    X_train, X_test, y_train, y_test = train_test_split(data[features], data[target], test_size=0.2, random_state=42)

    models = {
        'Linear Regression': LinearRegression(),
        'Support Vector Machine': SVR(),
        'Decision Tree': DecisionTreeRegressor(),
        'Neural Network': MLPRegressor()
    }

    if model_type not in models:
        raise ValueError(f"Invalid model type: {model_type}")

    selected_model = models[model_type]

    fig, axs = plt.subplots(2, 2, figsize=(12, 10))
    axs = axs.flatten()

    fig.suptitle(f'{target_column} Predictions using {model_type}', fontsize=16)

    for i, feature in enumerate(features):
        axs[i].set_title(f'{feature}')

    predict_and_plot(model_type, selected_model, X_train, y_train, X_test, y_test, target_column, features, axs)

    plt.tight_layout()
    plt.show()

if __name__ == "__main__":
    filename = "Wage2_merged.csv"
    target_column_wage = 'wage'  # Remplacez par le nom réel de la colonne 'wage'
    target_column_lwage = 'lwage'  # Remplacez par le nom réel de la colonne 'lwage'
    features = ['hours', 'IQ', 'educ', 'exper']

    # Predictions pour 'Wage'
    data_wage = import_and_clean_data(filename, target_column_wage)
    train_and_predict(data_wage, target_column_wage, features, 'Neural Network')  # Choisissez le modèle de votre choix
    train_and_predict(data_wage, target_column_wage, features, 'Support Vector Machine')
    train_and_predict(data_wage, target_column_wage, features, 'Decision Tree')
    train_and_predict(data_wage, target_column_wage, features, 'Linear Regression')
    # Predictions pour 'lwage'
    data_lwage = import_and_clean_data(filename, target_column_lwage)
    train_and_predict(data_lwage, target_column_lwage, features, 'Neural Network')  # Choisissez le modèle de votre choix
