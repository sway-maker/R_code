class()      #判別資料型態
is.numeric() #判定是否為數字
is.double()  #判定是否為小數
is.integer() #判定是否為整數
!is.na(123)  #加入!變為否定
?'"'

class("\U2764")                   #unicode
paste("\U2764","\U2764",sep="/")  #組合,sep為中間插入的東西
nchar("\U2764")                   #數有多少character(空白鍵也算)
length()                          #計算有幾個東西(字串)

print()  #R預設的,只會單純印出來,且只接受第一個字元,保留原本型態
cat()    #印出來的東西不會有引號,且支援特殊字元,結果不會儲存
paste()  #結合字串,且為向量化的操作,eg:line 21,變為字串

x <- 1:3      #let x=1~3
y <- 11:13    #let y=11~13
print(x)
cat(x,y)
paste(x,y)

#zuvio test
paste("\U0001F44D")
paste("\U0001F340")
paste("\U0001F44D","\U0001F340",sep="")
good_luck<-paste("\U0001F44D","\U0001F340",sep="")
nchar(good_luck)==2

#exercise 1
text <- "\"There is one rule for the industrialist and that is: make the best quality goods possible at the lowest cost possible, paying the highest wages possible.\"
Henry Ford"
cat(text)
nchar(text)

as.numeric()   #轉換為數字
as.character() #轉換為文字

#zuvio test
x <- TRUE
y <- as.numeric(x)
x+y
x <- x + 10
x+y



