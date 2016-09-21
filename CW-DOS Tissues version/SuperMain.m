function SuperMain(MouseNumber)

datafiles = dir(['..\Penn\' MouseNumber '\Mouse_*']);

calfilenm = '.\calibration\calibration_112509';
darkfilenm = '.\calibration\dark_112509';

x0 = [10,-1.5,10,20,.8];

for i=1:length(datafiles)
    filenm = ['..\Penn\' MouseNumber '\' datafiles(i).name(1:end-4)];
    for count=1:5
        [x(count,:),res(count)] = Main2(filenm,calfilenm,darkfilenm,x0);
    end
    xf(i,:) = mean(x);
    Dx(i,:) = std(x);
    fval(i,:) = res;
end

clear ans i options rho x x0 res filenm
save([MouseNumber '.mat'])

%ChiSqCost(xf,lambda,rho,calfilenm,darkfilenm,filenm,[],Dx);


return