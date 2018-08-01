# Lesson 4: Another potentially fun example.


Download these files into your working directory: 
- [lesson4](../data/lesson4.Rdata) 
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

## Replicating a figure
Let's take a look at this paper:  https://genome.cshlp.org/content/22/4/602
They've made their data available (the link in the paper is broken): http://giladlab.uchicago.edu/data/final.data.tgz  
A relatively straightforward analysis is in their supplement: https://genome.cshlp.org/content/suppl/2012/01/03/gr.130468.111.DC1/SupplementalFigures_08_09_11.pdf 

1. Get data 

```
gene_expression_file = " Gene.expression.data/Normalized.expression.data.txt" 
exprs = read.table(gene_expression_file, header=T, row.names=1) 
samples = matrix(unlist(strsplit(colnames(exprs)[33:94] , "_" ) ) , byrow=T, ncol=2)
```
2. Clean up data
```
exprs.means = t(sapply(1:dim(exprs)[1], function(i) tapply(  as.numeric(exprs[i,33:94]), samples[,1], mean, na.rm=T) ))
samples.sub = names(tapply(  as.numeric(exprs[i,33:94]), samples[,1], mean, na.rm=T)) 
colnames(exprs.means) = samples.sub
rownames(exprs.means) = rownames(exprs)
```
3. Data analysis 
- Which genes are present in enough species?
- Which species does not have enough data?
```
colSums(is.na(exprs.means ))
filt.species = which.max(colSums(is.na(exprs.means )))
gene.subset  = rowSums(is.na(exprs.means[,-filt.species ] )  ) >5  

samples.cor = cor(exprs.means[gene.subset,-filt.species ], m="s", use="p")
```
4. Plot/graph 

```
heatmap.3(samples.cor)
samples.cor = cor(exprs.means[ ,-filt.species], m="s", use="p")
heatmap.3(samples.cor)
``` 


## The many ways of gene set enrichment 
Follow this: 
https://cran.r-project.org/web/packages/enrichR/vignettes/enrichR.html 

```
install.packages("enrichR")
library(enrichR)
dbs <- listEnrichrDbs()
dbs <- c("GO_Molecular_Function_2015", "GO_Cellular_Component_2015", "GO_Biological_Process_2015")
enriched <- enrichr(c("Runx1", "Gfi1", "Gfi1b", "Spi1", "Gata1", "Kdr"), dbs)
```


```
library(EGAD)
annot = make_annotations( (GO.mouse[,c(1,3)][GO.mouse[,4]!="IEA",] ), unique(GO.mouse[,1]), unique(GO.mouse[,3]) )    
enriched2 <- gene_set_enrichment(c("Runx1", "Gfi1", "Gfi1b", "Spi1", "Gata1", "Kdr"), annot, voc)
```





Back to the [homepage](../README.md)
