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

y <- head(trainLabels, 1e3)
x <- head(trainData, 1e3)
mod <- multinom(y ~ x, MaxNWts = 7860)

pred <- predict(mod, newdata=testData)

 