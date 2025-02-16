#邏輯值
c(1,1) == 1 & c(1,0) == 1     #每一個值都需要確認&為"且"
c(1,1) == 0 | c(1,0) == 1     #每一個值都需要確認|為"或"
1 == 0 && 2 == 2              #一個是假值則結果為假值
1 == 1 || 3 == 0              #一個是真值即可

x <- NULL                                  #會一關一關跑
!is.null(x) && length(x) == 1 && x > 0     #guardian pattern
x <- 1:3
!is.null(x) && length(x) == 1 && x > 0
x <- 1
!is.null(x) && length(x) == 1 && x > 0

#if,else
x <- 1
if(x == 1){
  print("x = 1")
}
x <- 0                #不符合條件不會跑
if(x == 1){
  print("x = 1")
}
if(x == 1){
  1
} else if(x == 2){
  2
} else{
  "other"
}

#quiz
set.seed(123)
x <- sample(c(-2:2,NA),1)
x<-NA
if(is.na(x)){
  print("Missing Value")
}else if(x>0){
  x^2
}else if(x<0){
  x^3
}else {
  0
}

#switch
switch(                         #兩個等價
  expression,
  name1 = content1,
  name2 = content2,
  default_content
)
if(expression == "name1"){
  content1
} else if(expression == "name2"){
  content2
} else{
  default_content
}
x <- "a"                        #當有空白的，他會順延到下一個
switch(
  x,
  a = ,
  b = "case B",
  c = "case C",
  "otherwise"
)

#quiz
x <- rnorm(1000)
if(stats=="mean"){
  mean(x)
}else if(stats=="median"){
  median(x)
}else if(stats=="length"){
  length(x)
}else{
  print("not specified")
}

#ifelse,做向量化的判斷
x <- 1
ifelse(x %% 2 == 0, "even", "odd")
x <- 1:5
ifelse(x %% 2 == 0, "even", "odd")
ifelse(x %% 2 == 0, x, 10 * x)

ifelse("condition", "yes", "no")    #不會報錯誤,比較彈性
ifelse(logical(), "yes", "no")
ifelse(NA, "yes", "no")

#quiz
data[["Blond"]]<-ifelse(data$Hair=="Blond",1,0)






























