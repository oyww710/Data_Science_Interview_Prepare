from sklearn.linear_model import LinearRegression 
X = np.array(weather['Humidity9am']).reshape(-1,1)
y = weather['Humidity3pm']

# Create and fit your linear regression model
lm = LinearRegression()
lm.fit(X, y)

# Assign and print predictions
preds = lm.predict(X)

# Assign and print coefficient 
coef = lm.coef_
print(coef)
