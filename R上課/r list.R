#list
list[component]    #returns a sub-list
list[[component]]  #returns an element(可以用裡面的值)
list$component     #returns an element
x <- list(first = c("a", "b"),
          second = 1:5,
          third = c(TRUE, FALSE, TRUE))  #建立list 
x[2]
x[c(1:2)]
x[[1]][2]    #抓出第一個向量中的第二個component
x[[c(1,2)]]  #抓出第一個向量中的第二個東西
str(x[2])    #判斷結構

#quiz
x <- list(
  A = 10:1,
  B = list(
    B1 = c("x","y","z"),
    B2 = 100
  )
)
x["A"][2]
x[["A"]][2]
x$A[2]
x[["B"]][2]
x[["B"]][[2]]
x[["B"]]$B1[3]

x <- list(1:10, list(c(TRUE, FALSE), 3:5), "R is cool")
x[[2]][[1]][[2]]
y <- list(name = "my_function", results = 101)
y[[1]][1]

result <- strsplit("A B C D E", split = " ")
result[[1]][[1]]

#Modification
x <- list(first = c("a", "b"),
          second = 1:5,
          third = c(TRUE, FALSE, TRUE))
x[[1]] <- c(x[[1]], "c", "d")             #第一個向量加入c d
x[["second"]] <- x[["second"]] + 1000     #第二個向量各加1000
x$third <- as.numeric(x$third)            #轉換第三個向量成數值

x$fourth <- "NEW_4"
x$fifth <- c("NEW_5a","NEW_5b")
x[[6]] <- "NEW_6"
x[[7]] <- c("NEW_7a","NEW_7b")            #加入新的值與向量，*需要打開包裹才能加入，若只開一層則只能加入一個元素
x$fourth <- NULL                          #刪除一個向量
names(x) <- c("FIRST", "SECOND","THIRD")  #幫每個內容新增名字
unlist(x)                                 #將整個list拆成一個向量，且元素皆為文字

#Combination
element1 <- 5:1
element2 <- LETTERS[1:6]
y <- list(element1, element2) #結合且結構上為相同維度
z1 <- c(x, y)                 #結合但x與y為z1的下一層

#quiz
a <- c(1, 2, 3)
b <- c("A", "B", "C")
x <- list(a, b)
x[[2]][1]<-"K"
x[[1]]<-x[[1]]*100
c = c(TRUE, FALSE)
x[[3]]<-c(TRUE, FALSE)
x[[2]]<-NULL

a <- list(x = 1, y = c(2,3), z = list(4,5,6))
unlist(a)
sum(unlist(a))

#quiz
data(mtcars)
model <- lm(mpg ~ wt, data = mtcars)
result <- summary(model)
result[["coefficients"]][2]
result[["coefficients"]][8]<0.05

#exercise 
library(tm)
data(crude)
library(lubridate)
earliest_time <- Sys.time() 
latest_time <- as.POSIXlt("1970-01-01") 
for (i in 1:length(crude$content)) {
  timestamp <- crude$content[[i]]$meta$datetimestamp
  if (timestamp < earliest_time) {
    earliest_time <- timestamp
  }
  if (timestamp > latest_time) {
    latest_time <- timestamp
  }
}
timespan <- c(earliest_time, latest_time)


