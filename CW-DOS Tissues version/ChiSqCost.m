function cost = ChiSqCost(x,wavelngh,rho,calfilenm,darkfilenm,filenm,musp,plotfig)


% Calculated normalized measured fluence
[oLambda,oRefl_exp] = CalcMeasReflectance(wavelngh,calfilenm,darkfilenm,filenm);

% Estimate optical properties
if size(x,2)>=3
    Lambda = [wavelngh(1):2:wavelngh(2)]';
    for i = 1:length(Lambda)
        if i==1;
            lst = find(round(oLambda)<=Lambda(i));
        else
            lst = find(round(oLambda)<=Lambda(i) & round(oLambda)>Lambda(i-1));
        end
        Refl_exp(i,:) = mean(oRefl_exp(lst,:),1);
    end
    clear o*
    
    musp = x(1).*(Lambda/1000).^(x(2));
    
    load('Ext_Coef.mat')
    lst = find(Extin(:,1)==Lambda(1));
    lst2 = find(Extin(:,1)==Lambda(end));
    E_HbO = Extin(lst:lst2,2)/(1e6);
    E_HbR = Extin(lst:lst2,3)/(1e6);
    E_H2O = Extin(lst:lst2,4);
    A = [E_HbO E_HbR E_H2O];
    mua = A*[x(3); x(4); x(5)];
    
    % Calculate Theoretical Reflectance
    for i=1:length(Lambda)
        Refl_teo(i,:) = CalcReflectance(mua(i),musp(i),rho);
    end
    
else
    Refl_exp = oRefl_exp;
    % Calculate Theoretical Reflectance
    for i=1:length(oLambda)
        if isempty(musp)
            Refl_teo(i,:) = CalcReflectance(x(1),x(2),rho);
        else
            Refl_teo(i,:) = CalcReflectance(x(1),musp,rho);
        end
    end
    
end

% Discard first source-detector separation
tocut = [1 2 3 7 8 9];
Refl_exp(:,tocut) = [];
Refl_teo(:,tocut) = [];
rho(tocut) = [];

% Normalize data to first source-detector separation
Refl_exp = Refl_exp ./ (ones(size(Refl_exp,1),1)*mean(Refl_exp));

Refl_teo = Refl_teo ./ (ones(size(Refl_teo,1),1)*mean(Refl_teo));


Rdiff = ( (Refl_teo-Refl_exp)./ (ones(size(Refl_teo,1),1)*rho) ).^2;
cost = sum(sum(Rdiff));

if plotfig
    figure(1),subplot(1,3,1),plot(Lambda,Refl_exp,'.')
    hold on; plot(Lambda,Refl_teo)
    hold off
    
   subplot(1,3,2),plot(Lambda,mua)
   subplot(1,3,3),plot(Lambda,musp)
end

return
