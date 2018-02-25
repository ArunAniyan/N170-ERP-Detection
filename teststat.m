%% Test statistics of full cwt
% Arun Kumar A
% Santhom Computing Facility
% aka.bhagya@gmail.com
% 22-1-12


function [mnpos mdpos rnpos mp] = teststat(data,scls)

%scls = 60:70;

c = cwt(data,scls,'sym5');

for i=1:numel(scls)
    
    [m(i) p(i)] = max(c(i,:));
end

mnpos = mean(p);
mdpos = mode(p);
rnpos = range(p); 

[l mp] = max(m);