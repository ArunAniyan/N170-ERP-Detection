% Main Module
% Arun Kumar A
% Santhom Computing, Dept. Of Physics, St Thomas College,Kozhencherry
% aka.bhagya@gmail.com
% 10-12-12

function fp = detectERP(datafile,wav,fs)
tic;
ts = round((1/fs)*1000);

data =load(datafile);

fprintf('Starting ERP detection Pipeline...................\n');
fprintf('ERP type : N170 \n');


points  = mdec(data,wav,fs); % Scale Decision and Proximity Detection
    
segpnts = m3(data,points,ts);  % Segmentation

m4(data,segpnts); % Plot

fp =[segpnts(2) segpnts(1)];

toc

disp('Completed !!')




