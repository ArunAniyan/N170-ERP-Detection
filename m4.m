%% ERP Identification Pipeline - N170 Identification
% Module - 4 - Plot
% Arun Kumar A
% Santhom Computing, Dept. Of Physics, St Thomas College,Kozhencherry
% aka.bhagya@gmail.com
% 10-12-12


function m4(datafile,points)

data=datafile;
l=length(data);
x=-15;
y =5;
a=16;b=479;c=974;d=150;

if (points(1) == 1 && points(2) == 1)
    
    
    plot(data);text(x,y,...
   '\color{green} \downarrow','fontsize',32,'fontweight','bold','units','data'),text(x,-(y),...
   '\color{red} \uparrow','fontsize',32,'fontweight','bold','units','data'),xlim([0 l]);  
    
else
    
    plot(data),text(points(2),max(data),...
   '\color{green} *','fontsize',30),text(points(1),min(data),...
   '\color{red} *','fontsize',30);
end

