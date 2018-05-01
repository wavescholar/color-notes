function [T]=val2tri(niv,yw,coco,a,g);

%  VAL2TRI computes tristimulus vectors from MATLAB digital values 
%  
%  VAL2TRI computes T taking into accout the CRT calibration data 
%  (see CALIBRAT.M and TRI2VAL.M) 
% 
%  SYNTAX
%  -------------------------------------------------------------------------------
%
%  T=val2tri(n,Yw,tm,a,g); 
%
%  INPUT Variables
%  
%  n   = Input color-like variable (N*3 variable) with N colors (digital values).
%        
%  Yw  = Trichromatic units
%  
%  tm  = 7*M matrix that contains the chromaticities of the R, G and B guns for 
%        M calibration points of the digital value (see CALIBRAT.M).
%  
%  a   = 1*3 vector including the constants a_i of the gamma relation for each gun.
%        (see CALIBRAT.M)
%  
%  g   = 1*3 vector including the constants g_i of the gamma relation for each gun.
%        (see CALIBRAT.M)
%  
%
%  OUTPUT Variables
%
%  T   = Output color-like variable (N*3 variable) with N colors (tristimulus vectors).
%  
%  
%  REQUIRED FUNCTIONS
%  ---------------------------------------------------------------------------------
%  niv2coor.m   ganadora.m
%


l=size(niv);
l=l(1);
a=a';
g=g';

T=zeros(l,3);
for i=1:l
    nn=niv(i,:)';

    cp=niv2coor(nn,coco);
    t3=1-cp(:,1)-cp(:,2);
    cp=[cp t3];
    d1=cp(1,:)*yw';
    d2=cp(2,:)*yw';
    d3=cp(3,:)*yw';

    M=[cp(:,1)'./[d1 d2 d3];cp(:,2)'./[d1 d2 d3];cp(:,3)'./[d1 d2 d3]];

    Y=a.*(nn).^g;
    TT=M*Y;
    T(i,:)=TT';
end