# Lesson 1: R basics
First things first!

## Defintions
- Variable: Holds a value 
- Function: Takes in input, does some magic/task, returns output
- Command: Code snippet you want to evaluate
- Environment: Your workspace, where your variables, functions and packages are stored 
- Object: variable, function, data etc. What fills up your environment

- Commands/functions in R are called like so: 
  
```  
print("Hello World")
```

- The print function is given an argument (also known as input) within the '()' 
- All functions are called this way
``` 
sum(x)
plot(x,y)
library(limma)
load("file.Rdata")
source("helper.R")
```
- The output is returned once the function or command is evaluated - i.e. when you run it or enter into the command console 

Try it! 
  
## Simple arithmetic
- R is really a calculator
- Basic arithmetic operators do what you think they would: +, -, *, /
- Some special operators: %% (modulus), %*% (matrix multiplication) 
- Some special variables: pi, TRUE, FALSE, NULL, NA, NaN, Inf
- Some fancier operators:  log(), exp(), sqrt(), round()
- Some logical operators: |, &, <, > 
``` 
1 + 2
2/4
(4+5^7)/56
3 %% 5 
log10(100)
```
- Spaces do not matter
- Order of operations matters
- more here: https://www.statmethods.net/management/operators.html 

## Variables
- Variables are letters or words 
- Store a value 
- Could be a number, character, string, array (or vector), matrix, etc. 
- Assign a value to a variable either via the assignment operator <- or the equals sign = 
  
```
x <- 1
y = 2 
very_important_variable <- 0
not_very_important = 100 
``` 

- Can change existing variables, add, send them into commands/functions 
``` 
data <- 0 
data <- 3 
data <- x + y 
data <- sqrt(x)
data <- rnorm(1000)
more_data <- 1000
data <- data + more_data 
```


## Data types 
- Numbers (integers, doubles): 
``` 
1
1.32545
5e9
```
- Characters:
``` 
'A'
'z'
```
- Strings:
``` 
"Yaaaas"
"Booo"
"Whatever"
```

- Array or vector: 
  - Made of multiple elements of the same data class
``` 
c(1,3,5)
c('A', 'B', 'C')
c("Hello", "Goodbye")
1:100
rnorm(100)
rep(1,10)
seq(0,200,10)
```
- can assign them to variables 
```  
my_seq <- seq(0,200,10)
```
- access elements by an index 
```  
my_seq[1] 
```
- and replace or change single or multiple elements 
```   
my_seq[1] <- 1000 
my_seq[3:6] <- c(30,20,40,36) 
```
NOTE: in R, we count from 1 (not 0!)

- Matrix or tables: 
```
diag(10)
matrix(1:10, ncol=5, nrow=2)
cbind(1:10, 10:1)
rbind(1:10, 10:1)
```
- can also access elements via indices, but this time we select the row, then column:
``` 
A <- diag(5)
A[1,5] <- 9
A
```
- Negative indexing returns all but the indices specified
- useful for data splicing 
``` 
my_seq <- seq(0,200,10)
my_seq[-10]
my_seq[-10:-20]
```

### Advanced data types 
- Factors 
- define your own data class 
- has levels or strict values that this new data class can take 
``` 
sex <-  c("male", "female", "male", "male", "female")  
sex <- factor( sex, levels=c("male", "female"))
sex
```
- If you try to assign a new value to a variable, it has be one of the levels 
``` 
sex[1] <- "female"
sex[2] <- "unknown" # This will cause an error! 
```

- Lists are collections of data 
- Elements can be of varying lengths and data classes/types 
``` 
B <- 1:10
C <- sex
D <- list(A,B,C)
```
- access different levels with double square brackets  
``` 
D[[1]]
```
- or, if we have tags/labels/names on the elements within the list, via the tag operator $
```  
names(D) <- c("A", "B", "C")
D$A
D[["A"]]
```
- We can have an almost infinite number of nested lists (but this is dangerous/mad/confusing/useful)
- We can add elements to a list
``` 
D[[4]] <- D 
D[[4]][[4]] <- D 
D[[4]][[4]][[3]]
```
- Can delete a component by assigning NULL to it
``` 
D[[1]] <- NULL
```
- We can append two lists
``` 
my_list = list("a", "b", "c")
your_list = list("x", "y","z")
append(my_list, your_list)
```
- But, lists themselves need to be specified beforehand 
``` 
E <- list()
```

- Data frames also combine multiple data types, but as a matrix 
``` 
data.frame( x=1:10, y = rep("hello", 10) ) 
```

## More functions
- Functions take in inputs or arguments  
- Every function has its own set of inputs it needs 
- They have to be entered into the function in the correct order 


Some useful functions:
``` 
length(my_list) # returns the length of an object 
sort(my_seq)   # sorts a list, vector or matrix  
ls()     # lists all the objects in your environment 
```
- more here: https://www.statmethods.net/management/functions.html 

## Test yourself! 
1. Generate a vector of 100 random numbers (any which way you want), and assign it to a variable called "my_random_numbers". 
2. Multiply two matrices.

Back to the [homepage](../README.md)

