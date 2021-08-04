# Create a sample list
import math
nums = [1, 2, 3, 4, 5]

# Compute the mean of the list
mean = sum(nums) / len(nums)

# Compute the variance and print the std of the list
variance = sum(pow(x - mean, 2) for x in nums) / len(nums)
std = math.sqrt(variance)
print(std)

# Compute and print the actual result from numpy
real_std = np.array(nums).std()
print(real_std)
