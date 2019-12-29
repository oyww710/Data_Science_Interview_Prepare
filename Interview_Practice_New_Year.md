### 167. Two Sum II - Input array is sorted
``` 
Input: numbers = [2,7,11,15], target = 9
Output: [1,2]
Explanation: The sum of 2 and 7 is 9. Therefore index1 = 1, index2 = 2.
``` 

**Solution: two pointers**
``` Python
class Solution(object):
    def twoSum(self, numbers, target):
        """
        :type numbers: List[int]
        :type target: int
        :rtype: List[int]
        """
        L=0
        R=len(numbers)-1
        while L<=R:
            if numbers[L]+numbers[R]==target:
                return(L+1,R+1)
            elif numbers[L]+numbers[R]<target:
                L=L+1
            elif numbers[L]+numbers[R]>target:
                R=R-1
        return(L+1,R+1)
        
``` 

### 215. Kth Largest Element in an Array
Find the kth largest element in an unsorted array.
```
Input: [3,2,1,5,6,4] and k = 2
Output: 5

Input: [3,2,3,1,2,4,5,5,6] and k = 4
Output: 4
```

**Solution 1: While loop using max()**
``` Python
class Solution:
    def findKthLargest(self, nums: List[int], k: int) -> int:
        i=1
        while i<k:
            nums.remove(max(nums))
            i+=1
        return max(nums)
```
**Solution 2: Use sorted function**
``` Python
class Solution:
    def findKthLargest(self, nums: List[int], k: int) -> int:
        return sorted(nums,reverse=True)[k-1]
```

**Solution 3: Heap function**
``` Python
class Solution:
    def findKthLargest(self, nums: List[int], k: int) -> int:
        return heapq.nlargest(k, nums)[-1]
``` 

**Solution 4: quicksort nlogn average**
``` Python
class Solution:
    def findKthLargest(self, nums: List[int], k: int) -> int:
        p = nums[len(nums)//2]
        l, m, r = [x for x in nums if x > p], [x for x in nums if x == p], [x for x in nums if x < p]
        nums, i, j = l+m+r, len(l), len(l)+len(m)
        if k<= i:
            return self.findKthLargest(nums[:i], k)
        elif k>j:
            return self.findKthLargest(nums[j:], k-j)
        else: return(nums[i])
```


