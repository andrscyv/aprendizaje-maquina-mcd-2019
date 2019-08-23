library(tidyverse)
simula_muestra <- function(f, x) {
  # devuelve datos simulados 
  error <- rnorm(length(x), 0, 500)
  y <- f(x) + error
  datos <- tibble(x = x, y = y)
  datos
}

ajusta_modelos <- function(datos_entrena){
  # la salida es una lista con los modelos ajustados
  # opcionalmente, puedes cambiar el suavizamiento 
  mod_rojo <- loess(y ~ x, data = datos_entrena, span=0.3)
  mod_gris <- loess(y ~ x, data = datos_entrena, span=1)
  mod_recta <- lm(y ~ x, data = datos_entrena)
  df_mods <- tibble(nombre = c('recta', 'rojo', 'gris'))
  df_mods$modelo <- list(mod_recta, mod_rojo, mod_gris)
  df_mods
}


error_f <- function(df){
  function(mod){
    preds <- predict(mod, newdata = df)
    round(sqrt(mean((preds - df$y) ^ 2)))
  }
}

calcula_error <- function(df_modelos, datos){
  error <- error_f(datos)
  df_modelos <- df_modelos %>% 
    mutate(error_prueba = map_dbl(modelo, error))
  df_modelos
}

f <- function(x){
  ifelse(x < 10, 1000*sqrt(x), 1000*sqrt(10))
}


x_0 <- sample(0:13, 500, replace = T)
datos_prueba <- simula_muestra(f, x_0)
# usamos x fija para entrenamiento (puedes simular también)
x <- c(1,7,10,0,0,5,9,13,2,4,17,18,1,2)
for (i in 1:40) {
  datos_entrena <- simula_muestra(f, x)
  modelos <- ajusta_modelos(datos_entrena)
  error_entrena <- error_f(datos_entrena)
  error_prueba <- error_f(datos_prueba)
  errores = modelos %>% 
    mutate(error_ent = map_dbl(modelo, error_entrena),
           error_pr = map_dbl(modelo, error_prueba)) 
  if( i ==1 ){
    erroresAcum = errores
  }else{
    erroresAcum = rbind(erroresAcum, errores)
  }
  
}

#print(erroresAcum)
boxplot(error_ent ~ nombre, data = erroresAcum, xlab = "Método", ylab = "Error", main="Errores de entrenamiento")
boxplot(error_pr ~ nombre, data = erroresAcum, xlab = "Método", ylab = "Error", main="Errores de prueba")