A = 1 
delta = 0.5 
theta = 0.8 
beta = 0.9  
alpha = 0.5
kbar =(((1/beta)-(1-delta))/(alpha*A))^(1/(alpha-1))

kseq <- seq(from = 0, to = kbar, by = 0.0005)
vseq <- numeric(length(kseq))
Tvseq <- numeric(length(kseq))
pol <- numeric(length(kseq))
Tvtemp <- numeric(length(kseq))

g <- function(x) { A*x^alpha + (1-delta)*x } 
u <- function(x) { (x^(1-theta)-1)/(1-theta) }

for (h in 1:100) {
  vseq = Tvseq
  for (i in 1 : length(kseq)){
    for (j in 1:length(kseq)) {
      if (g(kseq[i]) - kseq[j] >= 0) {
        Tvtemp[j] <- u(g(kseq[i]) - kseq[j]) + beta * vseq[j]
      } else {
       Tvtemp[j] <- Inf 
      }
      M <- max(Tvtemp)
      m <- which.max(Tvtemp)
      Tvseq[i] <- M
      pol[i] <- m
      d <- max(abs(Tvseq - vseq))

    }
  }
}

data <- data.frame(k = kseq, v = vseq)
ggplot(data, aes(x = k, y = v)) +
  geom_line(color = "blue", size = 1) +
  labs(title = "Value Function vs. Capital",
       x = "Capital (k)",
       y = "Value Function (v)") +
  theme_minimal(base_size = 14)

data_dynamic <- data.frame(Time = 1:1339, Capital = pol)

ggplot(data_dynamic, aes(x = Time, y = Capital)) +
  geom_line(color = "red", size = 1) +
  labs(title = "Dynamic Path of Capital Over Time",
       x = "Time",
       y = "Capital (k)") +
  theme_minimal(base_size = 14)