library(nnet)

if (!file.exists('./MNIST_data/train.RData')){
	library(darch)
	readMNIST(folder='./MNIST_data/')
}
load('./MNIST_data/train.RData')
load('./MNIST_data/test.RData')

# Visualise the first digit - flipping the upside-down image
image(matrix(trainData[1,], nrow=28, ncol=28)[,28:1])
# Read the true value
which(as.logical(trainLabels[1,]))-1


prepare_data <- function(tLabels, tData){
	y <- apply(tLabels, 1, function(r) which(as.logical(r)) - 1)
	y <- factor(y, labels=0:9)
	x <- data.frame(tData)
	dat <- cbind(y, x)
	return(dat)
}



all <- prepare_data(
	rbind(trainLabels, testLabels),
	rbind(trainData, testData)
	)

train <- head(all, 55000)
test <- head(tail(all, -15000), 10000)

mod <- multinom(y ~ ., data=head(train, 1e3), MaxNWts = 7860)
pred <- predict(mod, newdata=test)
mean(pred==test$y)
