setwd(Sys.getenv('$PROJECT_HOME'))
library(nnet)

if (!file.exists('./MNIST_data/train.RData')){
	library(darch)
	readMNIST(folder='./MNIST_data/')
}
load('./MNIST_data/train.RData')

# Visualise the first digit - flipping the upside-down image
image(matrix(trainData[1,], nrow=28, ncol=28)[,28:1])
# Read the true value
which(as.logical(trainLabels[1,]))-1


mod <- multinom(trainLabels ~ trainData)
 