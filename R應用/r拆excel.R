install.packages("readxl")
install.packages("writexl")
library(readxl)
library(writexl)

# 获取输入文件夹中的所有文件
input_folder <-"E:\\2024.01.13第11屆立委（各投票所得票明細及概況）"
file_list <- list.files(input_folder, full.names = TRUE)

#拆excel
excel_file <- "C:\\Users\\user\\OneDrive\\文件\\區域立委-A05-2-得票數一覽表(臺北市).xls"  # 替換成你的Excel檔案路徑
sheets <- excel_sheets(file_list)
output_folder <- "E:\\2024.1"

#只有一個excel檔
for (sheet in sheets) {
  data <- read_excel(file_list, sheet = sheet)
  write_xlsx(data, path = file.path(output_folder,paste0(sheet, ".xlsx")))  # 將每個工作表寫入以工作表名稱命名的Excel檔案中
}

#若為資料夾
for (file in file_list) {
  sheets <- excel_sheets(file)
  for (sheet in sheets) {
    data <- read_excel(file, sheet = sheet)
    write_xlsx(data, path = file.path(output_folder, paste0(basename(file), "_", sheet, ".xlsx")))  # 將每個工作表寫入以工作表名稱命名的Excel檔案中
  }
}





