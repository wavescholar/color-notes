function LMS=atdf2con(ATD1,modelo,adap)

% ATDF2CON computes the gain-controlled cone responses from the compressed 
% first-stage ATD responses of MODEL, under the adaptation conditions given
% by ADAP. See CON2ATD for details.
%
% SYNTAX
% ----------------------------------------------------------------------------
% LMS=ATDF2CON(ATD1,MODEL,ADAP)
%
% ATD1 =  Compressed first-stage responses. For N colours, this is a Nx3 matrix.
%        
% MODEL = 1-13. See XYZ2ATD for details.
%
% ADAP  = 3x3 or 3x1 matrix with the adaptation conditions. See XYZ2ATD for details.
%
% LMS   = Cone responses. If the model has non-linearities, these are included.
%         For N colours, this is a Nx3 matrix.
%         
%
% REQUIRED FUNCTIONS
% ----------------------------------------------------------------------------
% INCOMCOP
%
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% XYZ2ATD, ATD2XYZ, XYZ2CON, CON2ATD, ATD1ATD2, ATDF2CON, CON2XYZ, COMPCOP,
% GANCON, INGANCON, XYZ2XYZN and XYZN2XYZ.
%
%Function used by XYZ2ATD.

atd1=icompcop(ATD1,1,modelo)';
if modelo<4
   disp('The model specified does not have opponent stages');
else
if nargin==2 | isempty(adap)
 adap=eye(3);
 if modelo==5
    adap=2;
 end
end
if modelo==4
   con2fs=adap*[1 1 1;1 -2 1;-2 1 1];
elseif modelo==5
   con2fs=[0.6 0.4 0;1.2 -1.6 0.4;0.24 0.105 -0.70]*(adap-1)+[0.6 0.4 0;1.2 -1.6 0;0.048 -0.039 -0.042]*(adap-2);
elseif modelo==6
   con2fs=[1 1 0; 1 -2 0; 1 1 -1];
elseif modelo==13
   lmsf=xyz2con(adap(1:3),6);
   con2fs=[1 1 0; 1 -lmsf(1)/lmsf(2) 0; -1 -1 (lmsf(1)+lmsf(2))/lmsf(3)];
elseif modelo==7
	con2fs=[0.5967 0.3654 0; 0.9553 -1.2836 0; -0.0248 0 0.0483];
	con2fs=adap*con2fs;
elseif modelo==8
	con2fs=[0.4200 0.3108 0; 0.8845 -0.7258 0; -0.0770 0.0130 0.091];
elseif modelo==9
	con2fs=[3.57 2.64 0; 7.24 -6.21 0; -0.71 0.085 1.04];
elseif modelo==10
	con2fs=[3.57 2.64 0; 7.24 -6.21 0; -0.71 0.085 0.32];
elseif modelo==11
	con2fs=[3.57 2.64 0; 7.18 -6.21 0; -0.70 0.085 1];
end;

lms=inv(con2fs)*atd1;
             
LMS=lms';
end
