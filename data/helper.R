#########################################
#  	Helper functions	    	#
#########################################

##  Written: Sara Ballouz
##  Date: July 23rd, 2018

## Necessary libraries
if( !require("gplots")){
  install.packages("gplots")
}
if( !require("plyr")){
  install.packages("plyr")
}
if( !require("RColorBrewer")){
  install.packages("RColorBrewer")
}
if( !require("viridis")){
  install.packages("viridis")
}
if( !require("beanplot")){
  install.packages("beanplot")
}
if( !require("beeswarm")){
  install.packages("beeswarm")
}
if( !require("corrgram")){
  install.packages("corrgram")
}
if( !require("vioplot")){
  install.packages("vioplot")
}
if( !require("pheatmap")){
  install.packages("pheatmap")
}
if( !require("vioplot")){
  install.packages("vioplot")
}

if( !require("tidyverse")){
  install.packages("tidyverse")
}

# Colors 
cols = colorpanel(16, "red", "blue")
cols2 = brewer.pal(8, "Spectral")
cols3= rainbow(30)
cols4 = colorpanel(63, "lightgrey", "blue", "darkblue")
cols5 = colorpanel(300, "lightgrey", "red", "darkred")
cols6 = colorpanel(100, "lightgrey", "red", "darkmagenta")
cols7 = c("seagreen", "black", "darkmagenta")
cols8 = viridis(10)
cols9 = colorpanel(100, "white", "red", "darkmagenta")
cols10 = colorpanel(100, "white", "blue", "darkcyan")
cols11 = colorpanel(100, "white", "orange", "deeppink4")
cols12 = magma(100)
cols13 = viridis(100)



# Random functions 
rank_std <- function(x)  { r = rank( x, na.last="keep"); r/max(r, na.rm=T)  }
colSD <- function( data){ return(apply( data, 2, sd, na.rm=T))}
rowSD <- function( data){ return(apply( data, 1, sd, na.rm=T))}
colSE <- function( data){ return( apply( data, 2, sd, na.rm=T)/sqrt(dim(data)[2]))}
rowSE <- function( data){ return( apply( data, 1, sd, na.rm=T)/sqrt(dim(data)[1]))}
se    <- function(x){ sd(x,na.rm=T)/sqrt(length(!is.na(x))) }
rmse  <- function(error){sqrt(mean(error^2, na.rm=T) )}
mae   <- function(error){ mean(abs(error), na.rm=T)}

geo_mean <- function(data) {
    log_data <- log(data)
    gm <- exp(mean(log_data[is.finite(log_data)]))
    return(gm)
}

geo_sd <- function(data) {
    log_data <- log(data)
    gs <- exp(sd(log_data[is.finite(log_data)]))
    return(gs)
}

geo_se <- function(data) {
    gs <- geo_sd(data)
    log_data <- log(data)
    gse <- gs/sqrt(sum(is.finite(log_data)))
    return(gse)
}


lm.studentized  <- function(x,y){
	z = lm(y ~ x )
        z = rstudent(z)
	return( rank(abs(z)) )
}

lm.function  <- function(x,y){
	z = lm(y ~ x )
	return( rank(abs(z$residuals)) )
}


residuals <- function(x,y,A,B,C){ (A*x + B*y + C) }
residuals2 <- function(x,y,A,B,C) { (A*x + B*y + C)/sqrt(A^2+B^2) }
residuals3 <- function(x,y,A,B,C) { abs(A*x + B*y + C)/sqrt(A^2+B^2) }

z_scores <- function(x) {
   mean_x = mean(x, na.rm=T)
   sd_x = sd(x, na.rm=T)
   z =  (x - mean_x) / (sd_x)
   return(z)
}

z_scores_mod <- function(x) {
   med_x = median(x, na.rm=T)
   mad_x = median(abs(x-med_x), na.rm=T)
   z =  0.6745 * (x - med_x) / (mad_x)
   return(z)
}

calc_cpm <-function(X){
        K  = colSums(X)
        X.cpm = sapply(1:length(K), function(k) 10^6*X[,k]/K[k] )
        return(X.cpm)
}


heatmap.3 <- function(mat, ...){
	heatmap.2( mat, ..., density="none", trace="none")
}




# Transparent colors
makeTransparent<-function(someColor, alpha=100)
{
	newColor<-col2rgb(someColor)
	apply(newColor, 2, function(curcoldata){rgb(red=curcoldata[1], green=curcoldata[2],
	blue=curcoldata[3],alpha=alpha, maxColorValue=255)})
}


# Given x and two points
get_value <- function( x1, x2, y1,y2, x) {
	m = (y2 - y1) / (x2 - x1 )
	y = y1 + m *( x - x1)
	return(y)
}

# Given y and two points
get_value_x <- function( x1, x2, y1,y2, y) {
	m = (y2 - y1) / (x2 - x1 )
	x = x1 + (y - y1)/m
        return(x)
}


## Formats the density distribution from the histogram function
get_density <- function(hist)
{
        x = sort(rep(hist$breaks,2))
        y = matrix(rbind(hist$density, hist$density))
        y = c(0,y,0)

        return(cbind(x,y))
}


## Formats the counts distribution from the histogram function
get_counts <- function(hist)
{
        x = sort(rep(hist$breaks,2))
        y = matrix(rbind(hist$counts, hist$counts))
        y = c(0,y,0)

        return(cbind(x,y))
}

# Tic toc functions
tic <- function(gcFirst = TRUE, type=c("elapsed", "user.self", "sys.self"))
{
	type <- match.arg(type)
	assign(".type", type, envir=baseenv())
	if(gcFirst) gc(FALSE)
	tic <- proc.time()[type]
	assign(".tic", tic, envir=baseenv())
	invisible(tic)
}

toc <- function()
{
	type <- get(".type", envir=baseenv())
	toc <- proc.time()[type]
	tic <- get(".tic", envir=baseenv())
	print(toc - tic)
	invisible(toc)
}

convolve_nets <- function(netA,netB,f){
	n <- order(netA)
	temp_netA <- netA[n]

	temp_netB = convolve( netB[n], rep(1,f),type="filter")
	convolved = cbind(temp_netA[(f/2):(length(temp_netA)-f/2)],temp_netB/f)
}

gene_set_enrichment <- function(genes, genes.labels, voc){

        genes.names = rownames(genes.labels)
	labels.names = colnames(genes.labels)
        genes.counts = rowSums(genes.labels)
	labels.counts = colSums(genes.labels)              			# p

	m = match ( genes, genes.names )
	filt.genes  = !is.na(m)
	filt.labels = m[filt.genes]


	labels.counts.set = rep( sum(filt.genes), length(labels.counts) )	# g

        m = match (labels.names, voc[,1])
        v.f = !is.na(m)
        v.g = m[v.f]

	universe = rep ( dim(genes.labels)[1], dim(genes.labels)[2])
	if(  length(filt.labels) == 1 ) { genes.counts.set = genes.labels[filt.labels,] }
	else { genes.counts.set = colSums(genes.labels[filt.labels,]) }             ## does weird things with 0 sets

	test =  cbind( (genes.counts.set -1) , labels.counts, universe-labels.counts, labels.counts.set)
        pvals = phyper(test[,1], test[,2], test[,3], test[,4], lower.tail=F)
        pvals.adj = p.adjust( pvals, method="BH")

	results = cbind(voc[v.g,1:2], test[v.f,c(1)]+1, test[v.f,c(2)] , pvals[v.f], pvals.adj[v.f] )
	colnames(results) = c("term", "descrp","p", "q", "pvals", "padj" )
        results =  results[results[,3] > 0 ,]
	return (results)

}
