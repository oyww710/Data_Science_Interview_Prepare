from numpy.random import randint

# Create a sample of 10 die rolls
small = randint(1, 7, 10)

# Calculate and print the mean of the sample
small_mean = small.mean()
print(small_mean)

# Create a sample of 1000 die rolls
large = randint(1, 7, 1000)

# Calculate and print the mean of the large sample
large_mean = large.mean()
print(large_mean)

# Adapt code for 100 samples of size 30
means = [randint(1, 7, 30).mean() for i in range(100)]

# Create and show a histogram of the means
plt.hist(means)
plt.show()
