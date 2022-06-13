%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Generate figure for bacterial population subject to Carvacrol therapy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear variables

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% (1) User-defined options:

% Step for time discretization:
h = 0.01; 

% Estimated parameter values for B. Cereus:
mu_g0(1) = 2.7993;
mu_d0(1) = 8.6042e-15;
k_S(1) = 1.6207e-01;
k_g(1) = 4.7341e-04 ;
k_d(1) = 1.4653e-01;

% Estimated parameter values for E.Coli:
mu_g0(2) = 2.7233;
mu_d0(2) = 3.5874e-02;
k_S(2) = 1.5092e-01;
k_g(2) = 1.5645e-03;
k_d(2) = 5.6927e-04;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% (2) Define experimental data:

% Measuring times [h] of each experiment:
t_exp = [0 2 4 8 12 16 20 24 30 36 48].';

% Applied concentration of Carvacrol [mg/L] in each experiment:
C_exp = [0.000 50.000 75.000 100.00 150.000 200.000].';       

% Number of experiments:
n_exp = numel(C_exp);
           
% Experimental data (CFUs/mL) for B. Cereus (two repliques, one experiment per row):      
Exp1_CFUs_Bc = [240000	3700000000	15850000000	2.795E+11	8.2E+11	    1.35E+12	4.25E+12	5E+12	    6.45E+12	7.15E+12	6.55E+12;
                240000  2.40E+09	1.55E+10	2.92E+11	6.70E+11	1.15E+12	2.53E+12	3.30E+12	3.90E+12	5.60E+12	5.70E+12;
                240000  2.13E+09	1.45E+10	2.57E+11	6.20E+11	8.80E+11	1.99E+12	3.40E+12	3.70E+12	4.40E+12	4.20E+12;
                240000  1.27E+09	1.16E+10	2.79E+11	5.80E+11	8.70E+11	2.30E+12	2.53E+12	2.70E+12	3.30E+12	3.10E+12;
                240000  8.75E+08	5.05E+09	9.40E+09	8.90E+10	4.40E+11	1.40E+12	1.78E+12	1.83E+12	2.43E+12	2.51E+12;
                240000  240000      18800000	47000000	34500000000	95000000000	3.55E+11	5E+11       5E+11       5.4E+11     3.6E+11];
            
Exp2_CFUs_Bc = [2.20E+05  3.15E+09	  1.69E+10	 2.79E+11	7.55E+11	1.34E+12	4.50E+12	5.60E+12	5.90E+12	7.30E+12	7.05E+12;
                2.20E+05  2.95E+09	  1.53E+10	 2.69E+11	7.65E+11	1.02E+12	2.27E+12	3.30E+12	3.45E+12	4.85E+12	5.10E+12;
                2.20E+05  2.52E+09	  1.30E+10	 2.47E+11	6.05E+11	6.80E+11	2.02E+12	2.70E+12	3.15E+12	3.45E+12	3.50E+12;
                2.20E+05  1.36E+09	  9.90E+09	 2.66E+11	6.05E+11	8.25E+11	1.95E+12	2.22E+12	2.30E+12	2.70E+12	2.60E+12;
                2.20E+05  1135000000  6050000000 9550000000	2.155E+11	4.1E+11     1.51E+12	1.815E+12	1.985E+12	2.095E+12	2.34E+12;
                2.20E+05  265000      13000000	 25250000	5950000000	28050000000	1.49E+11	1.76E+11	1.83E+11	2.07E+11	1.13E+11];
% Average of the two experiments:  
Exp_CFUs_Bc = [2.30e5 3.43e9  1.64e10 2.79e11  7.88e11   1.35e12   4.38e12  5.30e12   6.18e12   7.23e12  6.80e12;
               2.30e5 2.68e9  1.54e10 2.80e11  7.18e11   1.08e12   2.40e12  3.30e12   3.68e12   5.23e12  5.40e12;
               2.30e5 2.31e9  1.41e10 2.41e11  5.83e11   8.30e11   1.94e12  3.00e12   3.63e12   4.23e12  3.70e12;
               2.30e5 1.32e9  1.08e10 2.72e11  5.93e11   8.48e11   2.13e12  2.38e12   2.50e12   3.00e12  2.85e12;
               2.30e5 1.005e9 5.55e9  9.475e9  1.5225e11 4.25e11   1.455e12 1.7975e12 1.9075e12 2.26e12  2.4225e12;
               2.30e5 2.525e5 1.59e7  3.6125e7 2.0225e10 6.1525e10 2.52e11  3.38e11   3.415e11  3.735e11 2.365e11];
           
% Experimental data (CFUs/mL) for E. Coli (two repliques, one experiment per row):
Exp1_CFUs_Ec = [300000	5100000   5400000000 1.15E+11	4.8E+11     1.9E+12     4.5E+12     5.35E+12	5.5E+12     4.9E+12     3.7E+12;
                300000  3.70E+06  3.50E+09   5.90E+10	2.35E+11	5.40E+11	1.10E+12	1.71E+12	1.79E+12	1.13E+12	8.70E+11;
                300000  1.21E+06  2.03E+09	 4.00E+10	1.52E+11	3.50E+11	4.80E+11	7.80E+11	7.30E+11	5.70E+11	4.90E+11;
                300000  1.44E+06  1.80E+09	 3.70E+10	1.14E+11	3.10E+11	4.00E+11	4.50E+11	4.70E+11	3.30E+11	2.70E+11;
                300000  9.20E+05  1.34E+09	 3.75E+10	8.90E+10	2.05E+11	3.60E+11	4.00E+11	3.80E+11	2.85E+11	2.20E+11;
                300000  535000    400000     98000000	14600000000	18900000000	65500000000	82000000000	32000000000	32000000000	13350000000];
            
Exp2_CFUs_Ec = [305000	6500000   5900000000 1.185E+11	 5.15E+11	 1.915E+12	 5.15E+12	5.5E+12     5.7E+12     5.35E+12	4.1E+12;
                305000  2.50E+06  3.25E+09	 5.20E+10	 2.00E+11	 5.80E+11	 8.55E+11	1.36E+12	1.44E+12	9.75E+11	8.55E+11;
                305000  1.21E+06  2.03E+09	 4.00E+10	 1.52E+11	 3.50E+11	 4.80E+11	7.80E+11	7.30E+11	5.70E+11	4.90E+11;
                305000  9.30E+05  1.34E+09	 3.95E+10	 1.07E+11	 2.85E+11	 3.65E+11	4.05E+11	4.30E+11	2.45E+11	2.50E+11;
                305000  735000    1275000000 39000000000 1.105E+11	 2.35E+11	 3.35E+11	4.6E+11     3.15E+11	3.2E+11     2.4E+11;
                305000  445000    370000     7200000000	 35500000000 96000000000 1.81E+11	1.805E+11	1.54E+11	90500000000	88000000000];

% Average of the two experiments:
Exp_CFUs_Ec = [3.025e5 5.800e6 5.6500e9  1.1675e11  4.975e11 1.908e12 4.825e12 5.425e12 5.600e12 5.125e12 3.900e12;     
               3.025e5 3.100e6 3.3800e9  5.5500e10  2.180e11 5.600e11 9.780e11 1.530e12 1.610e12 1.050e12 8.630e11;
               3.025e5 2.110e6 1.8300e9  3.7000e10  1.460e11 3.480e11 4.450e11 7.100e11 7.100e11 4.900e11 4.280e11;
               3.025e5 1.190e6 1.5700e9  3.8300e10  1.100e11 2.980e11 3.830e11 4.280e11 4.500e11 2.880e11 2.600e11;
               3.025e5 8.275e5 1.3075e9  3.8250e10  9.975e10 2.200e11 3.475e11 4.300e11 3.475e11 3.025e11 2.300e11;
               3.025e5 4.900e5 3.8500e5  3.6490e9   2.505e10 5.745e10 1.233e11 1.313e11 9.300e10 6.125e10 5.068e10];
           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% (3) Calculate CFUs for B.Cereus and E. Coli for each experiment:

% Time discretization:
t = t_exp(1):h:t_exp(end);

% Number of time steps to calculate the solution:
nt = numel(t);

%%% (3.1) Calculate solution for B.Cereus in each experiment:
sol_Bc = zeros(n_exp,nt);

% Loop to calculate solution for each experiment:
for i = 1:n_exp
    N0          = Exp_CFUs_Bc(i,1);
    sol_Bc(i,:) = N0*exp(mu_g0(1)*exp(-k_g(1)*C_exp(i))*(1-exp(-k_S(1)*t))/k_S(1) - mu_d0(1)*exp(k_d(1)*C_exp(i))*t);
end

%%% (3.2) Calculate solution for E.Coli in each experiment:
sol_Ec = zeros(n_exp,nt);

% Loop to calculate solution for each experiment:
for i = 1:n_exp
    N0            = Exp_CFUs_Ec(i,1);
    sol_Ec(i,:) = N0*exp(mu_g0(2)*exp(-k_g(2)*C_exp(i))*(1-exp(-k_S(2)*t))/k_S(2) - mu_d0(2)*exp(k_d(2)*C_exp(i))*t);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% (3) Plot results:

% Array with colors for each experiment:
ccc=[{'k'},{'r'},{'b'},{[.5 .5 0]},{'g'},{'m'}];

figure

subplot(1,2,1)
for i = 1:n_exp
    plot(t,sol_Bc(i,:),'-','Color',ccc{i},'Linewidth',1.5)
    hold on
    plot(t_exp,Exp1_CFUs_Bc(i,:),'o','Color',ccc{i},'MarkerFaceColor',ccc{i})
    plot(t_exp,Exp2_CFUs_Bc(i,:),'o','Color',ccc{i},'MarkerFaceColor',ccc{i})
end
hold off
box off
xlabel('$t$ (h)','Interpreter','Latex')
ylabel('CFUs/mL','Interpreter','Latex')
title('\textit{B. Cereus}','Interpreter','Latex')

subplot(1,2,2)
for i = 1:n_exp
    plot(t,sol_Ec(i,:),'-','Color',ccc{i},'Linewidth',1.5)
    hold on
    plot(t_exp,Exp1_CFUs_Ec(i,:),'o','Color',ccc{i},'MarkerFaceColor',ccc{i})
    plot(t_exp,Exp2_CFUs_Ec(i,:),'o','Color',ccc{i},'MarkerFaceColor',ccc{i})
end
hold off
box off
xlabel('$t$ (h)','Interpreter','Latex')
ylabel('CFUs/mL','Interpreter','Latex')
title('\textit{E. Coli}','Interpreter','Latex')


