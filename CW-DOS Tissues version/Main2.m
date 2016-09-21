function [x,res] = Main2(filenm,calfilenm,darkfilenm,x0)
%--------------------------------------------------------------------------
%==========================================================================
%    Date        Programmer         Manager           Description of change
%   -------     -------------   ----------------      ---------------------
%   03/12/15     A. Quiroga      R. C. Mesquita            Original code   
%==========================================================================
%--------------------------------------------------------------------------
%Main2: Matemathical optimizaton the function "Chi Square Cost" (ChiSqCost) using the "simulannealbnd" function 
...
% Define constants

rho = [0.06 0.12 0.18 0.24 0.30 0.40 0.50 0.60 0.80];% 1.0]; % source-detector distance (in cm)
% Define boundered 
x1 = [1, -5, 0, 0, 0.1]; % state vector [A,B,HbO,HbR,H2O]
x2 = [20, -.1, 100, 100, 1]; % state vector [A,B,HbO,HbR,H2O]

lambda = [700 900];%  wavelength's interval
    
fun = @(x)ChiSqCost(x,lambda,rho,calfilenm,darkfilenm,filenm,[],0);% mean function (ChiSqCost)
options = saoptimset('Display','off');% options  
[x,res] = simulannealbnd(fun,x0,x1,x2,options);%  Matemathical optimizaton

return

