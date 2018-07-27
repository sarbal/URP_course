# Lesson 3: A fun example
Let's play with real data.

## How to ... 
### Read in data
- Depending on the format, there are multiple ways to input data into R  
- From a comma or tab separated file:
```
my_data <- read.table(file="my_data.tab", header=TRUE, sep="\t")
my_data <- read.csv(file="my_data.csv")
my_data <- read.delim(file="my_data.txt", sep=":")
```
- With more control: 
```
scan()
readLines()
```
- From Excel 
```
library(xlsx)
my_data <- read.xlsx(file="my_data.xlsx", 1)
my_data <- read.xlsx(file="my_data.xlsx", sheetName = "my_sheet")
```
- From a PDF (a little more advanced)
```
install.packages("pdftools")
library("pdftools")
library("glue")
library("tidyverse")

pdf_filename  <- "example.pdf"
pdf_text_extract <- pdf_text(pdf_filename)
pdf_text_extract
page <- str_split(pdf_text_extract[[1]], "\n", simplify = TRUE)
``` 


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

## 


## Test yourself! 
1. Create an R markdown file (using RStudio). Save the file as "yourname_Lesson3.Rmd". Once again, delete the instructions starting from "This is an [R...". For the remaining exercises, insert the code as R chunks when you are satisified with your solutions. An R chunk is code placed  after a line that starts with ` ```{ r } `and ends before a line with ` ``` `.  
2. Load the file "lesson3.Rdata" into your environment. 

3. "Knit" your R markdown file into an html page, a pdf and a word document. Save the latter two. Email either file to me! 
 
Solutions: Next week!

Back to the [homepage](../README.md)
