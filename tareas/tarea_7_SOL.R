library(keras)
library(ggplot2)
library(tibble)

h <- function(x){
  exp(x)/(1 + exp(x))
}
x <- seq(-2,2,0.05)
p <- h(3 + x- 3 * x ^ 2 + 3 * cos(4 * x))
set.seed(280572)
sample_size <- 1500
x.2 <- runif(sample_size, -2, 2)
g.2 <- rbinom(sample_size, 1, h(3 + x.2 - 3 * x.2 ^ 2 + 3 * cos(4 * x.2)))
datos <- data.frame(x.2,g.2)
dat.p <- data.frame(x,p)
g <- qplot(x,p, geom='line', col='red')
g + geom_jitter(data = datos, aes(x=x.2,y=g.2), col ='black',
                position =position_jitter(height=0.05), alpha=0.4)

use_session_with_seed(1123)
set.seed(923)
ejemplo_mod <- keras_model_sequential()
ejemplo_mod %>% 
  layer_dense(units = 30, 
              activation = "sigmoid", kernel_regularizer = regularizer_l2(0.001)) %>% 
  #layer_dense(units = 4, 
 #             activation = "sigmoid", kernel_regularizer = regularizer_l2(0.0005)) %>% 
  layer_dense(units = 1, 
              activation = "sigmoid", kernel_regularizer = regularizer_l2(0.0005))

x_mat <- as.matrix(datos$x.2, ncol = 1)
y <- datos$g.2
# usamos devianza como medida de error y descenso en gradiente:
ejemplo_mod %>% 
  compile(loss = "binary_crossentropy",optimizer = optimizer_sgd(lr = 3))
# nota: esta learning rate (lr) es demasiado alta para problemas típicos
historia <- ejemplo_mod %>% 
fit(x_mat, y, batch_size = nrow(x_mat), epochs = 4000, verbose = 0)

p_3 <- predict(ejemplo_mod, as.matrix(x.2, ncol = 1))
dat_3 <- tibble(x = x.2, p_2 = p_3)
ggplot(dat_3, aes(x = x, y = p_2)) + geom_line()+
  geom_line(data = dat.p, aes(x = x, y = p), col='red') +ylim(c(0,1))+
  geom_point(data = datos, aes(x = x.2, y = g.2))

