# this is just an example of a bubble sort implementation using Numba's JIT compilation
# and printing the x86-64 assembly for int64 arrays.    
# looks like python still uses the interpreter to run this code, so it will not print the assembly
# but it will compile the function to machine code for performance.
# hence inspect_asm will work only for assembly as expected in this context.
from numba import jit, types
import numpy as np

# Bubble sort with JIT
@jit(nopython=True)
def bubble_sort(arr):
    n = len(arr)
    for i in range(n):
        for j in range(0, n-i-1):
            if arr[j] > arr[j+1]:
                arr[j], arr[j+1] = arr[j+1], arr[j]
    return arr

# Use a numpy array of int64 (ensures type match)
example_array = np.array([64, 34, 25, 12, 22, 11, 90], dtype=np.int64)

# Trigger JIT compilation by calling the function once
bubble_sort(example_array)

# Now print the x86-64 assembly for int64 arrays
print(bubble_sort.inspect_asm((types.Array(types.int64, 1, 'C'),)))
sorted_array = bubble_sort(example_array)
print(sorted_array)  # Output: [11, 12, 22, 25, 34, 64, 90]
