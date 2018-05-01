function [ATD1,ATD2]=con2atd(LMS,modelo,adap)

% CON2ATD computes the responses of the first and second opponent stages of 
% the specified colour vision model from the cone responses LMS, as obtained
% by XYZ2CON, under certain adaptation conditions. 
%
% SYNTAX
% ----------------------------------------------------------------------------
% [ATD1,ATD2]=CON2ATD(LMS,MODEL,ADAP)
%
% LMS = Cone responses. Colour format.
%
% MODEL = Integer (1-13) describing the model.
% 
%     MODEL=1:3 and 12 do not have opponent stages.
%     MODEL=4 Jameson and Hurvich (1957)
%             One opponent linear stage with adaptation matrix.
%             At threshold, ADAP=EYE(3). This is the default value.
%     MODEL=5 Ingling and Tsou (1977)
%             One opponent linear stage, with different matrixes for
%             threshold (ADAP=1) and suprathreshold (ADAP=2) conditions.
%             By default, ADAP=2;
%     MODEL=6 Boynton
%             One opponent linear stage, without adaptation. 
%     MODEL=7 Guth (1980) 
%             One opponent linear stage with adaptation matrix.
%             At threshold, ADAP=EYE(3). This is the default value.
%     MODEL=8 Guth (1990)  Two opponent non-linear stages. The adaptation
%             mechanism is already included in the model. The same happens
%             with models 9-11.
%     MODEL=9 Guth (1993)  Two opponent non-linear stages. 
%     MODEL=10 Guth (1994) Two opponent non-linear stages. 
%     MODEL=11 Guth (1995) Two opponent non-linear stages. 
%     MODEL=13 DKL  
%              Opponent modulation space. LMS must be increments on a background
%              with tristimulus values XYZB. ADAP=XYZB;
%     MODEL=14 De Valois & De Valois (1992)
%              Two-opponent stage model
%
% 
% ADAP = In models 4 and 7, ADAP is a 3x3 matrix escaling the ATD responses.
%        In model 5, is a scalar, and in model 13 a 1x3 vector with the white
%        tristimulus values. When this parameter is not necessary or when the 
%        default parameters are valid, use [ATD1,ATD2]=CON2ATD(LMS,MODEL). 
%
% ATD1 and ATD2 = First and second opponent stage descriptors of the stimuli.
%                 With one-stage models, use ATD1=CON2ATD(...).
%
% REQUIRED FUNCTIONS
% ----------------------------------------------------------------------------
% COMPCOP
%
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% XYZ2CON, CON2XYZ, ATD2CON, XYZ2ATD and ATD2XYZ.
%
%Function used by XYZ2ATD.

if modelo<4
   disp('The model specified does not have opponent stages');
else
lms=LMS';
fs2ss=eye(3);
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
   lmsf=xyz2con(adap,6);
   con2fs=[1 1 0; 1 -lmsf(1)/lmsf(2) 0; -1 -1 (lmsf(1)+lmsf(2))/lmsf(3)];
elseif modelo==7
	con2fs=[0.5967 0.3654 0; 0.9553 -1.2836 0; -0.0248 0 0.0483];
	con2fs=adap*con2fs;
elseif modelo==8
	con2fs=[0.4200 0.3108 0; 0.8845 -0.7258 0; -0.0770 0.0130 0.091];
	fs2ss=[0.1 0 0; 0 0.388 1; 0 0 1];
elseif modelo==9
	con2fs=[3.57 2.64 0; 7.24 -6.21 0; -0.71 0.085 1.04];
	fs2ss=[0.09 0 0; 0 0.43 0.76; 0 0 1];
elseif modelo==10
	con2fs=[3.57 2.64 0; 7.24 -6.21 0; -0.71 0.085 0.32];
	fs2ss=[0.09 0 0; 0 0.43 0.76; 0 0 1];
elseif modelo==11
	con2fs=[3.57 2.64 0; 7.18 -6.21 0; -0.70 0.085 1];
   fs2ss=[0.09 0 0; 0 0.43 0.76; 0 0 1];
end;

atd1=con2fs*lms;
atd2=fs2ss*atd1;
atd1=compcop(atd1,1,modelo);
atd2=compcop(atd2,2,modelo);
ATD1=atd1';
ATD2=atd2';
end
	

                       