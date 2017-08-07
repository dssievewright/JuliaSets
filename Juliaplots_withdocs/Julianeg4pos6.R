thefunction <- function(z){
        z <- z^2 + complex(real = -0.4, imaginary = 0.6)
        return(z)
}

m2 <- initmatrix(resolution = 0.005)
m3 <- m2
m3[] <- vapply(m2, iterboundnsecond, FUN.VALUE = numeric(1), iterations = 100, 
               bound = 1000000, epsilon = 0.015)
jpeg("Julianeg4pos6.jpeg", width = 800, height = 800)
image(Re(m3), col = heat.colors(50), axes = FALSE, useRaster = TRUE)
dev.off()