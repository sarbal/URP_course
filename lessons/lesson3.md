# Lesson 3: A fun example
Let's play with real data.

## How to ... 
### Read in data
- Depending on the format, there are multiple ways to input data into R  
- From a comma or tab separated file:
```
my_data <- read.table(file="my_data.tab". header=TRUE, sep="\t")
my_data <- read.csv(file="my_data.csv")
```
- From Excel 
```
library(xlsx)
my_data <- read.xlsx(file="my_data.xlsx", 1)
my_data <- read.xlsx(file="my_data.xlsx", sheetName = "my_sheet")
```
From a PDF
```

```

### Clean up data

### Save data



Back to the [homepage](../README.md)
