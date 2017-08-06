

in.Julia2 <- function(z, realpart, imaginarypart, iterations = 25, bound = 1000000)
{
        z<-z
        for (i in 1:iterations)
        {
                z <- z^2 + complex(real = realpart, imaginary = imaginarypart)
                if (Mod(z) > bound)
                {
                        return(FALSE)
                }
        }
        
        return(TRUE)
}


creatematrixforplot <- function(realpart1, imaginarypart1, resolution = .01, viewscreen = c(-1,1,-1,1), iterations1=25 ,bound1=1000000)
{
        res <- resolution        
        sequencex <- seq(viewscreen[1], viewscreen[2]-viewscreen[1], by=resolution)
        sequencey <- seq(viewscreen[3], viewscreen[4]-viewscreen[3], by=resolution)
        m <- matrix(nrow = length(sequencex), ncol = length(sequencey))
        for (x in sequencex)
        {
                for (y in sequencey)
                {
                        Julia2 <- in.Julia2(complex(real = x, imaginary = y), realpart1, imaginarypart1, iterations = iterations1, bound = bound1)
                        m[round((x + resolution - viewscreen[1]) / resolution), round((y + resolution - viewscreen[3]) / resolution)] <- Julia2
                }
        }
        return(m)
}


m<- creatematrixforplot(realpart1 = , imaginarypart1 = , resolution = .01, viewscreen = c(-1,1,-1,1), iterations1 = 100, bound1 = 100))


png('filename.png')  or jpeg("filename.jpeg")
image(m)
dev.off()