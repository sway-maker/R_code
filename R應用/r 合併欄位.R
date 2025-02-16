library(magrittr)
library(dplyr)
library(tidyr)
library(writexl)

data1 <- data1 %>% 
  group_by(作物名稱,年份) %>%
  summarize(中價平均價格 = mean(`中價月中位數`),
            平均交易量 = mean(`月平均交易量`),
            產值= sum(output_value))

data1 <- data1 %>%
  pivot_wider(names_from = 作物名稱, 
              values_from = c(中價平均價格, 平均交易量, 產值))

data2[["收量(公噸)"]]<-NULL
data2[["每公頃收穫量(公斤)"]]<-NULL

data2 <- data2 %>%
  group_by(年份, 縣市, 鄉鎮市區, 作物名稱) %>%
  summarise(
    `收穫面積(公頃)` = sum(!!sym("收穫面積(公頃)")),
    `種植面積(公頃)` = sum(!!sym("種植面積(公頃)")),
    `收量(公斤)` = sum(!!sym("收量(公斤)")))

data2 <- pivot_wider(
  data = data2,
  names_from =作物名稱,
  values_from = c("收穫面積(公頃)", "種植面積(公頃)", "收量(公斤)")
)

data12<-left_join(data2,data1,by='年份')
write_xlsx(data2, "output.xlsx")






