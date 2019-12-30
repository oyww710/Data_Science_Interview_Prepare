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

### 347. Top K Frequent Elements
```
Input: nums = [1,1,1,2,2,3], k = 2
Output: [1,2]

Input: nums = [1], k = 1
Output: [1]
```

**Solution 1: just use python function**
``` Python
import collections

class Solution(object):
    def topKFrequent(self, nums, k):
        """
        :type nums: List[int]
        :type k: int
        :rtype: List[int]
        """
        # Use Counter to extract the top k frequent elements
        # most_common(k) return a list of tuples, where the first item of the tuple is the element,
        # and the second item of the tuple is the count
        # Thus, the built-in zip function could be used to extract the first item from the tuples
        return zip(*collections.Counter(nums).most_common(k))[0]
```

**Solution 2:Use most_common function**
```
from collections import Counter
class Solution(object):
    def topKFrequent(self, nums, k):
        """
        :type nums: List[int]
        :type k: int
        :rtype: List[int]
        """
        num_count = Counter(nums)
        nums = num_count.most_common(k)
        return [i[0] for i in nums]
```

**Solution 3: Dictionary+Heap**
``` Python
import heapq
class Solution(object):
    def topKFrequent(self, nums, k):
        """
        :type nums: List[int]
        :type k: int
        :rtype: List[int]
        """
        res = []
        dict = {}
        for num in nums:
            if num not in dict:
                dict[num] = 1
            else:
                dict[num]+=1
        for key, val in dict.items():
            if len(res) < k:
                heapq.heappush(res, [val,key])
            else:
                heapq.heappushpop(res, [val,key])
        return [y for x, y in res]
```
**Solution 4: Dictionary+Heap**
``` Python
class Solution:
    def topKFrequent(self, nums: List[int], k: int) -> List[int]:
        import heapq
        from collections import Counter
        counter = Counter(nums)
        return heapq.nlargest(k, counter.keys(), key= lambda num:counter[num])
```
