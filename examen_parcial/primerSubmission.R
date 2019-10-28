data <- read.csv('casas_entrena.csv')
data_p <- read.csv('casas_prueba.csv')

attach(data)
summary(data)
model <-lm( SalePrice ~ ., data = data)
sale_price_hat <- predict(model, newdata = data_p)
sub <- data.frame(data_p$id, sale_price_hat)
write.csv(sub, file = 'firstSub.csv', row.names = FALSE, quote = FALSE)
