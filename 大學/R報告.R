#https://data.gov.tw/dataset/7441  (需解壓縮)
#https://data.gov.tw/dataset/103066 (109年)
#https://data.gov.tw/dataset/102764 (109年)

#前置作業
install.packages("magrittr")
install.packages("tidyr")
install.packages("sf")
library(ggplot2)
library(magrittr)
library(tidyr)
library(dplyr)
library(readxl)
library(sf)

#讀資料
setwd(dir="E:\\R")
getwd()
data1 <- read.csv(".\\109_165-9.csv")
data2 <- read.csv(".\\opendata109b080.csv")

#所得資料
所得資料<- data1 %>% select("鄉鎮市區","村里","中位數") %>%  
  mutate(市 = substr(鄉鎮市區, 1, 3),區 = substr(鄉鎮市區, 4, nchar(鄉鎮市區))) %>% 
  filter(!(村里%in% c("合計","其他"))) %>% group_by(市,區) %>% 
  summarise(各區平均所得中位數=mean(中位數))

#生育資料
生育資料 <- data2 %>%
  select("區域別","嬰兒出生數")%>%
  mutate(市 = substr(區域別, 1, 3),區 = substr(區域別, 4, nchar(區域別))) %>% 
  group_by(市,區) %>% summarise(各區生育數=sum(嬰兒出生數))

#合併
合併<-left_join(生育資料,所得資料,by=c("市","區"))
合併 <- 合併 %>%
  mutate(地區 = case_when(
    市 %in% c("臺北市", "新北市", "基隆市", "桃園市", "新竹市", "新竹縣", "宜蘭縣") ~ "北部",
    市 %in% c("臺中市", "彰化縣", "南投縣", "雲林縣","苗栗縣") ~ "中部",
    市 %in% c("臺南市", "高雄市", "屏東縣", "嘉義市", "嘉義縣") ~ "南部",
    市 %in% c("花蓮縣", "臺東縣") ~ "東部",
    市 %in% c("澎湖縣", "金門縣", "連江縣") ~ "離島",
    TRUE ~ "其他"
  ))
合併 <- 合併 %>%
  mutate(所得區間 = cut(各區平均所得中位數,
                    breaks = quantile(各區平均所得中位數, probs = seq(0, 1, by = 1/3)),
                    include.lowest = TRUE,
                    labels = c("低", "中", "高")))

#畫圖
#一起
ggplot(合併,aes(x = 各區平均所得中位數, y = 各區生育數)) +
  geom_point()+
  coord_cartesian(ylim = c(0, 2000))+
  geom_smooth(method = "lm", se = FALSE) 

#分地區
ggplot(合併)+
  geom_point(aes(x = 各區平均所得中位數, y = 各區生育數)) +
  coord_cartesian(ylim = c(0, 2000))+
  facet_wrap(. ~ 地區)

#各地區出生數
ggplot(合併, aes(x = 地區, y = 各區生育數)) +
  geom_bar(stat = "identity", position = "dodge") + 
  theme_minimal() +  
  labs(x = "地區", 
       y = "各區生育數") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

#分所得區間
ggplot(合併, aes(x = 地區, y = 各區生育數, fill = 所得區間)) +
  geom_bar(stat = "identity", position = "dodge") + 
  theme_minimal() +  
  labs(x = "地區", 
       y = "各區生育數") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

#台灣地圖
tw_map<-st_read(dsn=".\\鄉鎮市區界線(TWD97經緯度)1120928\\TOWN_MOI_1120825.shp")
合併_map<-left_join(合併,tw_map,by=c("區"="TOWNNAME","市"="COUNTYNAME"))

合併_map %>%
  ggplot()+
  geom_sf(aes(fill = 各區生育數,geometry=geometry,size=0.3)) +
  scale_fill_gradient(low = "white", high = "#006400",limit=c(0,2000),n=2000, na.value = "blue")+
  coord_sf(xlim = c(119, 123), ylim = c(21, 26))+
  theme_minimal()





