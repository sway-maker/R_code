#path
setwd(dir = "C:\\Users\\USER\\Desktop")
getwd()                        #得知目前所在資料夾
setwd(dir = "..\\")            #可以回到上一層,也可以一次上兩層(..\\..\\)
setwd(dir = ".")               #"."可以代替目前所在資料夾(相對路徑)
#session -> set working directory

#
list.files()[1:3]                 #抓出該位置有的資料,可以方便讀資料
list.dirs()[1:3]                  #可以看還有哪些資料夾
file_name <- "是否有眷村.xlsx"
file_name %in% list.files()       #確認該位置是否有某資料
file.path(getwd(), file_name)     #把目前位置與檔案名稱連結
file.exists(file_name)            #檢查檔案是否存在
dir.exists(file_name)             #確認資料夾是否存在
library(tools)
file_ext(file_name)               #檢查檔案格式

#quiz
relative_path<-setwd(dir = ".\\data\\final\\df.xlsx")
relative_path<-setwd(dir ="..\\data\\final\\df.xlsx")
length(list.files(path="."))
if (file.exists(path=".")==T){
  length(list.files(path="."))
}

#Reading
read.csv()
read_csv()         #readr package
read_excel()       #readxl package
read.xlsx2()       #xlsx package

#csv檔
file_name <- "data.csv"
df <- read.csv(file = file_name)
df <- data.table::fread(file = file_name)  #::可以直接用函式，不用library(若只用到一次)
df <- readr::read_csv(file = file_name)

#excel檔
file_name <- "data.xlsx"
library(readxl)
excel_sheets(file_name)
df <- read_excel(file_name, sheet='sheet1')

#讀/輸出文件
readRDS("file_name.rds")
saveRDS(object_name, file = "file_name.rds")











