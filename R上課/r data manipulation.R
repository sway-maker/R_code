#eg
library(magrittr)
library(tidyverse)
df_x <- data.frame(row_n = 1:5,
                   var1 = c("A","A","B","C","C"),
                   var2 = c(1, 2, 10, 5, 5),
                   var3 = letters[1:5],
                   var4 = c(T, F, NA, NA, T))

df_y <- data.frame(var2 = 1:5,
                   var3y = c("a","b","d","f","g"),
                   var5y = tail(LETTERS, n = 5))

#select(),選取資料,可以用欄位名稱選取
df_x %>% select(var1, var2) %>% head(3)
df_x %>% select(1, 2) %>% head(3)
df_x %>% select(-var1, -var2) %>% head(3)
df_x %>% select(-1, -2) %>% head(3)
df_x %>% select(var1:var3) %>% head(3)

df_x %>% select(starts_with("var")) %>% head(3)    #用start_with 挑出開頭為var的欄位
df_x %>% select(ends_with("2")) %>% head(3)        #用ends_with 挑出結尾為2的欄位
df_x %>% select(contains("var")) %>% head(3)       #用contains 挑出含有var的欄位
df_x %>% select(contains("var") & ends_with("2")) %>% head(3)   #延伸

df_x %>% select(where(is.character)) %>% head(3)   #挑出是文字的欄位
df_x %>% select(where(is.numeric)) %>% head(3)     #挑出是數字的欄位
df_x %>% select(where(function(x) is.numeric(x))) %>% head(3)   #若有其他function可以放進去
df_x %>% select(where(\(x) is.numeric(x))) %>% head(3)          #\(x)替代function(x)

#quiz
df <- data.frame(var_1 = 10:15,
                 var_2 = 20:25,
                 var_3 = 30:35,
                 var_4 = 40:45,
                 var_5 = 50:55)
df %>% select(num_range("var_",c(1,2,5)))
df %>% select(where(~mean(.)<25))

#pull(),將所要的東西單純拉出來
df_x %>% select(var1) %>% pull()        #不會是dataframe,會是charactor
df_x %>% select(var1)                   #會是dataframe

#filter(),挑選出特定值的資料
df_x %>% filter(var1 == "A")            #挑選出var1欄位有A的資料
df_x %>% filter(var1 %in% c("A","B"))   #挑選出有A、B的
df_x %>% filter(var1 == "A", var2 == 1) #有兩個條件的(也可以用&、|...)

#slice(),如果知道要選取的欄位位置
df_x %>% slice(1:3)        #挑選1~3筆資料
df_x %>% slice(-c(1,3))    #不要第1,3筆資料

#distinct(),得知該欄位裡面有什麼值
df_x %>% distinct(var1)

#mutate(),用來修改資料
df_x %>% mutate(new_var = var2*var4,
                new_var2 = new_var*2) %>% head(3)   #建立新變數
df_x %>% names        #看有多少變數,要注意若沒有覆蓋原本資料,則不會出現在變數中\

#%<>%,做的事情會直接覆蓋原資料
df_x %<>% mutate(new_var = var2*var4)

#建立新的欄位，其欄位值可以依據其他欄位的值設為條件,若有沒對應到的條件則為NA,但用TRUE可以直接把他們設一個值
df_x %>% mutate(new_var = case_when(
var3 == "a" ~ "type a",
var3 == "b" ~ "type b",
var3 == "c" ~ "type c",
TRUE ~ "other"   #TRUE要放最後,順序會影響
))

df_x %>% mutate(new_var = na_if(var1, "A"))
df_x %>% mutate(new_var = coalesce(var4, FALSE))

#across(),一次轉換多個欄位
df_x %>% mutate(across(c(var1, var3), lag))        #一次把兩個欄位轉換，並差一期
df_x %>% mutate(across(c(var1, var3), lag,
                       .names = "{.col}_L1"))      #建立新欄位儲存轉換的值
df_x %>% mutate(across(where(is.character), lag,
                       .names = "{.col}_L1"))      #跟前面的函式結合
df_x %>% mutate(across(where(is.character),
                       list(L1 = lag,
                            F1 = lead),
                       .names = "{.fn}.{.col}"))   #一次有多個條件

#rename(),改欄位名稱
df_x %>% rename(VAR1 = var1, VAR2 = var2) %>% head(3)  
df_x %>% rename_with(toupper) %>% head(3)

#summarize(),對資料做總結
df_x %>% summarise(n_rows = n(),
                   n_distinct_rows = n_distinct(var1),
                   n_NA = sum(is.na(var4)),
                   first_value = first(var1),
                   max_number = max(var2)
)

#group()
df_x %>% group_by(var1)
df_x %>% group_by(var1) %>% ungroup()
df_x %>% group_by(var1) %>%
  summarise(
    n_rows = n(),
    n_distinct_rows = n_distinct(var1),
    n_NA = sum(is.na(var4)),
    first_value = first(var1),
    max_number = max(var2)
  )

#rowwise() ,一個一個row判斷
df_x %>%
  rowwise() %>%
  mutate(new_var = min(var2, var4))
df_x %>%
  mutate(new_var = pmin(var2, var4))   #兩者等價，pmin更簡單

#arrange()排序
df_x %>% arrange(var2)

#join functions
##left_join(),right_join(),兩者類似，差別只是順序不一樣
df_x %>% left_join(df_y, by = "var2")
df_x %>% left_join(df_y, by = c("var3" = "var3y"))          #以var3=var3y為主
df_x %>% left_join(df_y, by = c("var3" = "var3y", "var2"))  #一次對兩個

#data format:wide
df_wide1 <- data.frame(id = 1:3,
                        num_2020 = c(101, 102, 103),
                        num_2021 = c(201, 202, 203),
                        num_2022 = c(301, 302, 303))
df_long1 <- data.frame(
  id = rep(1:3, each = 3),
  year = rep(2020:2022, times = 3),
  num = 100*rep(c(1,2,3), times = 3) + rep(1:3, each = 3)
)
#上面兩者一樣，但表示方式不同

#tidyr,pivot_longer()、pivot_wider()
library(tidyr)
##pivot_longer()
df_wide1 %>% pivot_longer(
  cols = starts_with("num"),
  names_to = "year",
  names_prefix = "num_",  #names_prefix可以刪掉前贅詞
  values_to = "num"       #names_sep可以切成兩段
)
df_wide2 %>% pivot_longer(cols = -id,
                          names_to = c(".value", "year"),
                          names_sep = "_")     #一次轉換多個

##pivot_wider()
df_long1 %>% pivot_wider(names_from = "year",
                         values_from = "num",
                         names_prefix = "num_")


















