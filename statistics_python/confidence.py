from scipy.stats import sem, t
data = [1, 2, 3, 4, 5]
confidence = 0.95

# Compute the standard error and margin of error
std_err = sem(data)
margin_error = std_err * z_score

# Compute and print the lower threshold
lower = sample_mean - margin_error
print(lower)

# Compute and print the upper threshold
upper = sample_mean + margin_error
print(upper)


# Compute and print the 99% confidence interval
confidence_int = proportion_confint(heads, 50, .01)
print(confidence_int)

# Compute and print the 90% confidence interval
confidence_int = proportion_confint(heads, 50, .10)
print(confidence_int)

# Repeat this process 10 times 
heads = binom.rvs(50, 0.5, size=10)
for val in heads:
    confidence_interval = proportion_confint(val, 50, .10)
    print(confidence_interval)
