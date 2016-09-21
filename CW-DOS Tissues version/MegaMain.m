clear

for i=1:26
    disp(['Mouse ' num2str(i)])
    if i<10
        SuperMain(['NML0' num2str(i)])
    else
        SuperMain(['NML' num2str(i)])
    end
end

for i=30:42
    disp(['Mouse ' num2str(i)])
    SuperMain(['NML' num2str(i)])
end
