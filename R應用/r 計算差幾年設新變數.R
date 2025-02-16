基準年月 <- list(
  鳳梨 = "110/03/01",
  釋迦 = "110/09/01",
  蓮霧 = "110/09/01",
  柑橘 = "111/08/01",
  芒果 = "112/08/01")


基準年月_鳳梨 <- "110/03/01"
基準年月_釋迦 <- "110/09/01"
基準年月_蓮霧 <- "110/09/01"
基準年月_柑橘 <- "111/08/01"
基準年月_芒果 <- "112/08/01"

calculate_month_diff <- function(日期, 基準日期) {
  parts <- strsplit(日期, "/")[[1]]
  基準 <- as.numeric(strsplit(基準日期, "/")[[1]])
  
  年差 <- as.numeric(parts[1]) - 基準[1]
  月差 <- as.numeric(parts[2]) - 基準[2]
  
  年差 * 12 + 月差
}

水果日期$月份差異_鳳梨 <- sapply(水果日期$日期...1, calculate_month_diff, 基準年月_鳳梨)
水果日期$月份差異_釋迦 <- sapply(水果日期$日期...4, calculate_month_diff, 基準年月_釋迦)
水果日期$月份差異_蓮霧 <- sapply(水果日期$日期...7, calculate_month_diff, 基準年月_蓮霧)
水果日期$月份差異_柑橘 <- sapply(水果日期$日期...10, calculate_month_diff, 基準年月_柑橘)
水果日期$月份差異_芒果 <- sapply(水果日期$日期...13, calculate_month_diff, 基準年月_芒果)

library(writexl)
write_xlsx(水果日期,"水果日期.xls")