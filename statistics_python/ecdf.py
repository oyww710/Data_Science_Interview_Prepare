def ecdf(data):
    """Compute ECDF for a one-dimensional array of measurements."""
    # Number of data points: n
    n = len(data)

    # x-data for the ECDF: x
    x = np.sort(data)

    # y-data for the ECDF: y
    y = np.arange(1, n+1) / n

    return x, y

'''
an empirical distribution function is the distribution function associated with 
the empirical measure of a sample. This cumulative distribution function is a step 
function that jumps up by 1/n at each of the n data points
'''
