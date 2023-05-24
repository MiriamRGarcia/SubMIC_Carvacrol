%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main file to run parameter estimation with AMIGO for the model in: 
% 2023 - Pedreira et al - Modelling the antimicrobial effect of food
%                         preservatives in bacteria: application to 
%                         E. coli and B. cereus inhibition with carvacrol
%=========================================================================%
clear all
close all

%% ========================================================================
%%% Preprocessing required for AMIGO toolbox
%%%========================================================================

run AMIGO_Startup.m                                                        % Load AMIGO files. For downloading or installation of the toolbox see: sites.google.com/site/amigo2toolbox

%% ========================================================================
%%% Load options common to all model optimisations
%%%========================================================================

% Save AMIGO results in:
inputs.pathd.results_folder   = 'SubMIC_Carvacrol';                        % Name of the folder to keep results (in Results from AMIGO) for a given problem

% Type of experimental data:
inputs.model.exe_type         = 'standard';
inputs.exps.n_exp             = 6*2;                                       % Number of experiments
inputs.exps.data_type         = 'real';                                    % Type of data: 'pseudo'|'pseudo_pos'|'real'

% Numerical methods for parameter estimation:
inputs.model.input_model_type = 'charmodelC';                              % Model introduction: 'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|
inputs.ivpsol.ivpsolver       = 'cvodes';                                  % [] IVP solver: 'radau5'(default, fortran)|'rkf45'|'lsodes'|'lsodesst'|'lsoda'|'ode15s' (default, MATLAB, sbml)|'ode113'
inputs.nlpsol.nlpsolver       = 'local_fmincon';                           % 'local_fmincon'|'local_n2fb'|'local_dn2fb'|'local_dhc'|

% Uncomment for global optimizations:
%-----------------------------------------------------------------
% inputs.nlpsol.nlpsolver       = 'eSS';%'de';                               % Perform estimation using Enhaced Scatter Search. 
% inputs.nlpsol.eSS.maxeval     = 1e4;                                       % Maximum number of evaluations of the objective function,
% inputs.nlpsol.eSS.maxtime     = 50;                                        % Maximum time for optimisation,
%-----------------------------------------------------------------

%% ========================================================================
%%% Fit mechanistic model to CFUS/mL data
%%%========================================================================

mod = 'SubMIC_Carvacrol';                                                  % Name of the file containing the AMIGO model,

for bac_ii = {'Bc','Ec'};                                                  % Fit data for each bacterial strain ('Bc'= B. Cereus and 'Ec'= E.Coli),
    
    % Select type of bacteria:
    %-----------------------------------------------------------------
    bac = char(bac_ii);
    
    % Load experimental data to run the model:
    %-----------------------------------------------------------------
    thename = [mod,'_',bac];
    eval(['Model_',mod])
    
    % Run Parameter estimation (PE) and PostAnalysis:
    %-----------------------------------------------------------------
    AMIGO_Prep(inputs)                                                     % Preparation of AMIGO toolbox
    res = AMIGO_PE(inputs);                                                % Matlab structure with the calibration results
    
    disp('>> Press any key to continue with calculations')
    
    pause    
    
    close all   
    
    res_post = AMIGO_PEPostAnalysis(inputs,res);                           % Matlab structure with the post-analysis results
    
    close all
    
    % Save results:
    %-----------------------------------------------------------------
    n_all = res_post(end).ndata; k_all=res_post(end).npars;R2=res_post(end).R2;
    
    eval(['v',bac(1:2),'.post=res_post;'])
    eval(['v',bac(1:2),'.RMSE=res_post(end).RMSE;']);                      % RMSE associated to fits
    eval(['v',bac(1:2),'.para=res.fit.thetabest;']);                       % Calibrated parameters
    eval(['v',bac(1:2),'.conf=res.fit.conf_interval;']);                   % Confidence intervals
    
    save(['./Generated_results/results_',bac]);                            % Save calibration results for each strain
end

%% ========================================================================
%%% Run postprocess (figures and tables)
%%%========================================================================
PostProcess
