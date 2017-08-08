## Make sure you have Julia.R in working directory 
## otherwise, the following will download it for you.
if(!file.exists("Julia.R")){
        download.file("https://raw.githubusercontent.com/dssievewright/JuliaSets/master/Julia.R",
                      "Julia.R")}
source("Julia.R")

thefunction <- function(z){
        z <- z^3 + complex(real = -0.4, imaginary = 0.6)
        return(z)
}

library(parallel)
no_cores <- detectCores() - 1
clust <- makeCluster(no_cores, type = "FORK")



m2 <- initmatrix(resolution = 0.001)
m3 <- parApply(clust, m2, 1:2, iterboundnthird, iterations = 100, 
               bound = 1000000, epsilon = 0.01)

stopCluster(clust)



jpeg("neg4pos6cubic.jpeg", width = 4000, height = 4000)
image(Re(m3), col = heat.colors(50), axes = FALSE, useRaster = TRUE)
dev.off()