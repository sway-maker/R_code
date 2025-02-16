#基本
c(1,2,3,4)                      #普通用法
seq(from = 1, to = 4, by = 0.5) #連續數，間格為0.5
rep(2, times = 4)               #重複四次
rep(c("A","B"), times = c(5,2)) #分別重複n次

#quiz 
seq(from=0,to=1998,by=2)
rep("NUK",times=1000)
c(1.7, "a")
c(TRUE, 2)
c("a", TRUE)
x <- c('blue', 10, 'green', 20)
is.character(x)

#Vectors,access
x <- c("A","B","C","D") #編號是從1開始
x[1]       #取第一個
x[-1]      #不要第一個
x[c(1,2)]  #取1,2個
x[-c(1,3)] #不要1,3個

#統計
z <- c(1.2, 3.4, 5.6)
summary(z)
z > 5        #分別判斷是否大於5
which(z > 5) # which indices are TRUE?
sum(z > 5)   # count the number of TRUE indices
any(z > 5)   # if there is any TRUE index?
all(z > 5)   # if all indices are TRUE?

#Vectors,recycling
c(100,200) + 1:6 #短的一直重複，長的正常
paste(c("X","Y"), 1:10, sep="")
paste("X","Y", 1:10, sep="")

#quiz
x <- 1:4
y <- c(2,2,2,2)
z <- c(1.2, 3.4, 5.6)
x-y
x/y
z[-1]
z[c(-2,-3)]
z[-c(2,3)]
which(z > 2 & z < 4)
z[z > 2 & z < 4]
sum(z > 2 | z < 4)
sum(z[z > 2 | z < 4])

x <- 10:50
x[12]
x[9:24]
x[c(-2,-8)]

1:5 * 2
1:5 + 1
1:5 + 1:2

paste("round.",1:100,sep="")

#Vectors,modify
x <- c(1, -2, 3, NA, -5)
is.na(x)
which(is.na(x))   #NA的位置
x[is.na(x)]       #符合的數字
x[is.na(x)] <- 0  #將其修改為0

x[6] <- 600       #加入第六個位置
length(x) <- 10   #把長度加到10
length(x) <- 3    #把長度減到3

#quiz
x <- c(34, 56, 55, 87, NA, 4, 77, NA, 21, NA, 39)
sum(is.na(x))            #找出NA個數
x[is.na(x)] <- 9999      #將其替換成9999

#%in% Operator比較兩向量
x <- c("A","B","C","D","E")
y <- c("A","1", "B", "2","C", "3")
x %in% y              #判斷x內的哪幾個有在y裡
sum(x %in% y)         #判斷x有幾個在y內
which(x %in% y)       #x內的哪個位置的值在y內有
which(! x %in% y)
x[which(x %in% y)]    #叫出該位置的值
x[which(! x %in% y)]
x[x %in% y]           #叫出該位置的值
x[! x %in% y]

#sort()排順序
#order()排位置
#rank()每個數字的排名(不會改順序)

#random sampling 
set.seed(123) 
sample(x = c(0,1), size = 10, replace = TRUE)         #定義一組樣本
mean(sample(x = c(0,1), size = 1000, replace = TRUE)) #算平均
mean(sample(x = c(0,1), size = 1000, replace = TRUE,
            prob = c(0.2,0.8)))
rnorm(n = 5, mean = 0, sd = 1)                        #定義一個常態分配
mean(rnorm(n = 1000, mean = 0, sd = 1))               #算平均

#quiz
set.seed(123) 
x<-sample(letters,size=5,replace=FALSE)
max(x)
sort(x)
y<-letters[1:10]
x %in% y
sum(x %in% y)

#exercise 1 
seq(0, 99.9, by = 0.1)
sequence <- rep(seq(0, 0.9, by = 0.1), times = 1000)
rep(rep(1:3, each = 4), length.out = 1000)
sequence <- unlist(sapply(1:250, function(x) rep(x, x)))
sequence <- sequence[1:1000] 

#exercise 2
X <- letters
even_elements <- X[c(FALSE, TRUE)]
years <- paste("year_", seq(1960, 2020, by = 2), sep = "")

#exercise 3
data <- USAccDeaths

mean_value <- mean(data)
sd_value <- sd(data)

outliers <- data > mean_value + 2 * sd_value | data < mean_value - 2 * sd_value
num_outliers <- sum(outliers)

outlier_indices <- which(outliers)

data[outliers] <- NA

num_NAs <- sum(is.na(data))

mean_new <- mean(data, na.rm = TRUE)
sd_new <- sd(data, na.rm = TRUE)

print("Original Mean and Standard Deviation:")
print(mean_value)
print(sd_value)

print("Number of Outliers:")
print(num_outliers)

print("Indices of Outliers:")
print(outlier_indices)

print("Number of NAs:")
print(num_NAs)

print("New Mean and Standard Deviation:")
print(mean_new)
print(sd_new)

#exercise 4
set.seed(123)
x <- rnorm(100)
x <- sort(x, decreasing = TRUE)
x[sample(length(x), 0.1 * length(x))] <- NA
x[is.na(x)] <- mean(x, na.rm = TRUE)
mean(x[x > 0])

#factor
x <- factor(c("yes", "yes", "no", "yes", "no"))
levels(x)          #確認層級
table(x)           #各factor有幾個
unclass(x)         
x <- factor(c("yes","yes","no","yes","no"),  #更改名稱yes-Y,no-N
            levels = c("yes", "no"),
            labels = c("Y","N"))
levels(x) <- c(levels(x), "NEW1")            #加入新的層級
x <- droplevels(x)                           #刪掉沒用的層級

#quiz
z <- factor(c("A", "C", "A", "B", "C"))
levels(z)[1] <-"X"
levels(z) <- c(levels(z), "D")










