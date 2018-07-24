# Lesson 2: More R
Some visual things you can do with R. Once more, download these files into your working directory: 
- [lesson2](../data/lesson2.Rdata). 
- [helper.R](../data/helper.R)
####  
To check your working directory:
```
getwd()
```
To set your working diretory: 
```
setwd("H:/URP")
```
Run this to install/load libraries
```
source("helper.R") 
```


## Visuals
- R is pretty good for visualization
- We will start off with the famous [Iris](http://stat.ethz.ch/R-manual/R-devel/library/datasets/html/iris.html) dataset. You can read more about it [here](https://en.wikipedia.org/wiki/Iris_flower_data_set).   
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
- Similar to calling this function, which plots a matrix of scatterplots:
```
pairs(iris, upper.panel = NULL )
```
- Now that we've seen all the bits of the data, we can play with visualizing parts of it differently  
- Let's start with a scatter plot of the sepal length versus the petal length
``` 
plot(iris$Sepal.Length, iris$Petal.Length, pch=19, col=as.numeric(iris$Species) )
```
- let's play around with this
``` 
## Playing with parameters 
plot(iris$Sepal.Length, iris$Petal.Length, pch=12, cex=3, lwd=4, lty=4, type="b", col=colors()[sample(600,5)][as.numeric(iris$Species)] )
## Plotting smoothed version
plot(lowess(iris$Sepal.Length, iris$Petal.Length), pch=19)
## Plotting using the forumla method 
plot(Petal.Length ~ Sepal.Length, data=iris, pch=19, col=Species)
```

- We can view sepal width by species distributions with a boxplot, beanplot, violin plot or "joy" plots: 
``` 
boxplot(iris$Sepal.Width~ iris$Species, col=1:3 )
beanplot(iris$Sepal.Width~ iris$Species, col=list(1,2,3))
iris.list = lapply( unique(iris$Species), function(si) iris$Sepal.Width[iris$Species==si]) 
vioplot( iris.list[[1]], iris.list[[2]], iris.list[[3]], col="darkgreen")  
```
- or take a look at the distribution of petal width
``` 
hist(iris$Petal.Width, col="lightblue")
```
- or build a barplot :
``` 
iris.bar = tapply( iris$Sepal.Length, iris$Species, mean)
barplot(iris.bar, col="black", xlab="Species", ylab="Count", main="Bar plot of mean Sepal Length")
```
- We see biomodality (two modes/peaks) in the petal width data 
- And there is a clear division (<0.75)
- Let us take a look to see what is distinct about the first peak 
- Since we want petal widths less than 0.75, we can slice the data:
``` 
small_petals <- which(iris$Petal.Width <0.75)
count(iris$Species[small_petals])
count(iris$Species)
```
- That was easy enough, and we can show this again by coloring the histogram based on the species
- Plots in R work by layering, so we can start by drawing the whole histogram first
```
hist(iris$Petal.Width, col="lightblue")
``` 
- And then adding each individual species as a layer  
```
hist(iris$Petal.Width[iris$Species=="setosa"], col="red", add=T)
hist(iris$Petal.Width[iris$Species=="versicolor"], col="blue", add=T)
hist(iris$Petal.Width[iris$Species=="virginica"], col="purple", add=T)
```
- Oops! The histograms are all wonky because we've not specified how bin the data. R works "intuitively", and picks the best breaks for that data.  
- We can force similar histogram breaks so that we can bin the data equally
```
h <- hist(iris$Petal.Width, col="lightblue")
h
```
- The h variable has the histogram output
- It has useful tags that we can use such as h$counts, h$mids and most importantly, h$breaks.   
```
hist(iris$Petal.Width[iris$Species=="setosa"],  breaks=h$breaks,col="red", add=T)
hist(iris$Petal.Width[iris$Species=="versicolor"], breaks=h$breaks, col="blue", add=T)
hist(iris$Petal.Width[iris$Species=="virginica"],  breaks=h$breaks,col="purple", add=T)
```
- There is still some overlap, so we can play with the opacity of the colors, and force no color for the first histogram
```
h <- hist(iris$Petal.Width, col=0, border=0)
hist(iris$Petal.Width[iris$Species=="setosa"],  breaks=h$breaks,col=make_transparent("red"), add=T)
hist(iris$Petal.Width[iris$Species=="versicolor"], breaks=h$breaks, col=make_transparent("blue"), add=T)
hist(iris$Petal.Width[iris$Species=="virginica"],  breaks=h$breaks,col=make_transparent("purple"), add=T)

```
- How about some density lines? 
```
lines()
```
- We can keep adding layers to our plots with other functions:
```
points()
polygon()
segments()
abline()
rug()
text()
mtext()
legend()
...
```
- More fun things to play with too 
```
pch
type
lty
lwd
bty
... 
```
- Going back to the matrix scatterplot, let's have a visual that summarizes all the data
```
## Ignore these for now 
panel.hist <- function(x, ...)
{
    usr <- par("usr"); on.exit(par(usr))
    par(usr = c(usr[1:2], 0, 1.5) )
    h <- hist(x, plot = FALSE)
    breaks <- h$breaks; nB <- length(breaks)
    y <- h$counts; y <- y/max(y)
    rect(breaks[-nB], 0, breaks[-1], y, col = "lightgreen", ...)
}
## with size proportional to the correlations.
panel.cor <- function(x, y, digits = 2, prefix = "", cex.cor, ...)
{
    usr <- par("usr"); on.exit(par(usr))
    par(usr = c(0, 1, 0, 1))
    r <- abs(cor(x, y))
    txt <- format(c(r, 0.123456789), digits = digits)[1]
    txt <- paste0(prefix, txt)
    if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
    text(0.5, 0.5, txt, cex = cex.cor * r, col= plasma(100)[round(r,2)*100])
}
pairs(iris, bg=1:3,lower.panel = panel.smooth, pch=19, upper.panel = panel.cor, diag.panel = panel.hist, cex.labels = 2, font.labels = 2)
```

- Great. What if we want to ask how similar are these individual plants to each other within each species. What can we look at? 
- Correlations are fun. 
```
iris2  = apply(iris[,1:4], 2, as.numeric)
heatmap.3(iris2, RowSideCol=cols7[as.numeric(iris$Species)] , col=viridis(100))
iris.r  = t(apply(iris[,1:4], 1, rank))
heatmap.3(iris.r, RowSideCol=cols7[as.numeric(iris$Species)] , col=viridis(100))
iris.r2  = apply(iris[,1:4], 2, rank)
heatmap.3(iris.r2, RowSideCol=cols7[as.numeric(iris$Species)] , col=viridis(100))
samples.cor = cor( t(iris2) )
heatmap.3(samples.cor, col=plasma(100), ColSideCol=cols7[as.numeric(iris$Species)])
```


## "Tidyr" versions 
We can do most all of this with [ggplot2](https://github.com/rstudio/cheatsheets/blob/master/data-visualization-2.1.pdf).There are less things finicky things to worry about, and is generally more intuitive. 
```
g <- ggplot(iris, aes(x = Sepal.Length, y = Petal.Length)) 
```
- This does nothing, because we've not specified what we want to draw:
```
g <- g + geom_point() 
```
- Points! Now to color them:
```
g <- g + geom_point(aes(color = Species))
```
- We can keep building onto the "g" variable. 
```
g <- ggplot(iris, aes(x = Sepal.Length, y = Petal.Length, color = Species)) + geom_point()  +  geom_smooth(method = "lm", se = F) 

``` 
- How about boxplots? 
```
g <- ggplot(data=iris, aes(x=Species, y=Sepal.Length))
g + geom_boxplot(aes(fill=Species)) + 
  ylab("Sepal Length") + ggtitle("Iris Boxplot") +
  stat_summary(fun.y=mean, geom="point", shape=5, size=4)  
```
-- Histograms:
```
g <- ggplot(data=iris, aes(x=Sepal.Width))
g + geom_histogram(binwidth=0.2, color="black", aes(fill=Species)) +  xlab("Sepal Width") +  ylab("Frequency") + ggtitle("Histogram of Sepal Width") 
```
--- Barplots:
```
g <- ggplot(data=iris, aes(x=Species, y=Sepal.Length))
g + geom_bar(stat = "summary", fun.y = "mean") + 
+ xlab("Species") +  ylab("Mean") + ggtitle("Bar plot of mean Sepal Length") 
```
More [here](https://www.mailman.columbia.edu/sites/default/files/media/fdawg_ggplot2.html)

## Colors and palettes 
```
colors() 
palette()
```
- Preset colors as strings or as numbers 
- Or based on their RGB 
- e.g.,
```
blacks = c("black", 1, "#000000") 
reds = c("red", 2, "#FF0000") 
allreds = colors()[grep("red", colors())]
```
- Color ramps 
 ```
allredsRamp <- colorRampPalette(allreds)
allredsRamp(100)
grey2blue = colorpanel(100, "lightgrey", "blue", "darkblue")
```
- Predefined palettes:
- default R:
```
rainbow(5)
heat.colors(10)
terrain.colors(100)
topo.colors(10)
cm.colors(5)
```
- R color brewer
```
library(RColorBrewer)
display.brewer.all()
brewer.pal(8, "Set3" ) 
```
- everyone's new favorite are the viridis palettes (color-blind friendly)
```
library(viridis)
magma()
plasma()
inferno()
viridis()
cividis()
```

#### More here: 
- https://www.nceas.ucsb.edu/~frazier/RSpatialGuides/colorPaletteCheatsheet.pdf
- https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
- https://moderndata.plot.ly/create-colorful-graphs-in-r-with-rcolorbrewer-and-plotly/



## Test yourself! 
1. Create an R markdown file (using RStudio). Save the file as "yourname_Lesson2.Rmd". Once again, delete the instructions starting from "This is an [R...". For the remaining exercises, insert the code as R chunks when you are satisified with your solutions. An R chunk is code placed  after a line that starts with ` ```{ r } `and ends before a line with ` ``` `.  
2. Load the file "lesson2.Rdata" into your environment. Plot three heatmaps of the dataset "X". Be as creative as you can in one, as deceptive as you can in the second, and then as clear as you can in the last.
3. Now, using the dataset "Y", plot a scatterplot of the x and y variables. Aim for clarity! 
4. And finally, look at dataset "Z". Plot it the best way you think would show its key feature. 
5. "Knit" your R markdown file into an html page, a pdf and a word document. Save the latter two. Email either file to me! 
 
Solutions: Next week!

Back to the [homepage](../README.md)
