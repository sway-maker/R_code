#建立dataframe
x <- data.frame(a = 1:3, b = month.abb[1:3])
data.frame(a = 1:10, b =1:2)
names(x) <- c("varA","varB")      #加入colume name
row.names(x) <- c("X","Y","Z")    #加入row name

#Access
dataframe["variable"]       #打開第一層
dataframe[["variable"]]     #打開第二層(可以應用內容)
x <- list(a = 1:3, b = c(3.14, 2.81), c = "test")
x[c(1, 3)]
x[[c(1, 3)]]                #取第一個向量的第三個元素

#quiz
data.frame(a = 1:10, b = 1:3)

x <- data.frame(a = 3:1,
                b = month.abb[1:3],
                c = c(TRUE, FALSE, FALSE)
)
row.names(x) <- c("P","Q","R")
x[-1,]
x[,-1]
x[,-c(1, 3)]
x[-c(1, 3)]
x[[-c(1, 3)]]

x <- data.frame(a = 3:1,
                b = month.abb[1:3],
                c = c(TRUE, FALSE, FALSE)
)
row.names(x) <- c("P","Q","R")
x[1,]
x[1:2,]
x[,c("a","c")]
x[1:2,"b"]

#Subsetting
x <- data.frame(a = 3:1,
                b = month.abb[1:3],
                c = c(TRUE, FALSE, FALSE))
row.names(x) <- c("P","Q","R")

x$a > 1
x[x$a > 1,]
x[x$a > 1,]$a    #與x[x$a > 1,"a"]一致

subset(x, a > 1)                                    #保留矩陣
subset(x, subset = a > 1, select = a)               #只要a col.
subset(x, subset = a > 1, select = a, drop = TRUE)  #as vector

#quiz
x <- data.frame(a = 3:1,
                b = month.abb[1:3],
                c = c(TRUE, FALSE, FALSE)
)
subset(x, subset = a > 1, select = -a)
subset(x, subset = a > 1, select = c(b, c))

data <- as.data.frame(HairEyeColor)
sum(subset(data,Eye=="Green")$Freq)
sum(subset(data,Eye=="Green"&Hair=="Blond")$Freq)

#Modification
x <- data.frame(a = 3:1,
                b = month.abb[1:3],
                c = c(TRUE, FALSE, FALSE))
row.names(x) <- c("P","Q","R")

x$new1 <- 11:13           #加入colume
x[["new2"]] <- 21:23
x["new3"] <- 31:33
x[,"new4"] <- 41:43
x[[10]] <- 101:103
x[11] <- 111:113
x[,12] <- 121:123

x$new2 <- 1               #修改內容,若填入NULL則會刪掉該內容
x[["new2"]] <- 2
x["new3"] <- 3
x[,"new4"] <- 4
x[[10]] <- 10
x[11] <- 11
x[,12] <- 12

x[c(8,9)] <- 100          #填入內容
x[c(8,9)] <- 1:6          #由上而下，左而右填入內容

x[nrow(x)+1,] <- 100      #加入row,須注意長度需一致
x[6:7,] <- 1:6
x[c("row8","row9"),] <- 200
x[c("row10","row11"),] <- 1:2

#Combining
a <- data.frame(v1=1:3, v2=LETTERS[1:3],
                v3 = month.abb[1:3])
b <- data.frame(var1=4:6, var2=LETTERS[4:6])

m <- cbind(a, b)     #colume合併
m <- rbind(a, b)     #row合併

x[order(x$a), ]      #針對a的大小做排序
levels(data$Hair)
reorder(data$Hair, data$Freq, FUN = sum)       #按照髮色排序

#cut
data$freq_level <- cut(data$Freq, breaks = 3)  #將資料分為三類
levels(data$freq_level)
levels(data$freq_level) <- c("low", "medium", "high")
table(data$freq_level)                         #計算每個組別的次數

#quiz
set.seed(123)
x <- data.frame(a = rnorm(1200),
                b = month.abb,
                c = c(TRUE, FALSE))

mean(subset(x,c==TRUE)$a)
x[x$a>0,]$c<-FALSE
length(subset(x,b=="Jan")$b)
sum(x$b[sample(nrow(x),round(0.1*nrow(x)))]=="Jan")

data$blond <- 0
data$blond[data$Hair == "Blond"] <- 1
data[["Freq"]]<-NULL

#exercise 1
set.seed(1)
N <- 100000
a <- 10
b <- 16
population <- runif(N, min = a, max = b)

sample_size <- 100              # 取得一個樣本
sample <- sample(population, size = sample_size)

sample_mean <- mean(sample)     # 計算樣本平均值和標準差
sample_sd <- sd(sample)

alpha <- 0.05                   # 計算 95% 信心區間
z_value <- qnorm(1 - alpha/2)
margin_of_error <- z_value * (sample_sd / sqrt(sample_size))
confidence_interval <- c(sample_mean - margin_of_error, sample_mean + margin_of_error)

population_mean <- mean(population)                   # 檢查母體平均值是否在信心區間內
if (population_mean >= confidence_interval[1] && population_mean <= confidence_interval[2]) {
  print("母體平均值在 95% 信心區間內。")
} else {
  print("母體平均值不在 95% 信心區間內。")
}

print(paste("95% 信心區間:", confidence_interval))    # 輸出信心區間

#exercise 2
library(survival)
model <- clogit(case ~ spontaneous+induced+strata(stratum),
                data = infert)
result <- summary(model)

any(result$coefficients[c("spontaneous", "induced"), "pvalue"] < 0.05)
any(result$coefficients[c("spontaneous", "induced"), "Pr(>|z|)"] < 0.05)

conf <- result$conf.int[c("spontaneous", "induced"), ]
all(conf[, "lower .95"] > 0) && all(conf[, "upper .95"] > 0)

#exercise
install.packages('WDI')
full_list <- WDI::WDI_data
taiwan_china_entry <- full_list$country[grep("Taiwan, China", full_list$country$country), ]
filtered_countries1 <- full_list$country[full_list$country$income %in% c("Aggregates", "Not classified"), ]
filtered_countries2 <- full_list$country[!(full_list$country$income %in% c("Aggregates", "Not classified")), ]
income_counts <- table(filtered_countries$income)
income_share <- prop.table(income_counts)

#quiz
a <- data.frame(v1=1:3, v2=LETTERS[1:3])
b <- data.frame(v2=4:6, v1=LETTERS[4:6])
m <- rbind(a, b)

data <- as.data.frame(HairEyeColor)
data$freq_level <- cut(data$Freq,breaks=c(-Inf,20,40,Inf),labels=c("Low","medium","high"),right=FALSE)

data <- swiss
data["Total",] <-colSums(data)
data["proportion"]<-data$Examination/(data[nrow(data),"Examination"])
