### 1. Two Sum

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

### 53. Maximum Subarray

``` Python
class Solution:
    def maxSubArray(self, nums: 'List[int]') -> 'int':
        n = len(nums)
        curr_sum = max_sum = nums[0]

        for i in range(1, n):
            curr_sum = max(nums[i], curr_sum + nums[i])
            max_sum = max(max_sum, curr_sum)
            
        return max_sum
```

### 21. Merge Two Sorted Lists

``` Python
class Solution:
    def mergeTwoLists(self, l1, l2):
        if l1 is None:
            return l2
        elif l2 is None:
            return l1
        elif l1.val < l2.val:
            l1.next = self.mergeTwoLists(l1.next, l2)
            return l1
        else:
            l2.next = self.mergeTwoLists(l1, l2.next)
            return l2
```

### 206. Reverse Linked List

``` Python
class Solution:
    def reverseList(self, head):
        """
        :type head: ListNode
        :rtype: ListNode
        """
        prev_node = None
        curr_node = head
        while curr_node:
            next_node = curr_node.next # Remember next node
            curr_node.next = prev_node  # REVERSE! None, first time round.
            prev_node = curr_node  # Used in the next iteration.
            curr_node = next_node  # Move to next node.
        head = prev_node
        return head
```

### 121. Best Time to Buy and Sell Stock

``` Python
    if len(prices) == 0: 
        return 0        
    else:
        low = 99999 # represent minimum price so far
        profitmax = 0
        for price in prices:
            if price > low:
                if price - low > profitmax:
                    profitmax = price - low                        
            elif price < low:
                low = price
                
        return profitmax
```

### 88. Merge Sorted Array

``` Python
class Solution(object):
    def merge(self, nums1, m, nums2, n):
        """
        :type nums1: List[int]
        :type m: int
        :type nums2: List[int]
        :type n: int
        :rtype: void Do not return anything, modify nums1 in-place instead.
        """
        nums1[:] = sorted(nums1[:m] + nums2)
```

### 239. Sliding Window Maximum

``` Python
def maxSlidingWindow(self, nums, k):
    	s = []
        for elem in range(len(nums)+ 1-k):
            window = nums[elem: elem + k]
            s.append(max(window))
        return s
``` 

### 344. Reverse String

``` Python
class Solution:
    def reverseString(self, s: List[str]) -> None:
        for i in range(len(s)//2):
            s[i], s[-i-1] = s[-i-1], s[i]
``` 

### 283. Move Zeroes

``` Python
class Solution:
    def moveZeroes(self, nums: List[int]) -> None:
        """
        Do not return anything, modify nums in-place instead.
        """
        if not nums:
            return
        
        current_zero_index = 0
        for i in range(len(nums)):
            if nums[i] != 0:
                if current_zero_index != i:
                    nums[current_zero_index], nums[i] = nums[i], nums[current_zero_index]
                current_zero_index += 1
``` 

``` Python
 def moveZeroes(self, nums: List[int]) -> None:
        x = nums.count(0)
        for i in range(nums.count(0)):
            nums.remove(0)
        return nums.extend([0]*x)
``` 

### 
