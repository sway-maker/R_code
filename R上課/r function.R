#function
args(paste)                            #args(function)可以看函式內容
stats <- function(x, type, ...) {      #加入...允許可以加入其他參數
  switch(type,
         mean = mean(x, ...),
         median = median(x, ...),
         max = max(x, ...),
         "default")
}
x <- rnorm(1000)
x[sample(1:1000, size = 10)] <- NA
stats(x, "mean")
stats(x, "mean", na.rm = TRUE)         #移除掉NA值之後可以計算
sum(1, 2, 3, na.omit = TRUE)           #若加入不認得的參數，則會認為是他取了名字

f <- function(){
  return("Hello world!")
}
f         #只是叫出函式
f()       #執行函式
f <- function(){                       #return後的東西不會跑
  print("code before return")
  return("Hello world!")
  print("code after return")
}

#有兩層函式
f <- function(k){      
  function(x, y = k){
    paste(x , y)
  }
}
f(k = "outer")(x = "inner")   #需用兩層才可使用函式
f(k = "outer")(x = "innerX", y = "innerY")  #會覆蓋掉原本的值

power <- function(p) {
  function(a, b = p) {
    a^b
  }
}
power(2)(3)       # [1] 9
power(2)(3,4)     # [1] 81,(4會覆蓋2)

x <- 1:5 *2
ecdf(x)           #empirical cdf
ecdf(x)(2)        #2的cdf為何

#quiz
f <- function(x, y) {
  x + y
  x - y
  return(x * y)
  return(x / y)
}
f(3, 4)

f <- function(...){
  sum(...)
}
f(1,2,3,4,5)
f(1,2,3,4,5,NA)
f(1,2,3,4,5,NA, na.rm = TRUE)

#infix
#`% %` <- function(a, b) paste(a, b)
#`%/\\%` <- function(a, b) paste(a, b)
#`%-%` <- function(a, b) paste0("(", a, " %-% ", b, ")")
"a" %-% "b" %-% "c"
# [1] "((a %-% b) %-% c)"

#%>% pipe operator，可視為一種產線，適合非傘狀的作業(每次結果都一個)
iris %>%
  subset(Sepal.Length > 5) %>%    #eg1
  summary()
pi %>% round(digits = 6)          #eg2
1:5 %>% paste(letters[.])         #eg3 [1] "1 a" "2 b" "3 c" "4 d" "5 e"
1:5 %>% {paste(letters[.])}       #eg4 [1] "a" "b" "c" "d" "e"

#quiz
x <- 1:10
x %>%
  mean %>%
  `-`(x, .) %>%
  `/`(., sd(x))
(x-mean(x))/sd(x)

#replacement
`f<-` <- function(x, value) {
  x <- value
  x
}
x <- 1
f(x) <- 100
x   #100

`f<-` <- function(x, arg, value) {
  x[arg] <- value
  x
}
x <- 1:10
f(x, 2) <- 100
x    #把第二個換成100

df <- data.frame(1:3,
                 month.abb[1:3],
                 c(TRUE, FALSE, FALSE))
names(df) <- c("x", "y", "z")
df <- `names<-`(df, c("A", "B", "C"))  #把名稱換成A,B,C
names(df)[3] <- "NEW_C"                #第三個換成NEW_C
df <- "names<-"(df, "[<-"(names(df), 2, "NEW_B"))  #第二個換成NEW_B

#改寫
x <- 1:10
x[1]
`[`(x, 1)                                 #跟上面一樣
if(x == 1) x * 100
`if`(x == 1, x * 100)                     #跟上面一樣
if(x == 1) x * 100 else x + 5
`if`(x == 1, x * 100, x + 5)
`if`(`==`(x, 1), `*`(x, 100), `+`(x, 5))  #這三個一樣

#Environments  #is()回傳local environment variable
var1 <- 1
var2 <- 2
f <- function() {
  var1 <- var1 * 100
  var2 <<- var2 * 100
  print(ls())
  cat(var1, var2)
}
f()

c("var1", "var2") %in% ls()
cat(var1, var2)








