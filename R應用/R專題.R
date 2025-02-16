library(magrittr)
library(dplyr)
library(tidyr)
library(writexl)

#處理所得資料，讓他變最大的(100~113)
new_years <- c(100, 111, 112, 113)
all <- unique(X101_110所得資料$縣市鄉鎮市區)
new_data <- expand.grid(年份 = new_years, 縣市鄉鎮市區 = all )
new_data$縣市 <- substr(new_data$縣市鄉鎮市區,1,3)
new_data$鄉鎮市區 <- gsub(" ", "", substr(new_data$縣市鄉鎮市區, 5, 8))
new_data$縣市鄉鎮市區<-NULL
new_data$"綜合所得總額（千元）"<-NA
new_data$"平均數（千元）"<-NA

X101_110所得資料$縣市鄉鎮市區 <- paste(X101_110所得資料$縣市, X101_110所得資料$鄉鎮市區)
X101_110所得資料$縣市鄉鎮市區<-NULL
X100_113所得資料 <- rbind(new_data, X101_110所得資料)

#開始合併
data出口所得<-left_join(X100_113所得資料,X100_113水果出口,by='年份')
data出口所得行情<-left_join(data出口所得,X105_113水果交易行情,by='年份')
data出口所得行情產量<-left_join(data出口所得行情,X106_111水果產量,by=c('年份',"縣市","鄉鎮市區"))
data出口所得行情產量農戶<-left_join(data出口所得行情產量,X109農戶資料,by=c("縣市","鄉鎮市區"))
data出口所得行情產量農戶眷村<-left_join(data出口所得行情產量農戶,是否有眷村,by=c("縣市","鄉鎮市區"))
data出口所得行情產量農戶眷村選舉<-left_join(data出口所得行情產量農戶眷村,X103_113選舉資料,by=c("年份","縣市","鄉鎮市區"))

#設年份Dummy
x<-c(100:113)
for (i in x) {
  new_var_name<- paste("year_", i, sep = "")
  data出口所得行情產量農戶眷村選舉[[new_var_name]] <- ifelse(data出口所得行情產量農戶眷村選舉$年份 == i, 1, 0)
}
data出口所得行情產量農戶眷村選舉[["年份"]]<-NULL

#匯出
write_xlsx(data出口所得行情產量農戶眷村選舉, "OK.xlsx")



