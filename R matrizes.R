area_triangulo <- function(x1,y1,x2,y2,x3,y3) {
  area <- abs(x1*(y2-y3) + x2 * (y3-y1) + x3 * (y1-y3)) / 2
  return(area)
}

x1 <- 0
y1 <- 0
x2 <- 4
y2 <- 0
x3 <- 0
y3 <- 3


area123 <- area_triangulo(x1, y1, x2, y2, x3, y3)

elementos <- c(3, 4, -1, 2)
A <- matrix(elementos,nrow = 2, byrow = TRUE)
det_A <- det(A)


matriz2 <- c(1, 2, 3, -4, 2,
            0, 1, 0, 0, 0,
            0, 4, 0, 2, 1,
            0, -5, 5, 1, 4,
            0, 1, 0, -1, 2)

B <- matrix(matriz2, nrow = 5, byrow = TRUE)
det_B <- det(B)

L1 <- c(1, 2, 3, -4, 2)
L2 <- c(0, 1, 0, 0, 0)
L3 <- c(0, 4, 0, 2, 1)
L4 <- c(0, -5, 5, 1, 4)
L5 <- c(0, 1, 0, -1, 2)

Matriz3 <- rbind(L1, L2, L3, L4, L5)
Determinante <-(Matriz3)