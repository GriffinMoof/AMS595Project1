# AMS595Project1
User Guide:

monteCarloFor(n): Takes an integer n and runs a monte carlo simulation for n points. Will generate a plot of the 
algorithm's estimation and its deviation from the value of pi. Returns a floating point approximation of pi.

runtime(n, pointCountDifference): Takes two integer values, the number of monte carlo simulations you would like to 
run as n, and the number of points each sequential simulation will differ by as pointCountDifference. Will generate a 
plot from each monte carlo method measuring the estimation and its deviation, and will generate a plot of the amount 
of time each simulation took vs how precise each simulation was, where a value of 0 is seen as perfectly precise.

monteCarloWhile(n):Takes an integer n and runs a montecarlo simulation until pi is approximated up to n significant 
figures. Once two sequential estimations have a difference of (0.1)^n, the algorithm will stop and print the number of 
iterations it went through and the final approximated value to the command window. The function also returns the final 
approximation as a float.

monteCarloUser(): At the start the program will ask the user for a desired level of precision. Input must be an 
integer or an error will occur. Once an input has been made, the algorithm will produce a plot. As points are created, 
markers will appear in the plot in real time. If red, the points are within the circle, if blue, the points are 
outside of the circle. The algorithm stops once two sequential estimations have a difference of (0.1)^n or less. The 
function will then return the final approximation as well as print the total iterations and final approximation in the 
command window.

