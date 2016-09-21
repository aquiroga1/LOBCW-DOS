function mu_a=Absor(X,Lambdas)
%   Absor: Calculate the absortion coefficient of blood, from the extintion molar
 ...values and concentrations values of Hbo, Hb and H2O, whithin of range 650-900 nm.

% 'Ext_Coef.mat' contains the matrix Extin 
% the matrix Extin's elements are wavelength between 500-900 nm and concentrations values
% [Lambda HbO Hb H2O].
% Ext is a fration of Extin, this is a matrix only with values os
% concentration [HbO Hb H2O].
% X is a column vector with concentrations values  [HbO; Hb; H2O].
%
%--------------------------------------------------------------------------
%==========================================================================
%    Date        Programmer              Description of change
%   -------     -------------           -----------------------
%   04/08/15     A. Quiroga              Original code   
%==========================================================================

load('Ext_Coef.mat')
lst=[];
tmp = [];
for i=1:length(Lambdas)
    lst = find( Extin(:,1) == Lambdas(i) );
    tmp = [tmp; Extin(lst,:)];
end
mu_a=tmp(:,2:4)*X';
end