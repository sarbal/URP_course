# Lesson 2: More R
Some visual things you can do with R.


## Visuals
- R is good for visualization
- Example data (stored in R) 
``` 
summary(iris)
class(iris)
colnames(iris)
```
- the iris dataset is a dataframe, and the columns are labelled 
- first, we can be a little uncouth, and plot everything 
``` 
plot(iris)
```
- this mostly works because there aren't too many data points 
- But, now that we've seen all the bits of the data, we can play with visualizing parts of it differently  
- Let's start with a scatter plot of the sepal length versus the petal length
``` 
plot(iris$Sepal.Length, iris$Petal.Length, pch=19, col=as.numeric(iris$Species) )
```
- We can view sepal width by species distributions with a boxplot
``` 
boxplot(iris$Sepal.Width~ iris$Species, col=1:3 )
```
- or take a look at the distribution of petal width
``` 
hist(iris$Petal.Width, col="lightblue")
```
- We see biomodality (two modes/peaks)
- And there is a clear division (<0.75)
- Let us take a look to see what is distinct about the first peak 
- Since we want petal widths less than 0.75, we can slice the data:
``` 
small_petals <- which(iris$Petal.Width <0.75)
count(iris$Species[small_petals])
count(iris$Species)
```




Back to the [homepage](../README.md)
