%% ERP Identification Pipeline - Decision Function
% Multiscale Decomposition Decision Function 
% Arun Kumar A
% Santhom Computing Facility, Dept. Of Physics, St Thomas College,Kozhencherry
% aka.bhagya@gmail.com
% 21-1-13


function points = mdec(datafile,wav,fs)

classnm = 'Face';
ts = round((1/fs)*1000);

scls = 60:70;
%scls = 50:60; % Edited 24-1-13 - Face

for i = 1:numel(scls)
    
    
    p = m1(classnm,datafile,wav,scls(i),ts);
    
    p1(i) = p(2); % Starting Points
    p2(i) = p(1); % Ending Points
    
end

%mx1 = max(p1); mn1 = min(p1);
%mx2 = max(p2); mn2 = min(p2);

mdp1 = mode(p1); 
%mnp1 = mean(p1);

mdp2 = mode(p2); 
%mnp2 = mean(p2);

[mnpos mdpos rnpos mp] = teststat(datafile,scls); % Get statistics on Cone of Influence

fscl = (60+mp)-1; % Best Scale

if (mdp1 == 1 || mdp2 == 1 )
    
    points(1) = 1;
    points(2) = 1;
    
elseif(rnpos > 10)
    
    points(1) = 1;
    points(2) = 1;
    
else
    
   % disp([mdp1 mnp1 mx1 mn1])
   % disp([mdp2 mnp2 mx2 mn2])
   % disp([mnpos mdpos])
   points = m1(classnm,datafile,wav,fscl,ts);
    
end


    
    