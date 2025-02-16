#for loop :一開始知道要執行幾次
for(i in 1:5){
  print(i)
}

x <- month.abb[1:5]
for(i in seq_along(x)){
  print(x[i])
}

for(i in 1:3){
  for(j in LETTERS[1:3]){
    print(c(i, j))
  }
}

for(i in 1:3){
  print(i)
  i <- i*10
  print(i)
}

for(i in 1:3){
  cat("outer before:", i, "\n")
  for(j in LETTERS[1:3]){
    cat("inner before:", c(i, j), "\n")
    i <- 1000
    j <- "XXX"
    cat("inner after:", c(i, j), "\n")
  }
  cat("outer after:", c(i, j), "\n")
}

xs <- c(1, 2, 3)
for (x in xs) {
  xs <- c(xs, x ** 2)
}
xs     # [1] 1 2 3 1 4 9

for(i in seq_along(ABC)){
  ABC[i] <- "XXX"
}
ABC
# [1] "XXX" "XXX" "XXX" ,都換成XXX

#quiz
f <- function(x){
  for(i in seq_along(x)){
    print(x[i])
  }
}
f(LETTERS[1:5])
f(vector())

#quiz
fruit <- c("apple", "banana", "strawberry")
fruit_length <- rep(NA, length(fruit))
for(i in seq_along(fruit)){
  fruit_length[i] <- nchar(fruit[i])
}
fruit_length <- nchar(fruit)

#break/next
for(i in 1:5){
  cat("before",i, "\n")
  if(i == 3){
    break                # exit at the 3rd iteration
  }
  cat("after",i, "\n")
}

for(i in 1:5){
  cat("before",i, "\n")
  if(i == 3){
    next                 # skip the 3rd iteration
  }
  cat("after",i, "\n")
}

#repeat:事前不知道會執行幾次
count <- 0
repeat{
  print(count)
  count <- count + 1
  if(count > 3) break
}

#while:事前不知道會執行幾次
count <- 0
while(count < 5){
  print(count)
  count <- count + 1
}

count <- 10
while(count < 5){
  print(count)
  count <- count + 1
}

#quiz
count <- 1
repeat{
  print(count)
  count <- count + 2
  if(count %% 2 == 0) break
}
while(count %% 2 != 0){
  print(count)
  count<-count+2
}

#quiz
set.seed(1)
x<-1:6
count<-0
number<-0
repeat{
  count<-count+1
  number<-sample(x,1)
  if(number == 6){
    print(count) 
    break}
}

while (number != 6) {
  count <- count + 1
  number <- sample(x, 1)
  if (number == 6) {
    print(count)
  }
}
