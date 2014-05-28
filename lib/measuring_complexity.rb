#Measuring Complexity
#       Computers perform different operations at different speeds: addition may be very fast and 
#       division very slow. Different computers may have different specialities. One machine may 
#       have very fast math but slow string operations while another might do math very slowly. Machines 
#       also vary in memory size and processor, memory, and disk speeds. Researchers would find it 
#       difficult to compare results measured on different machines.
#
#       Measuring performance within a given range doesn't tell us if the algorithm continues to scale 
#       outside of the range. Perhaps it runs very well for problem sizes up to 1000, but at some larger 
#       size it began to run too slowly.
#
#   Instead, the measurement is done more abstractly by counting the number of basic operations required 
#   to run the algorithm, after defining what is counted as an operation. For example, if you wanted to 
#   measure the time complexity of computing a sine function, you might assume that only addition, 
#   subtraction, multiplication, and division are basic operations. On the other hand, if you were 
#   measuring the time to draw a circle, you might include sine as a basic operation.
#
#   Complexity is expressed using big-O notation. The complexity is written as O(<some function>), 
#   meaning that the number of operations is proportional to the given function multiplied by some 
#   constant factor. For example, if an algorithm takes 2*(n**2) operations, the complexity is written 
#   as O(n**2), dropping the constant multiplier of 2.
#
#   Some of the most commonly seen complexities are:
#       O(1) is constant-time complexity. The number of operations for the algorithm doesn't actually 
#       change as the problem size increases.
#
#       O(log n) is logarithmic complexity. The base used to take the logarithm makes no difference, 
#       since it just multiplies the operation count by a constant factor. The most common base is base 2, 
#       written as log_2 or lg .
#
#       Algorithms with logarithmic complexity cope quite well with increasingly large problems. Doubling 
#       the problem size requires adding a fixed number of new operations, perhaps just one or two additional steps.
#
#       O(n) time complexity means that an algorithm is linear; doubling the problem size also doubles 
#       the number of operations required.
#
#       O(n**2) is quadratic complexity. Doubling the problem size multiplies the operation count by four. 
#       A problem 10 times larger takes 100 times more work.
#
#       O(n**3), O(n**4), O(n**5), etc. are polynomial complexity.
#
#       O(2**n) is exponential complexity. Increasing the problem size by 1 unit doubles the work. 
#       Doubling the problem size squares the work. The work increases so quickly that only the very 
#       smallest problem sizes are feasible.
#
#   After correctness, time complexity is usually the most interesting property of an algorithm, 
#   but in certain cases the amount of memory or storage space required by an algorithm is also of interest. 
#   These quantities are also expressed using big-O notation. For example, one algorithm might have 
#   O(n) time and use no extra memory while another algorithm might take only O(1) time by using O(n) 
#   extra storage space. In this case, the best algorithm to use will vary depending on the environment 
#   where you're going to be running it. A cellphone has very little memory, so you might choose the 
#   first algorithm in order to use as little memory as possible, even if it's slower. Current desktop 
#   computers usually have gigabytes of memory, so you might choose the second algorithm for greater speed 
#   and live with using more memory.
#
