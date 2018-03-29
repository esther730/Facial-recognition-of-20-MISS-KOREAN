#1
# create a function for principle analysis
pcafun = function(x){
  c = ( t(x)-apply(x,2,mean) ) %*% t( t(x)-apply(x,2,mean) )
  ei = eigen(c)$value
  eiv = eigen(c)$vector
  return( list(ei,eiv))
}


#2
# test the pca function with iris dataset
x = as.matrix(iris[,1:4])
pcafun(x)
pca1<- prcomp(iris[,1:4], center=TRUE, scale=FALSE)
summary(pca1)
pca1$rotation


#3
# start with miss korean data
# setwd('C:/Users/Esther/Desktop/miss_korean')
data=as.matrix(read.table("Data_MissKorea_RGB.txt", sep="\t"))

#(a)
# perform pca and report proportion of variations
pca1<- prcomp(t(data), center=TRUE, scale=FALSE)
summary(pca1)


#(b)
# plot first and second principle components(eign-faces)
library(grid)
comp=pca1$rotation[,1]
#comp=abs(comp)
comp=(comp-min(comp))/(max(comp)-min(comp))
r=matrix(comp[1:(109*109)], nrow=109)
g=matrix(comp[(109*109+1):(109*109*2)], nrow=109)
b=matrix(comp[(109*109*2+1):(109*109*3)], nrow=109)
col=rgb(r,g,b)
dim(col)=dim(r)
grid.raster(col, interpolate=FALSE)

comp=pca1$rotation[,2]
#comp=abs(comp)
comp=(comp-min(comp))/(max(comp)-min(comp))
r=matrix(comp[1:(109*109)], nrow=109)
g=matrix(comp[(109*109+1):(109*109*2)], nrow=109)
b=matrix(comp[(109*109*2+1):(109*109*3)], nrow=109)
col=rgb(r,g,b)
dim(col)=dim(r)
grid.raster(col, interpolate=FALSE)

#(c)
# try to perform pca without centering
# compare the proportion of variations
pca1<- prcomp(t(data), center=FALSE, scale=FALSE)
summary(pca1)

#(d)
# plot the first and second eign-faces again
comp=pca1$rotation[,1]
comp=abs(comp)
comp=(comp-min(comp))/(max(comp)-min(comp))
r=matrix(comp[1:(109*109)], nrow=109)
g=matrix(comp[(109*109+1):(109*109*2)], nrow=109)
b=matrix(comp[(109*109*2+1):(109*109*3)], nrow=109)
col=rgb(r,g,b)
dim(col)=dim(r)
grid.raster(col, interpolate=FALSE)

comp=pca1$rotation[,2]
#comp=abs(comp)
comp=(comp-min(comp))/(max(comp)-min(comp))
r=matrix(comp[1:(109*109)], nrow=109)
g=matrix(comp[(109*109+1):(109*109*2)], nrow=109)
b=matrix(comp[(109*109*2+1):(109*109*3)], nrow=109)
col=rgb(r,g,b)
dim(col)=dim(r)
grid.raster(col, interpolate=FALSE)

# compare the result
# With centering or substract by the mean will make the face become blur
# with centering, both the proportion of variation and standard deviation decrease.