library(magrittr)
library(dplyr)
library(tidyr)
library(writexl)

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




