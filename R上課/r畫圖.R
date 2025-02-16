#1
df <- data.frame(x = c(1,2,NA,4),
                 y = c("A",NA,"C","D"))
df <- df %>%
  mutate(x = case_when(
    is.na(x) ~ mean(df$x, na.rm = TRUE), 
    TRUE ~ x            
  ))

df_x <- data.frame(
  category = factor(sample(LETTERS[1:5], 120, T)),
  date = seq(as.Date("2011/1/1"),
             by = "month", length.out = 120),
  num1 = rnorm(120, mean = 2, sd = 5),
  num2 = sample(1:10, 120, T),
  num3 = runif(120)
)
df_y <- data.frame(
  category = factor(sample(LETTERS[1:5], 120, T)),
  date = seq(as.Date("2011/1/1"),
             by = "month", length.out = 120),
  num1 = rnorm(120, mean = 20, sd = 5),
  num2 = sample(1:20, 120, T),
  num3 = runif(120)
)
df <- rbind(df_x, df_y)

#2
df_x %>%
  ggplot() +
  geom_density(aes(x = num1))

#3
Q1 <- quantile(df_y$num1, 0.25)
Q3 <- quantile(df_y$num1, 0.75)
IQR <- Q3 - Q1
lower_bound <- Q1 - 1.5 * IQR
upper_bound <- Q3 + 1.5 * IQR
df_y <- df_y %>%
  mutate(outlier = num1 < lower_bound | num1 > upper_bound)
df_y %>%
  ggplot() +
  geom_point(aes(x = date,
                 y = num1,
                 color =outlier ))

#4
df_x %>%
  ggplot() +
  geom_line(aes(x = date, y = num1))+
  geom_vline(xintercept = as.Date("2015-01-01"), linetype = "dashed", color = "red") +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  geom_smooth(aes(x = date, y = num1), method = "lm", se = FALSE, color = "green")

#5



#6
df_y %>%
  ggplot() +
  geom_point(aes(x = num1, y = num2), position = position_jitter(width = 0.1, height = 0.1))

#7
df_x %>%
  ggplot() +
  geom_line(aes(x = date, y = num1))+
  scale_x_date(date_breaks = "1 year", date_labels = "%Y") 

#9
df_y %>%
  ggplot() +
  geom_boxplot(aes(x = reorder(category, num1, FUN = median), y = num1))+
  labs(x = "Category", y = "Number 1")

