%% ERP Identification Pipeline - N170 Identification
% Sub Module 1 of module 1 - Detection Stage - Find best coefficient pair
% Returns value to m1.m 
% Arun Kumar A
% Santhom Computing, Dept. Of Physics, St Thomas College,Kozhencherry
% aka.bhagya@gmail.com
% 10-12-12
% Edited 25-1-13 - Peak Check

function [in1 in2] = m2(coefs,thr,ts)
% coefs     : Actual wavelet coefficients
% tcoefs    : Thresholded coefficients
%% Start
coefs_temp=coefs;
l=length(coefs);
t1 = 60; % Optimal time Limit start
t2 = 88; % Optimal time Limit end

%% Threshold

coefsp = coefs_temp;     % Postive 
coefsn = coefs_temp;     % Negetive 

coefsp(coefsp<thr) = 0;

thr1= thr-0.2;

coefsn(coefsn>(-(thr1))) =0;  % Not exactly as the positive thr value, but
                                % some value less than that. 

[p1 n1] = findpeaks(coefsp);        % Positive Peaks

[p2 n2] = findpeaks(abs(coefsn));        % Negetive Peaks

%% Find Pairs

np = length(n1);  % Number of Peaks
np2 = length(n2);

% Check if there is any Null Peaks even after threshold
if (np < 1 || np2 <1)
    
    in1 = 1;
    in2 = 1;
    return;
    
end



j=1;
tpr1=zeros(1,np);
tpr2=zeros(1,np);

for i = np:-1:1
    
    tmp = abs(n1(i)-n2);
    
    tmpmin = min(tmp);
    
    tpr1(j) = n1(i);              % Positive Peak Indice of pair
    tpr2(j) = abs(n1(i)-tmpmin);       % Negetive Peak Indice of pair
    
    if (tpr2(j) == 0)
        
        tpr2(j)=1;
        
    end
    
    
    % Till here pairs are listed from end of the signal to start.
    
    j=j+1;
           
end

% Reverse the list to get in normal order

pr1_temp=wrev(tpr1);
pr2_temp=wrev(tpr2);


pr1=zeros(1,np);
pr2=zeros(1,np);


%% Remove pairs having time period out of bounds  ( 60ms > t < 88ms)

for i = 1: np
    
    if ( (pr1_temp(i) - pr2_temp(i)) >= (t1/ts) && (pr1_temp(i) - pr2_temp(i)) <= (t2/ts))
        
        pr1(i)=pr1_temp(i);
        pr2(i)=pr2_temp(i);
        
    else
        
        pr1(i) =0;
        pr2(i) =0;
    end
    
end


pr1(pr1==0)=[];
pr2(pr2==0)=[];


np = length(pr1);

if ( (length(pr2) == 0 && np == 0) )
    
    in1 =1;
    in2 =1;
    return;
    
else
    


%% Sort Pairs

for i = 1: np
    
        pd(i) = coefsp(pr1(i)) + abs(coefsn(pr2(i)));
        
    
end

[spd,pos1] = sort(pd,'descend'); % Sorted list


if (length(pos1) == 1)
    
     in1 = pr1(pos1(1));
     in2 = pr2(pos1(1));
     return;
     
elseif(isempty(pos1))
    
    in1 = 1;
    in2 = 1;
    return;
     
else
       

%% Find Time


for i=1:np
    
        tn(i) = pr1(i) - pr2(i);         % Time Difference
        
end



%% Period Distance from optimum

for i =1:np
   
    ds1(i) = abs(tn(i)-70/ts);   % [ Best optimal time 70ms ]
  
end


%% Gaussian Weight Multiplication based on time
% Best optimum time 70ms

%g1 = 1:9;
%g2 = 9:-1:1;
%g = [g1 10 g2];


g = gausswin(19,1.5)*9;  % Gaussian Weight vector
t = round((t1/ts):(t2/ts)); % Time base vector for gaussian weights

%% Ranking based on Gaussian 

td =0;


for i = 1:np

    [a b] = find(tn(i) == t);
    
    td(i) = tn(i) * g(b);   % Multiplication with Gaussian function
    
end


[sds1 pos2] = sort(td,'descend');



%% Find best


if(abs( tn(pos2(1)) - 70/ts)  < abs(tn(pos2(2))-70/ts ))
    
    if( coefs(pr1(pos1(1))) > coefs(pr1(pos1(2) )) )    % Removed pr1 and pd - Check
         
         in1 = pr1(pos1(1));
         in2 = pr2(pos1(1));
  %      disp('c1')
        
        
    else
        
         in1 = pr1(pos1(2));
         in2 = pr2(pos1(2));
  %       disp('c2')
               
     end
    
    
    
     
else
    
    if (  coefsp(pr1(pos2(1))) > coefsp(pr1(pos2(2))) )    %% Check if it has greatest coef
        
        in1 = pr1(pos1(1));
        in2 = pr2(pos1(1));
 %       disp('c3')
    
    else   
        
        in1 = pr1(pos1(2));
        in2 = pr2(pos1(2));
%        disp('c4')
    end
    
end        



    
end

end