### Generate figures for bacterial concentration under carvacrol therapy


# (1) User-defined options:

# Step for time discretization:
h <- 0.01

# Estimated parameter values (first component of array for B.Cereus and second component for E.Coli):
mu_g0 <- c(2.8e00,2.9e00)
mu_d0 <- c(1.7e-14,3.0e-02)
k_S   <- c(1.6e-01,1.6e-01)
k_g   <- c(5.4e-04,1.2e-03) 
k_d   <- c(1.4e-01,1.3e-03)

###

# (2) Define experimental data:

# Measuring times [h] of each experiment:
t_exp <- c(0,2,4,8,12,16,20,24,30,36,48)

# Applied concentration of Carvacrol [mg/L] in each experiment:
C_exp <- c(0.000,50.000,75.000,100.00,150.000,200.000)       

# Number of experiments:
n_exp <- 6
           
# Experimental data (CFUs/mL) for B. Cereus (two repliques, one experiment per row):   
Exp1_CFUs_Bc <- rbind(c(240000, 3700000000, 15850000000, 2.795E+11, 8.2E+11,    1.35E+12,     4.25E+12, 5E+12,    6.45E+12,  7.15E+12, 6.55E+12),
                      c(240000, 2.40E+09,   1.55E+10,    2.92E+11,  6.70E+11,    1.15E+12,    2.53E+12, 3.30E+12, 3.90E+12,  5.60E+12, 5.70E+12),
                      c(240000, 2.13E+09,   1.45E+10,    2.57E+11,  6.20E+11,    8.80E+11,    1.99E+12, 3.40E+12, 3.70E+12,  4.40E+12, 4.20E+12),
                      c(240000, 1.27E+09,   1.16E+10,    2.79E+11,  5.80E+11,    8.70E+11,    2.30E+12, 2.53E+12, 2.70E+12,  3.30E+12, 3.10E+12),
                      c(240000, 8.75E+08,   5.05E+09,    9.40E+09,  8.90E+10,    4.40E+11,    1.40E+12, 1.78E+12, 1.83E+12,  2.43E+12, 2.51E+12),
                      c(240000, 240000,     18800000,    47000000,  34500000000, 95000000000, 3.55E+11, 5E+11,    5E+11,     5.4E+11,  3.6E+11))
 

Exp2_CFUs_Bc <- rbind(c(2.20E+05,3.15E+09,1.69E+10,2.79E+11,7.55E+11,1.34E+12,4.50E+12,5.60E+12,5.90E+12,7.30E+12,7.05E+12),
                      c(2.20E+05,2.95E+09,1.53E+10,2.69E+11,7.65E+11,1.02E+12,2.27E+12,3.30E+12,3.45E+12,4.85E+12,5.10E+12),
                      c(2.20E+05,2.52E+09,1.30E+10,2.47E+11,6.05E+11,6.80E+11,2.02E+12,2.70E+12,3.15E+12,3.45E+12,3.50E+12),
                      c(2.20E+05,1.36E+09,9.90E+09,2.66E+11,6.05E+11,8.25E+11,1.95E+12,2.22E+12,2.30E+12,2.70E+12,2.60E+12),
                      c(2.20E+05,1135000000,6050000000,9550000000,2.155E+11,4.1E+11,1.51E+12,1.815E+12,1.985E+12,2.095E+12,2.34E+12),
                      c(2.20E+05,265000,13000000,25250000,5950000000,28050000000,1.49E+11,1.76E+11,1.83E+11,2.07E+11,1.13E+11))
# Average of the two experiments:  
Exp_CFUs_Bc <- (Exp1_CFUs_Bc+Exp2_CFUs_Bc)/2

# Experimental data (CFUs/mL) for E. Coli (two repliques, one experiment per row):
Exp1_CFUs_Ec <- rbind(c(300000,5100000,5400000000,1.15E+11,4.8E+11,1.9E+12,4.5E+12,5.35E+12,5.5E+12,4.9E+12,3.7E+12),
                      c(300000,3.70E+06,3.50E+09,5.90E+10,2.35E+11,5.40E+11,1.10E+12,1.71E+12,1.79E+12,1.13E+12,8.70E+11),
                      c(300000,1.21E+06,2.03E+09,4.00E+10,1.52E+11,3.50E+11,4.80E+11,7.80E+11,7.30E+11,5.70E+11,4.90E+11),
                      c(300000,1.44E+06,1.80E+09,3.70E+10,1.14E+11,3.10E+11,4.00E+11,4.50E+11,4.70E+11,3.30E+11,2.70E+11),
                      c(300000,9.20E+05,1.34E+09,3.75E+10,8.90E+10,2.05E+11,3.60E+11,4.00E+11,3.80E+11,2.85E+11,2.20E+11),
                      c(300000,535000,400000,98000000,14600000000,18900000000,65500000000,82000000000,32000000000,32000000000,13350000000))

 
Exp2_CFUs_Ec <- rbind(c(305000,6500000,5900000000,1.185E+11,5.15E+11,1.915E+12,5.15E+12,5.5E+12,5.7E+12,5.35E+12,4.1E+12),
                      c(305000,2.50E+06,3.25E+09,5.20E+10,2.00E+11,5.80E+11,8.55E+11,1.36E+12,1.44E+12,9.75E+11,8.55E+11),
                      c(305000,1.21E+06,2.03E+09,4.00E+10,1.52E+11,3.50E+11,4.80E+11,7.80E+11,7.30E+11,5.70E+11,4.90E+11),
                      c(305000,9.30E+05,1.34E+09,3.95E+10,1.07E+11,2.85E+11,3.65E+11,4.05E+11,4.30E+11,2.45E+11,2.50E+11),
                      c(305000,735000,1275000000,39000000000,1.105E+11,2.35E+11,3.35E+11,4.6E+11,3.15E+11,3.2E+11,2.4E+11),
                      c(305000,445000,370000,7200000000,35500000000,96000000000,1.81E+11,1.805E+11,1.54E+11,90500000000,88000000000))   

# Average of the two experiments:
Exp_CFUs_Ec <- (Exp1_CFUs_Ec+Exp2_CFUs_Ec)/2


###

# (3) Calculate CFUs for B.Cereus and E. Coli for each experiment:

# Time discretization:
t <- seq(t_exp[1], t_exp[11], by=h)

# Number of time steps to calculate the solution:
nt = (t_exp[11]-t_exp[1])/h + 1;

# (3.1) Calculate solution for B.Cereus in each experiment:
sol_Bc <- matrix(0, n_exp, nt);

for(i in 1:n_exp){                             
  N0 <- Exp_CFUs_Bc[i,1]
  sol_Bc[i, ] <- N0*exp(mu_g0[1]*exp(-k_g[1]*C_exp[i])*(1-exp(-k_S[1]*t))/k_S[1] - mu_d0[1]*exp(k_d[1]*C_exp[i])*t)
}

# (3.2) Calculate solution for E.Coli in each experiment:
sol_Ec <- matrix(0, n_exp, nt);

for(i in 1:n_exp){                             
  N0 <- Exp_CFUs_Ec[i,1]
  sol_Ec[i, ] <- N0*exp(mu_g0[2]*exp(-k_g[2]*C_exp[i])*(1-exp(-k_S[2]*t))/k_S[2] - mu_d0[2]*exp(k_d[2]*C_exp[i])*t)
}

###

# (4) Plot results:

# (4.1) Define colors for plot:
cc <- c("black","red","blue",rgb(0.5,0.5,0),"green","magenta");

# (4.2) Plot experimental data VS model for B. Cereus:

par(mfrow=c(1,2))

plot(t, log10(sol_Bc[1,]), type = "b", col = cc[1], xlab = "t [h]", ylab = "log10(CFUs/mL)", main="B. Cereus")

lines(t_exp, log10(Exp1_CFUs_Bc[1,]), type="p", col = cc[1])
lines(t_exp, log10(Exp2_CFUs_Bc[1,]), type="p", col = cc[1])

for(i in 2:n_exp){
  lines(t,log10(sol_Bc[i,]), type = "o",col = cc[i])
  lines(t_exp,log10(Exp1_CFUs_Bc[i,]), type = "p",col = cc[i])
  lines(t_exp,log10(Exp2_CFUs_Bc[i,]), type = "p",col = cc[i])
}

# (4.3) Plot experimental data VS model for E. Coli:

plot(t, log10(sol_Ec[1,]), type = "b", col = cc[1], xlab = "t [h]", ylab = "log10(CFUs/mL)", main="E. Coli")

lines(t_exp, log10(Exp1_CFUs_Ec[1,]), type="p", col = cc[1])
lines(t_exp, log10(Exp2_CFUs_Ec[1,]), type="p", col = cc[1])

for(i in 2:n_exp){
  lines(t, log10(sol_Ec[i,]), type = "o", col = cc[i])
  lines(t_exp, log10(Exp1_CFUs_Ec[i,]), type = "p", col = cc[i])
  lines(t_exp, log10(Exp2_CFUs_Ec[i,]), type = "p", col = cc[i])
}
