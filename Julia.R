## Set the function you want to use: 
## This will apply the function once to z each time it is run
thefunction <- function(z){
        z <- z^2 + complex(real = -0.4, imaginary = 0.6)
        return(z)
}

## Iterates the function, appling it to z a fixed number of times
iterating <- function(z, iterations = 25){
        for(i in 1:iterations){
                z <- thefunction(z)
        }
        return(z)
}

## Uses above function to return whether or not value Belinda to Julia set

in.Julia2 <- function(z, iter2 = 25, bound = 1000000){
                z <- iterating(z, iterations = iter2)
                if(Mod(z) > bound){
                        return(FALSE)
                }
                else{ return(TRUE)}
}



## iterates and checks to see if bound is exceeded.  
## Hopefully quicker version of iterating/inJulia combo.

iteratingbound <- function(z, iterations = 25, bound = 100000){
        for(i in 1:iterations){
                z <- thefunction(z)
                if(Mod(z) > bound){
                        return(FALSE)
                        break
                }
        }
        if(Mod(z) <= bound){
                return(TRUE)
        }
} 



## function to return number of iterations it takes for convergence.
## returns a numeric value equal to number of iterations needed to "converge".
## if values are "unbounded", returns a value much larger than iterations.

iterboundn <- function(z, iterations = 25, epsilon = 0.001, bound = 100000){
        oldz <- z
        n <- 1
        for(i in 1:iterations){
                newz <- thefunction(oldz)
                if(Mod(newz) > bound){
                        return(iterations + 10)
                        break
                }
                else if(Mod(newz - oldz) < epsilon){
                        return(n)
                        break
                }
                else{
                        oldz <- newz
                        n <- n + 1
                }
        }
        return(n)
}


## Function to determine if iterations get close to the c value: z^2 +c
## that is used in our initial function

iterboundnsecond <- function(z, iterations = 25, epsilon = 0.1, bound = 100000){
        oldz <- z
        n <- 1
        for(i in 1:iterations){
                newz <- thefunction(oldz)
                if(Mod(newz) > bound){
                        return(iterations + 100)
                        break
                }
                else if(Mod(newz - oldz) < epsilon){
                        return(n)
                        break
                }
                else if(Mod(newz - complex(real = -0.4, imaginary = 0.6)) < epsilon & n > (iterations / 2)){
                        return(n)
                        break
                }
                else{
                        oldz <- newz
                        n <- n + 1
                }
        }
        return(n)
}


## Altering previous function so it is not so reliant on -.4 + .6i

iterboundnthird <- function(z, iterations = 25, epsilon = 0.1, bound = 100000){
        oldz <- z
        n <- 1
        seqit <- z
        for(i in 1:iterations){
                newz <- thefunction(oldz)
                if(Mod(newz) > bound){
                        return(iterations + 100)
                        break
                }
                else if(sum(Mod(newz - seqit) < epsilon) > 0){
                        return(n)
                        break
                }
                else{
                        seqit <- c(seqit, newz)
                        oldz <- newz
                        n <- n + 1
                }
        }
        return(n)
}



## initialize matrix
## viewscreen is the window we will plot, vector is of form c( min RE, max RE, min IM, max IM)
## resolution determines jumps in starting values. 
## e.g., if min RE is -2, and resolution is 0.1, real values for iterating will be -2, -1.9, -1.8, etc.

initmatrix <- function(resolution = 0.01, viewscreen = c(-2, 2, -2, 2)){
        sequencex <- seq(viewscreen[1], viewscreen[2], by=resolution)
        sequencey <- seq(viewscreen[3], viewscreen[4], by=resolution)
        m <- matrix(nrow = length(sequencex), ncol = length(sequencey))
        for(x in sequencex){
                for(y in sequencey){
                        m[round((x + resolution - viewscreen[1]) / resolution), round((y + resolution - viewscreen[3]) / resolution)] <- complex(real = x, imaginary = y)
                }
        }
        return(m)
}


## applying iterations to entries in matrix. FUN.VALUE takes guess work out of expected outputs perhaps making it quicker.
## option 1 (quickest??): m[] <- vapply(m, iterating, FUN.VALUE = complex(1), iterations = 25)
## option 2 (quickest??): m <- structure(vapply(m, iterboundn, FUN.VALUE = numeric(1), iterations = 25, epsilon = 0.001, bound = 100000), dim = dim(m))
## option 3 (slowest??): m <- apply(m, 1:2, iteratingbound)



## Initialize matrix: m <- initmatrix(...)
## Copy: m2 <- m
## m2[] <- vapply(m, iterboundn, FUN.VALUE = numeric(1), iterations = 100, bound = 1000000, epsilon = 0.01)
## image(Re(m3), col = heat.colors(20), axes = FALSE, useRaster = TRUE)





## png('filename.png')  
## or jpeg("filename.jpeg")
## image(m, ...)
## dev.off()