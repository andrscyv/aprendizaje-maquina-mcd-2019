# calculo de devianza para regresión logística
devianza_calc <- function(x, y){
  # devuelve la devianza no normalizada (no promedio)
  #x = matriz de datos de entradas (sin incluir columna de 1's)
  #y = respuesta (0 o 1)
  dev_fun <- function(beta){
    # beta: p+1 coeficientes
    x_beta <- as.matrix(cbind(1, x)) %*% beta
    -2 * mean(y * x_beta - log(1 + exp(x_beta)))
  }
  dev_fun
}

descenso_con_dev <- function(n, z_0, eta, h_deriv, calc_err){
  # iterar descenso en gradiente
  z <- matrix(0,n, length(z_0))
  dev<- matrix(0,n,length(z_0))
  z[1, ] <- z_0
  for(i in 1:(n-1)){
    z[i+1, ] <- z[i, ] - eta * h_deriv(z[i, ])
    dev[i+1,] <- z[i+1]
  }
  z
}