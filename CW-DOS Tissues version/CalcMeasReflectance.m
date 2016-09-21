function [lambda,Refl_exp] = CalcMeasReflectance(wavelngh,calfilenm,darkfilenm,filenm)


% Open calibration files
file = [calfilenm '.SPE'];  % Read light spectrum (calibration)
[foo,cal] = spereadnew(file);

file = [darkfilenm '.SPE'];  % Read dark spectrum (experiment with NO light)
[foo,dark] = spereadnew(file);

file = [filenm '.SPE']; % Read data spectrum
[lambda dtmp] = spereadnew(file);

% Remove dark noise and calibrate data
calavg = mean(cal,3);
darkavg = mean(dark,3);
dtmpavg = mean(dtmp,3);

ncalavg = calavg - darkavg;
dtmpavg = dtmpavg - darkavg;
Refl_exp = dtmpavg./ncalavg;

% Cut data to wavelength range
if size(wavelngh,1)>1 | size(wavelngh,2) > 1  % If passed a range of wavelengths
    range = find( lambda >= wavelngh(1) & lambda <= wavelngh(2) );
    
    lambda = lambda(range);
    Refl_exp = Refl_exp(range,:);
    
elseif size(wavelngh,1)==1 & size(wavelngh,2) == 1  % If passed a single wavelength
    range = find( lambda <= wavelngh );    
    
    lambda = lambda(range(end));
    Refl_exp = Refl_exp(range(end),:);
end

return