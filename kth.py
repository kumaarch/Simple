import random 
 
# Function to partition the array around the pivot 
def partition(arr, low, high): 
    # Choose a random pivot index 
    pivot_index = random.randint(low, high) 
    pivot_value = arr[pivot_index] 
     
    # Swap the pivot with the last element 
    arr[pivot_index], arr[high] = arr[high], arr[pivot_index] 
     
    # Partition the array 
    i = low 
    for j in range(low, high): 
        if arr[j] < pivot_value: 
            arr[i], arr[j] = arr[j], arr[i] 
            i += 1 
     
    # Place the pivot in its correct position 
    arr[i], arr[high] = arr[high], arr[i] 
     
    return i  # Return the index of the pivot 
 
# Function to find the k-th smallest element using Quickselect 
def quickselect(arr, low, high, k): 
    if low == high:  # Base case: only one element 
        return arr[low] 
     
    # Partition the array and get the pivot index 
    pivot_index = partition(arr, low, high) 
     
    # The position of the pivot in the sorted array is pivot_index 
    if k == pivot_index: 
        return arr[k] 
    elif k < pivot_index: 
        return quickselect(arr, low, pivot_index - 1, k) 
    else: 
        return quickselect(arr, pivot_index + 1, high, k) 
 
# Main function to find the k-th smallest element 
def find_kth_smallest(arr, k): 
    if k < 1 or k > len(arr): 
        raise ValueError("k must be between 1 and the length of the array.") 
     
    # Convert k to 0-based index 
    return quickselect(arr, 0, len(arr) - 1, k - 1) 
 
# Example usage 
arr = [12, 3, 5, 7, 19, 2, 11, 17] 
k = 4  # Find the 4th smallest element 
result = find_kth_smallest(arr, k) 
print(f"The {k}-th smallest element is: {result}") 
