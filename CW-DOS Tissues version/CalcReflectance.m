function Reflect = CalcReflectance(mua, musp, rho)

% Theoretical model for diffuse reflectance

% Constants definition
n=1.33; %index of refraction of water in relation to air
c=29979245800; %Speed of Light in the vacuum cm/s
v=c/n; %Speed of Light in the cm/s
c1=0.1178; c2=0.3056; % Strength of fluence and flux in combined model

Reff = -1.44*n^(-2)+0.71*n^(-1)+0.668+0.064*n;
mutp = mua+musp; 
A = (1+Reff)/(1-Reff);     
D = 1/(3./mutp);   %Diffusion coefficient
z0 = 1./mutp;    % 1/(musp+mua);
zb = A*2*D;
ki = sqrt(mua./D);   %%mueff = ki= squrt(3*mua*mutp);

% Calculate fluence and flux
temp_num = [];
for i = 1:length(rho),   
    r1 = sqrt(rho(i).^2+z0.^2);
    r2 = sqrt(rho(i).^2+(z0+2*zb).^2);
    
    phi = ( exp(-ki*r1)./r1 - exp(-ki*r2)./r2 ) / (4*pi*D);
    
    jz = (z0.*(ki+1./r1).*(exp(-ki*r1)/(r1^2)) +(z0+2*zb).*(ki+1./r2).*(exp(-ki*r2)/(r2^2))) / (4*pi);

    temp_num(:,i) = c1*phi + c2*jz;
end

Reflect = temp_num;

return
