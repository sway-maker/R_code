x<-c(106:111)
for (i in x) {
  new_var_name<- paste("year_", i, sep = "")
  data12[[new_var_name]] <- ifelse(data12$年份 == i, 1, 0)
}
data12[["年份"]]<-NULL
write_xlsx(data12, "output.xlsx")



