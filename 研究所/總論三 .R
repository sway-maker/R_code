library(Deriv)
library(ggplot2)
############################################################
#1-c
f <- function(k, a) k^a
f_prime_inv <- function(a, y) (y / a)^(1 / (a - 1))

a <- 0.8
b <- 0.7
d <- 0.1
k <- seq(0.1, 13, length.out = 100)

g0 <- 0
Lk_t0 <- f(k, a) - d * k - g0
Lc_t0 <- f(k, a) - g0 + (1 - d) * k - f_prime_inv(a, 1 / b - (1 - d))

g1 <- 1
Lk_t1 <- f(k, a) - d * k - g1
Lc_t1 <- f(k, a) - g1 + (1 - d) * k - f_prime_inv(a, 1 / b - (1 - d))

intersection_t0 <- which.min(abs(Lk_t0 - Lc_t0))
k_intersection_t0 <- k[intersection_t0]
y_intersection_t0 <- Lk_t0[intersection_t0]

intersection_t1 <- which.min(abs(Lk_t1 - Lc_t1))
k_intersection_t1 <- k[intersection_t1]
y_intersection_t1 <- Lk_t1[intersection_t1]

ggplot() +
  geom_line(aes(x = k, y = Lk_t0, color = "Lk (g=0)"), size = 1) +
  geom_line(aes(x = k, y = Lc_t0, color = "Lc (g=0)"), size = 1) +
  geom_point(aes(x = k_intersection_t0, y = y_intersection_t0), color = "black", size = 3) +
  
  geom_line(aes(x = k, y = Lk_t1, color = "Lk (g=1)"), size = 1) +
  geom_line(aes(x = k, y = Lc_t1, color = "Lc (g=1)"), size = 1) +
  geom_point(aes(x = k_intersection_t1, y = y_intersection_t1), color = "black", size = 3) +

  labs(title = "Lc & Lk", x = "k", y = "c") +
  ylim(0, 10) +  
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(hjust = 0.5, size = 18, face = "bold"),  
    axis.title = element_text(size = 14, face = "bold"),           
    legend.title = element_blank(),                                      
    legend.position = "top"                                      
  ) +
  scale_color_manual(values = c("Lk (g=0)" = "#FFB6C1", "Lc (g=0)" = "#00CED1", 
                                "Lk (g=1)" = "plum3", "Lc (g=1)" = "skyblue2")) + 
  guides(color = guide_legend(override.aes = list(size = 1.5)))
#################################################################
#1-d
delta <- 0.1
theta <- 1
beta <- 0.7
alpha <- 0.8
g <- 1

u <- function(c, theta) (c^(1 - theta)-1)/(1 - theta) 
f <- function(k, alpha) k^alpha
f_prime <- function(k ,alpha) alpha*k^(alpha - 1)

k_star_old <- (((1/beta)-(1-delta)) / (alpha))^(1/(alpha-1))
k_star_new <- (((1/beta)-(1-delta)) / (alpha))^(1/(alpha-1))
c_star_old <- f(k_star_old , alpha) - delta * k_star_old
c_star_new <- f(k_star_new , alpha) - delta * k_star_new - g

hc <- function(k, c) {c * {beta * (alpha* {k^alpha + (1 - delta) * k - c - g}^(alpha - 1) + (1 - delta))}^(1 / theta)}
hk <- function(k, c) {k^alpha + (1 - delta) * k - c - g}

k <- quote(k)
c <- quote(c)

hck <- Deriv(hc, "k")
hcc <- Deriv(hc, "c")
hkk <- Deriv(hk, "k")
hkc <- Deriv(hk, "c")

M <- matrix(c(hkk(k_star_new,c_star_new), hkc(k_star_new,c_star_new), hck(k_star_new,c_star_new), hcc(k_star_new,c_star_new)), nrow = 2, byrow = TRUE)
eigen(M)
eigen(M)$values[2]
v_12 <-  eigen(M)$vectors[1,2]
v_22 <-  eigen(M)$vectors[2,2]

k0_hat <- k_star_old- k_star_new 
z1_0 <- k0_hat/v_12
c0_hat <- z1_0*v_22

t= 0:20
results <- sapply(t, function(t) eigen(M)$values[2]^t * c(k0_hat,c0_hat))
results_df <- data.frame(t, k_t = results[1,] + k_star_new, c_t = results[2,] + c_star_new)

before_df <- data.frame(t = -5:-1, k_t = rep(k_star_old, 5), c_t = rep(c_star_old, 5))
final_df <- rbind(before_df, results_df)

ggplot(final_df, aes(x = t)) +
  geom_line(aes(y = k_t, color = "K_t"), size = 1.2) +
  geom_line(aes(y = c_t, color = "C_t"), size = 1.2) +
  labs(title = "C 和 K 的變化圖", x = "時間 (t)", y = "c, k") +
  scale_color_manual("", values = c("K_t" = "skyblue2", "C_t" = "#FFB6C1")) +
  theme_minimal(base_size = 15) + 
  theme(
    plot.title = element_text(hjust = 0.5, size = 20, face = "bold", color = "gray24"),
    axis.title = element_text(size = 14, face = "bold"),  
    legend.position = "top"
  )
###################################################################
f <- function(k, a) k^a
f_prime_inv <- function(a, y) (y / a)^(1 / (a - 1))

a <- 0.8  
b <- 0.7  
d <- 0.1  
k <- seq(0.1, 13, length.out = 100) 

g0 <- 0 
Lk_t0 <- f(k, a) - d * k  
Lc_t0 <- f(k, a) + (1 - d) * k - f_prime_inv(a, (1 / b - (1 - d)) / (1 - g0))  

g1 <- 0.10
Lk_t1 <- f(k, a) - d * k  
Lc_t1 <- f(k, a) + (1 - d) * k - f_prime_inv(a, (1 / b - (1 - d)) / (1 - g1))  

intersection_t0 <- which.min(abs(Lk_t0 - Lc_t0))
k_intersection_t0 <- k[intersection_t0]
y_intersection_t0 <- Lk_t0[intersection_t0]

intersection_t1 <- which.min(abs(Lk_t1 - Lc_t1))
k_intersection_t1 <- k[intersection_t1]
y_intersection_t1 <- Lk_t1[intersection_t1]

ggplot() +
  geom_line(aes(x = k, y = Lk_t0, color = "Lk (t=0)"), size = 1, linetype = "solid") +
  geom_line(aes(x = k, y = Lc_t0, color = "Lc (t=0)"), size = 1, linetype = "solid") +
  geom_point(aes(x = k_intersection_t0, y = y_intersection_t0), color = "black", size = 3) +
  
  geom_line(aes(x = k, y = Lk_t1, color = "Lk (t=0.10)"), size = 1, linetype = "solid") +
  geom_line(aes(x = k, y = Lc_t1, color = "Lc (t=0.10)"), size = 1, linetype = "solid") +
  geom_point(aes(x = k_intersection_t1, y = y_intersection_t1), color = "black", size = 3) +
  
  labs(title = "Lc 與 Lk 的交點",
       x = "k",
       y = "c") +
  ylim(0, 10) +  
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(hjust = 0.5, size = 18, face = "bold"),
    axis.title = element_text(size = 14, face = "bold"),            
    legend.title = element_blank(),                                   
    legend.position = "top"                                        
  ) +
  scale_color_manual(values = c("Lk (t=0)" = "#FFB6C1", "Lc (t=0)" = "#00CED1", 
                                "Lk (t=0.10)" = "plum3", "Lc (t=0.10)" = "skyblue2")) + 
  guides(color = guide_legend(override.aes = list(size = 1.5))) 
#################################################################
delta <- 0.1
theta <- 1
beta <- 0.7
alpha <- 0.8
tax <- 0.1
u <- function(c, theta) (c^(1 - theta)-1)/(1 - theta) 
f <- function(k, alpha) k^alpha
f_prime <- function(k ,alpha) alpha*k^(alpha - 1)

k_star_old <- (((1/beta)-(1-delta)) / (alpha))^(1/(alpha-1))
k_star_new <- (((1/beta)-(1-delta)) / (alpha*(1-tax)))^(1/(alpha-1))
c_star_old <- f(k_star_old , alpha) - delta * k_star_old
c_star_new <- f(k_star_new , alpha) - delta * k_star_new

hc <- function(k, c) {c * {beta * (alpha*{(1-tax) * k^alpha + (1 - delta) * k - c}^(alpha - 1) + (1 - delta))}^(1 / theta)}
hk <- function(k, c) {(1-tax) * k^alpha + (1 - delta) * k - c}

k <- quote(k)
c <- quote(c)

hck <- Deriv(hc, "k")
hcc <- Deriv(hc, "c")
hkk <- Deriv(hk, "k")
hkc <- Deriv(hk, "c")

M <- matrix(c(hkk(k_star_new,c_star_new), hkc(k_star_new,c_star_new), hck(k_star_new,c_star_new), hcc(k_star_new,c_star_new)), nrow = 2, byrow = TRUE)
eigen(M)
eigen(M)$values[2]
v_12 <-  eigen(M)$vectors[1,2]
v_22 <-  eigen(M)$vectors[2,2]

k0_hat <- k_star_old- k_star_new 
z1_0 <- k0_hat/v_12
c0_hat <- z1_0*v_22

t= 0:60
results <- sapply(t, function(t) eigen(M)$values[2]^t * c(k0_hat,c0_hat))
results_df <- data.frame(t, k_t = results[1,] + k_star_new, c_t = results[2,] + c_star_new)
before_df <- data.frame(t = -5:-1, k_t = rep(k_star_old, 5), c_t = rep(c_star_old, 5))
final_df <- rbind(before_df, results_df)


ggplot(final_df, aes(x = t)) +
  geom_line(aes(y = k_t, color = "K_t"), size = 1.2) +
  geom_line(aes(y = c_t, color = "C_t"), size = 1.2) +
  labs(title = "C 和 K 的變化圖", x = "時間 (t)", y = "c, k") +
  scale_color_manual("", values = c("K_t" = "skyblue2", "C_t" = "#FFB6C1")) +
  theme_minimal(base_size = 15) + 
  theme(
    plot.title = element_text(hjust = 0.5, size = 20, face = "bold", color = "gray24"),
    axis.title = element_text(size = 14, face = "bold"),  
    legend.position = "top"
  )+
  ylim(0,8)
