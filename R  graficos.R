C <- function(x) 5000 + 15 * x
R <- function(x) 40 * x
L <- function(x) R(x) - C(x)

t1 <- L(100)
t2 <- L(150)
t3 <- L(200)
t4 <- L(250)

Equilibrio <- uniroot(L,c(0,1000))

valores_x <- seq(0,400, by = 1)
valores_c <- C(valores_x)
valores_r <- R(valores_x)
valores_l <- L(valores_x)

# Graph

plot(
  valores_x,
  valores_r,
  type = "l",
  col = "blue",
  lwd = 2,
  ylim = range(c(valores_c,valores_r)),
  xlab = "Quantidade",
  ylab = "Valor",
  main = "Custo, Receita e Lucro"
)

lines(valores_x,
      valores_c,
      col = "red",
      lwd = 2
      )
abline(v = Equilibrio$root,
       col = "green",
       lty = 2
       )