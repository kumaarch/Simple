import timeit
import matplotlib.pyplot as plt

# Optimized linear search function (searching last element for worst case)
def linear_search(arr, target):
    for index, element in enumerate(arr):
        if element == target:
            return index
    return -1

# Function to measure execution time
def measure_time(n_values, iterations=50):
    times = []
    for n in n_values:
        arr = list(range(n))  # Sequential list for consistency
        target = arr[-1]  # Always search for the last element (worst case)

        # Measure execution time using timeit
        time_taken = timeit.timeit(lambda: linear_search(arr, target), number=iterations)
        avg_time = time_taken / iterations  # Compute average time
        times.append(avg_time)
    
    return times

# Define list sizes
n_values = [1000, 2000, 5000, 10000, 20000, 50000, 100000]
times = measure_time(n_values)

# Plot measured linear search time
plt.figure(figsize=(8, 5))
plt.plot(n_values, times, marker='o', color='b', linestyle='-')
plt.title("Linear Search: Time Taken vs List Size")
plt.xlabel("Number of Elements (n)")
plt.ylabel("Time Taken (seconds)")
plt.grid(True)
plt.show()
