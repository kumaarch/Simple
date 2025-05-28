import timeit
import random
import matplotlib.pyplot as plt
import math

# Recursive binary search function
def binary_search(arr, target, low, high):
    if high >= low:
        mid = (low + high) // 2
        if arr[mid] == target:
            return mid
        elif arr[mid] > target:
            return binary_search(arr, target, low, mid - 1)
        else:
            return binary_search(arr, target, mid + 1, high)
    return -1  # Target not found

# Function to measure execution time for binary search
def measure_time(n_values, iterations=50):
    times = []
    for n in n_values:
        arr = list(range(n))  # Generate a sorted list from 0 to n-1
        target = arr[-1]  # Choose the last element (worst case)

        # Measure execution time using timeit
        time_taken = timeit.timeit(lambda: binary_search(arr, target, 0, len(arr) - 1), number=iterations)
        avg_time = time_taken / iterations  # Compute average time
        times.append(avg_time)

    return times

# Define list sizes
n_values = [1000, 2000, 5000, 10000, 20000, 50000, 100000]
times = measure_time(n_values)

# Compute theoretical O(log n) complexity (scaled to match actual times)
scaling_factor = times[-1] / math.log2(n_values[-1])
theoretical_times = [scaling_factor * math.log2(n) for n in n_values]

# Plot binary search execution time
plt.figure(figsize=(8, 5))
plt.plot(n_values, theoretical_times, marker='s', color='r', linestyle='-', label="Theoretical O(log n)")

plt.title("Binary Search: Time Complexity Graph")
plt.xlabel("Number of Elements (n)")
plt.ylabel("Time Taken (seconds)")
plt.grid(True)

plt.show()
