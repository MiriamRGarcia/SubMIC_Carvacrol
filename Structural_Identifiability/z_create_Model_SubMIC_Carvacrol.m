%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File to define in STRIKE-GOLDD the model in:
% 2023 - Pedreira et al - Modelling the antimicrobial effect of food
%                         preservatives in bacteria: application to 
%                         E. coli and B. cereus inhibition with carvacrol
%=========================================================================%
clear variables

% State variables:
%-----------------------------------------------------------------
% SS = cell state,
% NN = bacterial concentration,
syms SS NN
x = [SS;NN];

% Model unknown parameters:
%-----------------------------------------------------------------
% mug0 = Maximum growth rate in absence of carvacrol,
% mud0 = Death rate in absence of carvacrol,
% kS   = Cell state effect,
% kg   = Bacteriostatic effect,
% kd   = Bactericide effect,
syms mug0 mud0 kS kg kd
p = [mug0 mud0 kS kg kd].'; 
 
% Model inputs:
%-----------------------------------------------------------------
% CC = carvacrol applied concentration [mg/L],
syms CC
u = CC;
 
% Model dynamic equations: 
%-----------------------------------------------------------------
mug = mug0*exp(-kg*u);                                                     % Maximum growth rate
mud = mud0*exp(kd*u);                                                      % Death rate

f = [-kS*SS;                                                               % Model equations
     (mug*SS - mud)*NN];

% Model output (bacterial concentration (CFUs/mL)):
%-----------------------------------------------------------------
h  = NN;

% Initial conditions:
%-----------------------------------------------------------------
ics  = [1 3.025e5];    

% Which initial conditions are known:
%-----------------------------------------------------------------
known_ics = [1 1];

save('Model_SubMIC_Carvacrol','x','h','p','f','u','ics','known_ics'); 
