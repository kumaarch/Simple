import random
import time
import matplotlib.pyplot as plt

# Insertion Sort
def insertion_sort(arr):
    n = len(arr)
    for i in range(1, n):
        key = arr[i]
        j = i - 1
        while j >= 0 and arr[j] > key:
            arr[j + 1] = arr[j]
            j -= 1
        arr[j + 1] = key

# Heap Sort
def heapify(arr, n, i):
    largest = i
    left = 2 * i + 1
    right = 2 * i + 2

    if left < n and arr[left] > arr[largest]:
        largest = left
    if right < n and arr[right] > arr[largest]:
        largest = right
    if largest != i:
        arr[i], arr[largest] = arr[largest], arr[i]
        heapify(arr, n, largest)

def heap_sort(arr):
    n = len(arr)
    for i in range(n // 2 - 1, -1, -1):
        heapify(arr, n, i)
    for i in range(n - 1, 0, -1):
        arr[i], arr[0] = arr[0], arr[i]
        heapify(arr, i, 0)

# Function to measure execution time
def measure_time(sorting_function, n_values):
    times = []
    for n in n_values:
        arr = [random.randint(1, 10000) for _ in range(n)]
        start_time = time.time()
        sorting_function(arr)
        end_time = time.time()
        times.append(end_time - start_time)
    return times

# Define list sizes
n_values = [100, 500, 1000, 5000, 10000, 20000, 50000]

# Measure time for both sorting algorithms
insertion_sort_times = measure_time(insertion_sort, n_values[:4])  # Limited to avoid long waits
heap_sort_times = measure_time(heap_sort, n_values)

# Plotting the graph
plt.plot(n_values[:4], insertion_sort_times, marker='o', label="Insertion Sort", color='r')
plt.plot(n_values, heap_sort_times, marker='o', label="Heap Sort", color='b')
plt.title("Sorting Time vs List Size")
plt.xlabel("Number of Elements (n)")
plt.ylabel("Time Taken (seconds)")
plt.legend()
plt.grid(True)
plt.show()
