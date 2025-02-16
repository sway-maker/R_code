#建立矩陣
m <- matrix(11:20, nrow = 2, ncol = 5)
rownames(m) <- c("X", "Y")
colnames(m) <- letters[1:5]

#結合
x <- 1:3
y <- 4:6
cbind(x,y)
rbind(x,y)

#擷取
m[1,2]        #取第一列第二行
m[,2:3]       #取第i列第二、三欄
m[2,]         #取第二列第i行

#quiz
a <- 1:5
b <- c('1', '2', '3', '4', '5')
cbind(a,b)

x <- 1:5
y <- 1:4
z <- 1:3
rbind(x,y,z)

x <- matrix(1:20, nrow = 5, ncol = 4)
x[-1]
x[-1, ]
x[ ,-1]
x[-1, -1]
x[c(-1,-3),]

x<-matrix(1:12,ncol=3,byrow = TRUE)
x[2,3]
x[,1]
x[3,]

#linear algebra
A <- matrix(4:1, nrow = 2, ncol = 2)
B <- matrix(seq(from = 100, to = 400, by = 100),
             nrow = 2, ncol = 2)
t(A)      #轉置
diag(A)   #diagonal matrix
solve(A)  #反矩陣
A * B     #同位置相乘
A %*% B   #內積
rowMeans(A)
rowSums(A)

#quiz
x <- matrix(1:12, nrow = 4, ncol = 3, byrow = TRUE)
x + c(10,20,30)

x<-matrix(1:12,ncol=3,byrow = TRUE)
rowMeans(x)
colMeans(x)
x[x%%2==0]

#exercise
set.seed(1)
N <- 100000
pop_mean <- 13
reps <- 500
eps <- 0.1
sample_size <- c(10, 30, 1000)
calculate_statistics <- function(sample_size) {
  sample_means <- replicate(reps, {
    population <- runif(N, min = 10, max = 16)
    mean(sample(population, size = sample_size))
  })
  prob_val <- mean(abs(sample_means - pop_mean) <= eps)
  c(mean(sample_means), var(sample_means), prob_val)
}
result <- t(sapply(sample_size, calculate_statistics))
colnames(result) <- c("mean", "var", "prob")







