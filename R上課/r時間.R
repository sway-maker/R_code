#review quiz 1
x<-"Year"
y<- 2021
yr<-paste(x,y,sep="_")
nchar(yr)==9

#review quiz 2
x<-100
y<-as.logical(x)
x+y

#日期與時間
date <- as.Date("2024-02-27")
weekdays(date) #day of the week
months(date)   #month name
quarters(date) #quarter number

newyear <- strptime("01 01, 2024 00:00",
            format = "%m %d, %Y %H:%M")  #轉換
now <- as.POSIXlt(now)                   #抓系統時間
newyear - now                            #算時間差距(天)
difftime(newyear, now, units = "hours")  #算時間差(小時)

#quiz 4
A<-strptime("1947年2月28日",format="%Y年%m月%d日")
B<-strptime("28-02-1947",format="%d-%m-%Y")
C<-strptime("31.12.2023 23:59:59",format="%d.%m.%Y %H:%M:%S")

#lubridate(比較好用)
now<-now()
now("Asia/Tokyo")
today<-today()

today + 1:2 * months(1)#從今日依序加一個月、兩個月，month(1)為間隔
today + months(1:2)    
round_date(today, "month")  #取四捨五入到月初(往上)
floor_date(today, "month")  #取四捨五入到月初(往下)
ceiling_date(today, "month")#無條件進位到下個月初

month_end <- as.Date("2024-1-31")
month_end + months(1)     #會有問題
month_end %m+% months(1)  #%m+%自動調整月底

ymd("1947.02.28")     #儲存資料
ymd("1947年2月28日")
parse_date_time("apr 11th 2018 at 7pm", orders = "mdyIp") #叫出資料

#quiz 5
mdy("Feb 29th, 2024")
dmy("29-02-2024")
dmy_hms("31.12.2023 23:59:59")
interval(today(), ymd("2024/04/03")) %/% weeks(1)
difftime(ymd("2024/04/03"),today(),units = "week")

#Exercise
library(lubridate)
parsed_date <- parse_date_time2("02/28/47", orders = "mdy", cutoff_2000 = 0)

date_str <- "民國36年2月28日"
republic_year <- as.numeric(sub(".*民國(\\d+)年.*", "\\1", date_str))
gregorian_year <- republic_year + 1911
new_date_str <- sub("民國\\d+年", paste(gregorian_year, "年", sep = ""), date_str)
date_object <- as.Date(new_date_str, format = "%Y年%m月%d日")
print(date_object)









