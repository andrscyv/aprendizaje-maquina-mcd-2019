library(dplyr)
library(tidyr)
data <- read.csv('casas_entrena.csv')
attach(data)
data_p <- read.csv('casas_prueba.csv')
data_m <- data

## Observaciones generales: 
## talves sea mejor modelar p(precio)/a(m^2) pues hay regresores 
##que tiene más sentido que afecten multiplicativamente al precio total
## como los categóricos

creaIndicadoras <- function( df, col ){
  categories <- unique(df[[col]])
  print('Creando indicadores para ' %+% col)
  for( i in 1:length(categories)){
    ##print(categories[i])
    name <- 'is' %+% as.character(categories[i]) %+% 'from' %+% as.character(col)
    df[[name]] <- ifelse(df[[col]] == categories[i],1,0)
  }
  df
}

error <- function( y_hat, y ){
  (mean((log(1 + y_hat) - log(1 + y))^2))^(1/2)
}

cv <- function( data, formula, k){
  data$batch <- rdunif(nrow(data),k)
}


## MS.SubClass es categórica aunque parece continua
data_m <- creaIndicadoras(data_m, 'MS.SubClass')

##Lot Frontage 
## Asumiremos que los NA's son por que no hay conexión directa con la calle y 
## pondremos 0
summary(Lot.Frontage)
data_m$Lot.Frontage <- replace_na(data_m$Lot.Frontage, 0)
summary(data_m$Lot.Frontage)


##Lot Area
summary(Lot.Area)

##
summary(data)
model <-lm( SalePrice ~ ., data = data)
sale_price_hat <- predict(model, newdata = data_p)
sub <- data.frame(data_p$id, sale_price_hat)
write.csv(sub, file = 'firstSub.csv', row.names = FALSE, quote = FALSE)
