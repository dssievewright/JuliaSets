##  Let's leave the interior of the set one color and color the outside instead

iterunbounded <- function(z, iterations = 25, epsilon = 0.1, bound = 100000){
        oldz <- z
        n <- 1
        seqit <- z
        for(i in 1:iterations){
                newz <- thefunction(oldz)
                if(Mod(newz) > bound){
                        return(n)
                        break
                }
                else if(sum(Mod(newz - seqit) < epsilon) > 0){
                        return(iterations + 100)
                        break
                }
                else{
                        seqit <- c(seqit, newz)
                        oldz <- newz
                        n <- n + 1
                }
        }
        return(iterations + 100)
}

## Creating color list... "darkblue", 
a <- colorRampPalette(c("darkblue","white", "red"))
cols <- rep.int(c(a(100), "black"), c(rep_len(1, 100), 100))

## Initializing a matrix
xseq <- function(resolution = 0.0003125, xview = c(-1.5, 1.5)){
        seq(xview[1], xview[2], by=resolution)
}
xvals <- xseq(resolution = 0.00078)
yseq <- function(resolution = 0.0004, yview = c(-1.1, 1.1)){
        seq(yview[1], yview[2], by=resolution)
}
yvals <- yseq(resolution = 0.001)

m2 <- matrix(1:(length(xvals)*length(yvals)), nrow = length(xvals), ncol = length(yvals))

## Function we will use to fill matrix with initial values.  Done in parallel
fill <- function(p){
        xco <-  Re(p) %% length(xvals)
        if(xco != 0){
                yco <- (Re(p)-xco)/length(xvals) + 1
                return(complex(real = xvals[xco], imaginary = yvals[yco]))
        }
        else{
                yco <- Re(p)/length(xvals)
                return(complex(real = xvals[length(xvals)], imaginary = yvals[yco]))
                
        }
}
m2[1,1] <- complex(real = 1)



library(parallel)
no_cores <- detectCores() - 1
clust <- makeCluster(no_cores, type = "FORK")


m2 <- parApply(clust, m2, 1:2, fill)
m2 <- parApply(clust, m2, 1:2, iterunbounded, iterations = 100, 
               bound = 1000, epsilon = 0.01)

stopCluster(clust)



bmp("neg4pos6extlarge.bmp", width = 3840, height = 2160)
par(bty = "n")
image(Re(m2), col = cols, axes = FALSE, useRaster = TRUE)
dev.off()


