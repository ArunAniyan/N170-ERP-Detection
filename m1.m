%% ERP Identification Pipeline - N170 Identification
% Module - 1 - Detection Stage - Threshold Check 
% Arun Kumar A
% Santhom Computing, Dept. Of Physics, St Thomas College,Kozhencherry
% aka.bhagya@gmail.com
% 10-12-12
% Edited 24-1-13
% Edited 5-2-13 - Filter Cut off
function [points] = m1(classnm,datafile,wav,scl,ts)
% Input arguments are the Directory name ( which is treated as class
% labels) and channel number,scale of wavelet

%% Initializations

% Create filter object

% Low pass Filter with cutoff at 65Hz ( Decided from power spectra of data)
% Stop band Attenutaion at 25 Hz
% Filter order N = Fs/(Cutoff - Stop band)  - Kaiser et.al 

ctf =65; % Cut off Frequency ( Lowered from previous 65) 
stpbnd = 25; % Stop band
fs = (1/ts)*1000; % Sampling freqncy

N = round(fs/(ctf-stpbnd));

fspec= fdesign.lowpass('N,Fc,Ap,Ast',N,ctf,1,stpbnd,fs);
fobj=design(fspec,'fir');



%% Load file  

data_vect=datafile;
    
%% Filter Data 

data = fobj.filter(data_vect);
   
    
%% Cwt

cfs = cwt(data,scl,wav);             

%% Identify points -1

cfs_temp = cfs;

% Threshold Setting
% Threshold determined from average of threshold calculation code

if(classnm(1) =='F') 
    %thr = 1.6;
     thr =14; % Edited 24-1-13 
elseif(classnm(1) =='H') % Future Option - Not functional now
     thr = 7;
     
end


cfs_temp(cfs_temp<thr)=0; % Threshold clean

check1 =  cfs_temp(cfs_temp > 0);  % No: of points greater than 0

lc = length(check1);
   

    
if(lc >1 || (lc==1 && cfs_temp(lc))) % Only search if threshold
                                           % condition is met.   
        
        
   % A recorrection mechanism is used here. If the onset of N170
   % and offset have very large difference than required amount,
   % a false detection is reported. So as a self correction
   % the negetive coefficient value is anchored and the new
   % maximum positive coefficient is detected.
       
   [indx1 indx2] = m2_test(cfs,thr,ts);     % Run Sub Module 1 m2.m
             
   points(1) = indx1;  % Detected Indices
   points(2) = indx2;
            

        
            
        
else
        
  points(1) = 1;      % No Detection
  points(2) = 1;
    
end






