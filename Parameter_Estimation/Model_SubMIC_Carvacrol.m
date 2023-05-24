%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File to define in AMIGO the model in: 
% 2023 - Pedreira et al - Modelling the antimicrobial effect of food
%                         preservatives in bacteria: application to 
%                         E. coli and B. cereus inhibition with carvacrol
%=========================================================================%

%==========================================================================
% Model related data
%==========================================================================
inputs.model.n_st           = 2;                                           % Number of model states
inputs.model.n_par          = 5;                                           % Number of model parameters
inputs.model.n_stimulus     = 1;                                           % Number of inputs (caravacrol concentration)
inputs.model.st_names       = char('YY','SS');                             % Names of the states ('YY = Bacterial concentration in log10 scale' and 'SS = cell state')
inputs.model.par_names      = char('mu_g0','mu_d0','k_S','k_g','k_d');     % Names of the parameters
inputs.model.stimulus_names = char('CC');                                  % Names of the stimuli, inputs or controls
inputs.model.eqns           = ...                                          % Equations describing system dynamics. Time derivatives are regarded 'd'st_name''
 char('dYY=(1/log(10))*(mu_g0*exp(-k_g*CC)*exp(-k_S*t)-mu_d0*exp(k_d*CC))',...
      'dSS=-k_S*SS');

%==========================================================================
% Load experimental data
%==========================================================================
load(['Generated_data/data_',bac])

%==========================================================================
% Initial guess of parameters, inputs.model.par = (mu_g0,mu_d0,k_S,k_g,k_d)
%==========================================================================
switch bac
    case 'Bc' % B. cereus initial guess
        inputs.model.par = [2.7673 1.7591e-14 0.15944 0.00054077 0.14245];    
    case 'Ec' % E. coli initial guess
        inputs.model.par = [2.8545 0.030465   0.16268 0.0012016 0.0012745];    
end

% =========================================================================
% Experimental scheme related data
%==========================================================================

% Auxiliary loop variables :
%-----------------------------------------------------------------
count  = 1;                                                                
count2 = 1;
n_jump = 2;
%-----------------------------------------------------------------

for iexp = 1:inputs.exps.n_exp                                             % Loop in the number of experiments (different carvacrol concentrations)
    
    % Define experimental times:
    %-----------------------------------------------------------------
    inputs.exps.t_f{iexp} = tt{count}(end);                                % Experiments duration
    inputs.exps.n_s{iexp} = size(tt{count},1);                             % Number of sampling times
    inputs.exps.t_s{iexp} = tt{count}';                                    % [] Sampling times, by default equidistant
    
    % Define input:
    %-----------------------------------------------------------------
    inputs.exps.u_interp{iexp} = 'sustained';                              % Stimuli definition                                                    %OPTIONS:u_interp: 'sustained' |'step'|'linear'(default)|'pulse-up'|'pulse-down'
    inputs.exps.u{iexp}        = uu{count};                                % Values of the inputs
    
    % Define model initial conditions from experimental data:
    %-----------------------------------------------------------------
    inputs.exps.exp_y0{iexp}   = [log10(X_cfus{1}(1)) 1];                  % Initial conditions for each experiment
    
    % Define experimental data:
    %-----------------------------------------------------------------
    inputs.exps.exp_data{iexp} = log10(X_cfus_trials{count2}(count,:)');   % Experimental concentration in log10 scale
        
    % Define model observables (bacterial concentration, log10(CFUs/mL)):
    %-----------------------------------------------------------------
    inputs.exps.n_obs{iexp}     = 1;                                       % Number of observed quantities per experiment
    inputs.exps.obs_names{iexp} = char('log10CFUs');                       % Name of the observable
    inputs.exps.obs{iexp}       = char('log10CFUs=YY');                    % The observable is the bacterial concentration in a log10 scale
    
    % Define cost function (time-weighted least squares):
    %-----------------------------------------------------------------
    inputs.PEsol.PEcost_type    = 'lsq';                                   % The cost function is 'lsq' = least squares
    inputs.PEsol.lsq_type       = 'Q_mat';                                 % Define weights names for lsq
    inputs.PEsol.lsq_Qmat{iexp} = inputs.exps.t_s{iexp}';                  % Define weights value for lsq
    
    % Actualice auxiliary loop variables:
    %-----------------------------------------------------------------
    if iexp == n_jump;
        count  = count  + 1;
        n_jump = n_jump + 2;
        count2 = 0;
    end
    count2 = count2 + 1;
    
end

%==========================================================================
% UNKNOWNS RELATED DATA
%==========================================================================
% GLOBAL UNKNOWNS (SAME VALUE FOR ALL EXPERIMENTS)
inputs.PEsol.global_theta_max   = 5*ones(size(inputs.model.par));          % Maximum allowed values for the paramters
inputs.PEsol.global_theta_min   = zeros(size(inputs.model.par));           % Minimum allowed values for the parameters
inputs.PEsol.global_theta_guess = inputs.model.par;                        % Initial guess of model parameters


%==========================================================================
% SAVE MODEL
%==========================================================================
inputs.pathd.short_name = thename;
inputs.plotd.plotlevel  = 'medium';
