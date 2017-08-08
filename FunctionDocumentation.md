# Function Docunmentation

This file will list out the functions and give a description of them.  This can be used as a refernce file so that you don't have to lumber through Julia.R if you have any questions about whcich function you want to use.

Some notes on notation:

1. z will be used to represent a complex value. In much of this code, if you apply a function to a numeric or integer, it will be coerced into a complex value in the process.
2. f(z) is the function we will use for the Julia set.
3. f-2-(z) will be shorthand for f(f(z)) and inductively f-n-(z) = f(f-n\*-\*1-(z)).

## About Julia Sets

For many of our examples, we'll look be using the function f(z) = z^2 - 0.4 + 0.6i.  In reality, we can take f to be any rational function (quotient of two polynomials).  As we apply f over and over again, i.e., create a sequence {f-n-(z)}, either the values will remain bounded or will tend towards infinity, \( |f_n(z)| \rightarrow \infinity \).


We'll use the notation J-f- to refer to the Julia set associated with f.
A complex number, z, is said to belong to 

## Most Useful Functions

This section will contain the functions that you see the mosr.


* thefunction:
        * Takes in a value z (numerics or ints coerced to complex) and outputs f(z) = z^2 - 0.4 +0.6i.
        * If you want to change the function, you'll need to copy and manually edit the code of "thefunction".  Every .R script in this repo should start with "thefunction" being called outside of Julia.R for added specificty.
        * If there is a way around manually editing the code, please let me know.  I would really like to have "thefunction" to be a function of z and "f(z)".
        
*



## Less Used Functions

* iterating
        * Takes in a complex value and the number of iterations you want to apply.  
        * Outputs the value returned after applting thefunction that many times.
        
* in.Julia2
        * Determines if z belongs to the Julia set.
        * Applies thefunction a fixed number of times.  If the output is too large (determined by bound), then FALSE is returned.
        * Otherwise, TRUE is returned because z likely belongs to Julia set.

* iteratingbound
        * Same as in.Julia2 but was designed to be quicker.
        
*iterboundn
        * Like in.Julia2 and iteratingbound, the main purpose is to determine if z belongs to the Julia set.
        * This also tests for convergence and outputs n when z and f(z)

*iterboundnsecond