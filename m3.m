%% ERP Identification Pipeline - N170 Identification
% Module - 3 - Segmentation
% Arun Kumar A
% Santhom Computing, Dept. Of Physics, St Thomas College,Kozhencherry
% aka.bhagya@gmail.com
% 10-12-12


function [segpnts] = m3(datafile,points,ts)
% Input arguments are points identified by wavelet coefficients
% ,directory name and channel number

%% Initializations

% Create filter object

% Low pass Filter with cutoff at 65Hz ( Decided from power spectra of data)
% Stop band Attenutaion at 25 Hz
% Filter order N = Fs/(Cutoff - Stop band)  - Kaiser et.al 

ctf =65; % Cut off Frequency
stpbnd = 25; % Stop band
fs = (1/ts)*1000; % Sampling freqncy

N = round(fs/(ctf-stpbnd));

fspec= fdesign.lowpass('N,Fc,Ap,Ast',N,ctf,1,stpbnd,fs);
fobj=design(fspec,'fir');


%% Load Data

data_vect=datafile;
    
t1 = points(2);   % Start point
t2 = points(1);   % End point 
    

% Point Check Correction
if(t1 ~=1 && t2 ~=1 )
        
   temp1=t1;
        
   idx =t1:t2;  % Dummy index vector
        
            
%%                             Complex Identification
%                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  data = fobj.filter(data_vect(t1:t2));
  
%% Find N170 Dip
 
  [mn int1] =min(data);   

  in1=idx(int1);

%% Find P1


 int2=1;
 flag1=0;

 while(flag1==0)
             
      if (data_vect(in1-int2) > data_vect((in1-int2)-1) )
                 
          flag1= 1;
                 
      else
                  int2=int2+1;
                  if ( (int2-in1)-1 < 0)
                      flag1=1;
                      int2 = int2-1;
                  end
                      
                  
      end
                  

 end

 
 in2=in1-int2;

 mx1=data_vect(in2);

%% Find P2

int3=1;
flag2=0;

while(flag2==0)
             
      if (data_vect(in1+int3) < data_vect((in1+int3)-1) )
                 
         flag2= 1;
                 
      else
          int3=int3+1;
          
          if ( (int3+in1) > length(data_vect))
              flag2=1;
              int3 = int3-1;
          end
          
          
      end
                     
 end
             



in3 =in1+int3;
         

 mx2=data_vect(in3);
         
        if ((in3-in2) <= 12/ts)
                          
             segpnts(2) = 1;   %% No Detection Values
             segpnts(1) = 1;
         
        else
             
             segpnts(2) = in2-(80/ts); % Calibrated Values
             segpnts(1) = in3;
             
         end
         
 else
        
  segpnts(2) = 1;   %% No Detection Values
  segpnts(1) = 1;
        
end
    







