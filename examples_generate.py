import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression

import matplotlib.pyplot as plt

# Load data (assuming Wage_merged.csv is in the same directory)
Wage_merged = pd.read_csv('Wage_merged.csv')

# Take the first 2 and 3 rows
data_2 = Wage_merged.iloc[:2]
data_3 = Wage_merged.iloc[:3]

# Prepare X and y
X2 = data_2[['educ']].values
y2 = data_2['wage'].values

X3 = data_3[['educ']].values
y3 = data_3['wage'].values

# Fit linear regression models
model2 = LinearRegression().fit(X2, y2)
model3 = LinearRegression().fit(X3, y3)

# Get coefficients
w0_2, w1_2 = model2.intercept_, model2.coef_[0]
w0_3, w1_3 = model3.intercept_, model3.coef_[0]

# Prepare data for plotting
first5 = Wage_merged.iloc[:10]
X5 = first5[['educ']].values
y5 = first5['wage'].values

# Predictions for first 2 and 3 data points
pred2 = model2.predict(X5)
pred3 = model3.predict(X5)

# Plot for 2-point regression
plt.figure(figsize=(10, 5))
plt.scatter(first5['educ'], y5, color='blue', label='Actual wage')
plt.scatter(first5['educ'][:2], y5[:2], color='green', label='Used for fit (2 pts)')
plt.plot(
    first5['educ'], pred2, color='red',
    label=fr'Prediction (2 pts)' '\n' r'($w_0$={w0:.2f}, $w_1$={w1:.2f})'.format(w0=w0_2, w1=w1_2)
)
plt.title('Linear Regression (2 points)')
plt.xlabel('educ')
plt.ylabel('wage')
plt.legend()
plt.tight_layout()
plt.savefig('LRSingle1.pdf')
plt.close()

# Plot for 3-point regression
plt.figure(figsize=(10, 5))
plt.scatter(first5['educ'], y5, color='blue', label='Actual wage')
plt.scatter(first5['educ'][:3], y5[:3], color='orange', label='Used for fit (3 pts)')
plt.plot(
    first5['educ'], pred3, color='purple',
    label=fr'Prediction (3 pts)' '\n' r'($w_0$={w0:.2f}, $w_1$={w1:.2f})'.format(w0=w0_3, w1=w1_3)
)
plt.plot(
    first5['educ'], pred2, color='red', linestyle='--',
    label=fr'Prediction (2 pts)' '\n' r'($w_0$={w0:.2f}, $w_1$={w1:.2f})'.format(w0=w0_2, w1=w1_2)
)
plt.title('Linear Regression (3 points)')
plt.xlabel('educ')
plt.ylabel('wage')
plt.legend()
plt.tight_layout()
plt.savefig('LRSingle23.pdf')
plt.close()