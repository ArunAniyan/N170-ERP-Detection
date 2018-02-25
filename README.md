# N170-ERP-Detection
Wavelet Based N170 ERP detection algorithm for EEG analysis


Author : Arun Kumar A

Institute : Department of Physics, St.Thomas College, Kozhencherry, Kerala, India.

Email : aka.bhagya@gmail.com

03-05-2013


File Descriptions : 

   1. detectERP.m  --> Main code
      
	  2. m1.m --> Proximity detection module 1
      
	    3. m2.m --> Proximity detection module 2
      
         4. m3.m --> Segmentation module
            
         5. m4.m --> Plot module 
            
         6. mdec.m --> Scale decision function
            
         7. teststat.m --> Scale decision function submodule
            
         8. m2_test.m --> Updated Proximity detection module 2 (Updated)
            
         9. n170sample1.csv --> Sample data 1 with N170
            
	   10. n170sample2.csv --> Sample data 2 with N170
     
      11. restsample1.csv --> Sample data 3 with no N170
     
	    12. restsample2.csv --> Sample data 4 with no N170
     
           


How to test the code
=====================
The detection pipeline is composed of 6 m-codes. The 2 stage execution (Proximity detection & Sgmentation) are put into a single code called detectERP.m so that the user need not bother about the steps.
The detectERP code accepts 3 user inputs which are data filename (a text file with single row or column vector), wavelet name and sampling frequency of the signal in Hz. The output argument is the start and end points of the N170 in data point number. 

To test the code type as shown below in the MATLAB prompt with any of the sample data.

Example: 

        detectERP('n170sample2.csv','sym5',512)

The output shows the plot with markers (*) showing the start and end of the detected ERP. The green marker points the beginning and red the end of the ERP.
The markers may be shifted in the plot due to the scaling effects of the MATLAB figure window.
The actual code had arrow markers, but has been modified as asterisk due to some unknown compatibility issue with MATLAB 2012a version. This problem is currently fixed and will be updated soon. 
