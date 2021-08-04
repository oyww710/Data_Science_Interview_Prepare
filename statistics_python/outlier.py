# Calculate the mean and std
mean, std = laptops['Price'].mean(), laptops['Price'].std()

# Compute and print the upper and lower threshold
cut_off = std * 3
lower, upper = mean - cut_off, mean + cut_off
print(lower, 'to', upper)

# Identify and print rows with outliers
outliers = laptops[(laptops['Price'] > upper) | 
                   (laptops['Price'] < lower)]
print(outliers)

# Drop the rows from the dataset
laptops = laptops[(laptops['Price'] <= upper) | 
                  (laptops['Price'] >= lower)]
