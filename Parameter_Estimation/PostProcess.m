%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File for postprocessing the calibration results with AMIGO for the model: 
% 2023 - Pedreira et al - Modelling the antimicrobial effect of food
%                         preservatives in bacteria: application to 
%                         E. coli and B. cereus inhibition with carvacrol
%=========================================================================%
clear all
close all

%% =======================================================================
%%% Plot experimental data before estimation
%%%=======================================================================
Plot_ExpData

%% =======================================================================
%%% Load results for each bacterial strain
%%%=======================================================================
clear variables
clc
load('./Generated_results/results_Bc')                                     % Load estimation results for B. cereus
load('./Generated_results/results_Ec')                                     % Load estimation results for E. Coli


%% =======================================================================
%%% Calculate MIC for each bacterial strain
%%%=======================================================================

% B. cereus parameters are: vBc.para = ('mu_g','mu_d','k_s','k_g','k_d')
mug0   = vBc.para(1);
mud0   = vBc.para(2);
kg     = vBc.para(4);
kd     = vBc.para(5);
MIC_Bc = log(mug0/mud0)/(kg+kd);                                           % MIC of B. Cereus,

% E. coli parameters are: vEc.para = ('mu_g','mu_d','k_s','k_g','k_d')
mug0   = vEc.para(1);
mud0   = vEc.para(2);
kg     = vEc.para(4);
kd     = vEc.para(5);
MIC_Ec = log(mug0/mud0)/(kg+kd);                                           % MIC of E. Coli,


%% =======================================================================
%%% Build table with calibration results in Latex format
%%%=======================================================================

disp('%==========================TABLE===========================')
disp('\begin{tabular}{llll}')
disp('& \textit{B. cereus} & \textit{E. coli} & Units\\')
disp('\hline')

fS = '%.2f';

% Display RMSE for each strain:
%-----------------------------------------------------------------
disp(['RMSE  &',num2str(vBc.RMSE,fS),'&',num2str(vEc.RMSE,fS),'\\'])

fS = '%.2g';

% Display table first column:
%-----------------------------------------------------------------
tab_text{1}  = '$\mu_{g}^0$ Max. growth rate';
tab_text{2}  = '$\mu_{d}^0$ Min. death rate';
tab_text{3}  = '$k_S$ Cell state effect';
tab_text{4}  = '$k_g$ Bacteriostatic effect';
tab_text{5}  = '$k_d$ Bactericidal effect';

% Units for each row:
%-----------------------------------------------------------------
tab_units{1} = '1';
tab_units{2} = '1/h';
tab_units{3} = '1/h';
tab_units{4} = 'L/mg';
tab_units{5} = 'L/mg';
tab_units{6} = 'mg/L';

% Print parameter estimated values:
%-----------------------------------------------------------------
for par_ind = 1:5
    disp([tab_text{par_ind},' & ',num2str(vBc.para(par_ind),fS),'$\pm$',...
        num2str(vBc.conf(par_ind),fS),' &',num2str(vEc.para(par_ind),fS),...
        '$\pm$',num2str(vEc.conf(par_ind),fS),'&',tab_units{par_ind},'\\'])
end

%-----------------------------------------------------------------
% Print MICs in last row of table:
disp(['MIC &',num2str(MIC_Bc,'%.2f'),'&',num2str(MIC_Ec,'%.2f'),'&',tab_units{6}])
disp('\end{tabular}')


%% =======================================================================
%%% Build figure with calibration results
%%%=======================================================================

datafile{1} = './Generated_results/results_Bc.mat';                        % Name of the file with calibration results for B cereus
datafile{2} = './Generated_results/results_Ec.mat';                        % Name of the file with calibration results for E coli

cols    = [{'k'},{'k'},{'r'},{'r'},{'b'},{'b'},{[.5 .5 0]},{[.5 .5 0]},... % Define colors for plot
           {'g'},{'g'},{'m'},{'m'},{'y'},{'y'}];

fig_pos = [274 802 911 575];                                               % Define figure position in window


figure

set(gcf,'OuterPosition',[624   214    1073   837])

for bii = 1:size(datafile,2)                                               % Loop in the number of strains

    % Load calibration results:
    %-----------------------------------------------------------------   
    load(datafile{bii})                                                 

    % Plot calibration results in a log10(CFUS/mL)-scale:
    %----------------------------------------------------------------- 
    for iexp = 1:2:inputs.exps.n_exp                                       % Plot model with calibrated parameters
        subplot(2,2,bii)
        plot(res.sim.tsim{iexp}, res.sim.obs{iexp}(:,1), 'Color',...
             cols{iexp}, 'LineWidth',1)
        hold on
        axis tight
    end

    for iexp = 1:inputs.exps.n_exp                                         % Plot experimental data
        subplot(2,2,bii)
        plot(inputs.exps.t_s{iexp}, inputs.exps.exp_data{iexp}(:,1), '.',...
             'Color', cols{iexp},'LineWidth',1,'MarkerSize',20)
        hold on
        axis tight
    end
   
    if any(bii == [1,3])                                                   % Display title and axis labels for B. cereus
        title('\textit{B cereus}', 'Interpreter', 'LaTeX','FontSize',14)
        ylabel('$\log_{10}$(CFUs/mL) ', 'Interpreter', 'LaTeX','FontSize',14)
    end
    
    if any(bii == [2,4])                                                   % Display title and axis labels for E. coli
        title('\textit{E coli}', 'Interpreter', 'LaTeX','FontSize',14)
        ylabel('$\log_{10}$(CFUs/mL) ', 'Interpreter', 'LaTeX','FontSize',14)
    end
    box off
    legend boxoff
    
 
    % Plot calibration results in a CFUS/mL scale:
    %----------------------------------------------------------------- 
    for iexp = 1:2:inputs.exps.n_exp                                       % Plot model with calibrated parameters
        subplot(2,2,bii+2)
        plot(res.sim.tsim{iexp},10.^(res.sim.obs{iexp}(:,1)),'Color',...
             cols{iexp},'LineWidth',1)
        hold on
        axis tight
    end

    for iexp = 1:inputs.exps.n_exp                                         % Plot experimental data
        subplot(2,2,bii+2)
        plot(inputs.exps.t_s{iexp},10.^(inputs.exps.exp_data{iexp}(:,1)),...
             '.','Color',cols{iexp},'LineWidth',1,'MarkerSize',20)
        hold on
        axis tight
    end
    
    % Axis labels:
    %-----------------------------------------------------------------
    xlabel('Time (h)', 'Interpreter', 'LaTeX','FontSize',14)
    if any(bii == [1,3])
        ylabel('CFUs/mL ', 'Interpreter', 'LaTeX','FontSize',14)
    end
    if any(bii == [2,4])
        ylabel('CFUs/mL ', 'Interpreter', 'LaTeX','FontSize',14)
    end
    box off
    legend boxoff
    
    
    % Display figure legend:
    %-----------------------------------------------------------------
    if bii == 1
        legend([{[num2str(0),'mg/L']},{[num2str(50),'mg/L']},...
                {[num2str(75),'mg/L']},{[num2str(100),'mg/L']},...
                {[num2str(150),'mg/L']},{[num2str(200),'mg/L']}],...
                'Position',[0.113144823753373 0.0139550250577015 0.83035716037361 0.044047620444944],...
                'Orientation','horizontal');
    end

end

%% =======================================================================
%%% Save figure
%%%=======================================================================
savefig('./Generated_results/fig_SubMIC_Carvacrol_Fit')
