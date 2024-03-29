Leetcode Practice for DS Interview
=====================================

### Author: Weiwei Ouyang

Outline
=====================================

* [167. Two Sum II - Input array is sorted](#167)
* [215. Kth Largest Element in an Array](#215)
* [347. Top K Frequent Elements](#347)
* [75. Sort Colors](#75)
* [455. Assign Cookies](#455)
* [69. Sqrt(x)](#69)
* [1. Two Sum](#1)
* [242. Valid Anagram](#242)


Problems
=====================================

<a name="167"></a>
### 167. Two Sum II - Input array is sorted
``` 
Input: numbers = [2,7,11,15], target = 9
Output: [1,2]
Explanation: The sum of 2 and 7 is 9. Therefore index1 = 1, index2 = 2.
``` 

**Solution: two pointers O(n)**
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
<a name="215"></a>
### 215. Kth Largest Element in an Array
Find the kth largest element in an unsorted array.
```
Input: [3,2,1,5,6,4] and k = 2
Output: 5

Input: [3,2,3,1,2,4,5,5,6] and k = 4
Output: 4
```

**Solution 1: While loop using max() O(n)**
``` Python
class Solution:
    def findKthLargest(self, nums: List[int], k: int) -> int:
        i=1
        while i<k:
            nums.remove(max(nums))
            i+=1
        return max(nums)
```
**Solution 2: Use sorted function O(nlog(n))**
``` Python
class Solution:
    def findKthLargest(self, nums: List[int], k: int) -> int:
        return sorted(nums,reverse=True)[k-1]
```

**Solution 3: Heap function O(klog(n))**
``` Python
class Solution:
    def findKthLargest(self, nums: List[int], k: int) -> int:
        return heapq.nlargest(k, nums)[-1]
``` 

**Solution 4: quicksort nlogn average O(nlogn)**
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
<a name="347"></a>
### 347. Top K Frequent Elements
```
Input: nums = [1,1,1,2,2,3], k = 2
Output: [1,2]

Input: nums = [1], k = 1
Output: [1]
```

**Solution 1: just use python most common+ zip function O(n)**
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

**Solution 2:Use most_common function O(n)**
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

**Solution 3: Dictionary+Heap O(nlogn)**
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
**Solution 5: Bucket Sorting O(n)**
``` Python
from collections import Counter
from collections import defaultdict

class Solution:
    def topKFrequent(self, nums, k):

        counter = Counter(nums)  # key=> num, val => count of num
        bucket = defaultdict(list)  # key=> count of num, val => list of num with that count

        for key, val in counter.items():  
            bucket[val].append(key)

        ret = []
        for i in range(len(nums), 0, -1):
            if bucket[i]:
                ret += bucket[i]
            if len(ret) == k:
                return ret
```

<a name="75"></a>
### 75. Sort Colors
Given an array with n objects colored red, white or blue, sort them in-place so that objects of the same color are adjacent, with the colors in the order red, white and blue.Here, we will use the integers 0, 1, and 2 to represent the color red, white, and blue respectively.
``` 
Input: [2,0,2,1,1,0]
Output: [0,0,1,1,2,2]
``` 

**Solution 1: three pointers O(n)**
```  Python
class Solution(object):
    def sortColors(self, nums):
        """
        :type nums: List[int]
        :rtype: None Do not return anything, modify nums in-place instead.
        """
        l,mid,r=0,0,len(nums)-1
        while mid<=r:
            if nums[mid]==0:
                nums[mid],nums[l]=nums[l],nums[mid]
                l+=1
                mid+=1
            elif nums[mid]==1:
                mid+=1
            elif nums[mid]==2:
                nums[mid],nums[r]=nums[r],nums[mid]
                r-=1
```

**Solution 2: Dictionary+merge list O(n)**
``` Python
from collections import Counter
class Solution(object):
    def sortColors(self, nums):
        """
        :type nums: List[int]
        :rtype: None Do not return anything, modify nums in-place instead.
        """
        c = Counter(nums)
        for i in range(c[0]): nums[i] = 0
        for i in range(c[0], c[0] + c[1]): nums[i] = 1
        for i in range(c[0] + c[1] ,  c[0] + c[1] + c[2]): nums[i] = 2
```
<a name="455"></a>
### 455. Assign Cookies
```
Input: [1,2,3], [1,1]

Output: 1

Explanation: You have 3 children and 2 cookies. The greed factors of 3 children are 1, 2, 3. 
And even though you have 2 cookies, since their size is both 1, you could only make the child whose greed factor is 1 content.
You need to output 1.

Input: [1,2], [1,2,3]

Output: 2

Explanation: You have 2 children and 3 cookies. The greed factors of 2 children are 1, 2. 
You have 3 cookies and their sizes are big enough to gratify all of the children, 
You need to output 2.
```
**Solution: Greed algrithom O(n)**
``` Python
class Solution:
    def findContentChildren(self, g: List[int], s: List[int]) -> int:
        G=sorted(g)
        S=sorted(s)
        i = j = 0
        
        while i < len(G) and j < len(S):
            if G[i] <= S[j]:
                i += 1
            j += 1
            
        return i        
```

<a name="69"></a>
### 69. Sqrt(x)

**Solution: Binary search O(logn)**
``` Python
class Solution:
    def mySqrt(self, x: int) -> int:
        if x<2:
            return x
        l=2
        r=x

        while l<=r:
            mid=l+(r-l)//2
            if mid*mid>x:
                r=mid-1
            elif mid*mid<x:
                l=mid+1
            else: return mid
        return r
``` 
<a name="1"></a>
### 1. Two Sum

**Solution 1: Hash Table**
``` Python
class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        dic = {}
        for i, num in enumerate(nums):
            if target-num in dic:
                return (dic[target-num], i)
            dic[num] = i

``` 
**Solution 2: hash Table**
``` Python
class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        seen = {}
        
        for index, num in enumerate(nums):
            other = target - num
            
            if other in seen:
                return [seen[other], index]
            else:
                seen[num] = index
                
        return []
``` 

<a name="1"></a>
### 242. Valid Anagram

