# Lesson 3: A fun(ctional) example
Let's play with real data!

Download these files into your working directory: 
- [lesson3](../data/lesson3.Rdata) 
- [helper.R](../data/helper.R)
- [data](../data/my_data.zip)

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


## Reading in data
- Depending on the format, there are multiple ways to input data into R 
### From files
- From a comma or tab separated file:
```
dataA <- read.csv(file="my_dataA.csv")
dataB <- read.table(file="my_dataB.tab", header=TRUE)
datasaurus <- read.delim(file="DatasaurusDozen.txt", sep="\t")
```
- With more control: 
```
scan()
readLines()
```
- From Excel 
```
install.packages("xlsx") 
# This needs a few other packages, in particular rJava. If prompted, download the 64 bit version (for Windows) from: https://www.java.com/en/download/manual.jsp. 
# This might not be necessary,but in case
install.packages("rJava") 
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_181') # dependeing where Java is installed 

library(xlsx) 
data <- read.xlsx(file="pnasEisen1998.xlsx", 2)
key <- read.xlsx(file="pnasEisen1998.xlsx", sheetName = "Key")
```
- From a PDF (a little more advanced)
```
install.packages("pdftools")
library("pdftools")
library("glue")
library("tidyverse")

pdf_filename  <- "elife-27469-v1.pdf"
pdf_text_extract <- pdf_text(pdf_filename)
length(pdf_text_extract)
page <- str_split(pdf_text_extract[[5]], "\n", simplify = TRUE) 
```

```
load("lesson3.Rdata") # if the pdf extraction didn't work 
table <- unlist(page)[4:20]
```
- extract the columns, using substr(), trimws() and sapply()
```
col1 = sapply(1:length(table), function(i) trimws(substr( table[i], 38, 81)))
col2 = sapply(1:length(table), function(i) trimws( substr( table[i], 82, 96 )))
col3 = sapply(1:length(table), function(i) trimws(substr( table[i], 97, 111 )))
col4 = sapply(1:length(table), function(i) trimws(substr( table[i], 112, 132 )))
col5 = sapply(1:length(table), function(i) gsub("\r", "", trimws(substr( table[i], 133, 150 ))))
```
- merge the columns together into a table with cbind()
```
data_table = cbind(cbind(col2, col3, col4,col5)[1,],  t(cbind(col2, col3, col4,col5)[-1,]))
colnames(data_table) =  c("day", col1[-1] )
rownames(data_table) = cbind(col2, col3, col4,col5)[1,]
data_table = as.data.frame(data_table)
temp1 = apply(data_table, 2, as.numeric, as.character)
temp1 = as.data.frame(temp1)
temp1[,5] = as.factor(data_table[,5] )
temp1[,1] = as.factor(data_table[,1] )
rownames(temp1) = rownames(data_table)
data_table = temp1
```


### From other places, types  
- URLs: using RCurl, e.g., http://rfunction.com/archives/1672 
- SQL databases: using DBI, dblplyr, or plyr. e.g., SRADB https://www.rdocumentation.org/packages/SRAdb/versions/1.30.0/topics/getSRA 
- APIs: using httr, jsonlite, e.g., https://www.r-bloggers.com/accessing-apis-from-r-and-a-little-r-programming/ 
- Twitter: httpuv, twitteR, ROAuth, rtweet, ... e.g., https://cran.r-project.org/web/packages/rtweet/vignettes/intro.html


### Clean up data
- Data/sanity checks
- Does it looks like what you think it should? 
- Same number of lines imported as file contains? 
- No weird characters? Some special characters have special properties when being read in. 
- How many empty values? Find/replace empty values with NAs 
- Correct data type? If numbers are stored as characters, there may be something odd in your input. 
- Put data into different variables, into tables or into the tidyverse. 

### Save/export data
- As text 
```
write.table(my_list, file="my_list.txt", sep="\t", quote="", row.names=T)
write.csv(my_list, file="my_list.csv")
```
- As binary file
```
all_my_data <- rnorm(10000) 
my_function <- function(x){ 
  print("Hello, world!") 
}
save(all_my_data, my_function, file="my_data.Rdata")
```
### Saving graphics 
- As a pdf or postscript (vector graphics) 
```
pdf("my_plot.pdf") # or try postscript()  
plot(my_data)
dev.off() 
```
- Or as an image (.png, .jpeg)
```
png("my_plot.png") # or try # jpg() 
plot(my_data)
dev.off() 
```
## Functions 
- User defined or from other packages 
- The structure of a function: 
```
my_function <- function(arg1, arg2, ... ){
  commands (or statements)
  return(object)
}
```
- objects in the function are local, so changing them within the function does not have a global effect (mostly, but beware!)
- objects returned can be any data type
- can look inside other functions to see how they work:
```
dist
```
- you can write your function for tasks that are usually repetitive or have some 'abstract' function
```
my_plot <- function(data){ 
 plot(data, pch=19, col="blue", cex=2)
}
```

## Test yourself! 
1. Create an R markdown file (using RStudio). Save the file as "yourname_Lesson3.Rmd". Once again, delete the instructions starting from "This is an [R...". For the remaining exercises, insert the code as R chunks when you are satisified with your solutions. An R chunk is code placed  after a line that starts with ` ```{ r } `and ends before a line with ` ``` `.  
2. Load the file "lesson3.Rdata" into your environment. Check and tidy up the datasets.
3. "Knit" your R markdown file into an html page, a pdf and a word document. Save the latter two. Email either file to me! 
 
Solutions: Next week!

Back to the [homepage](../README.md)
