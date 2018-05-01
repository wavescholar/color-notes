
function XYZ=con2xyz(LMS,modelo,XYZf,pesos,modo,sigma)


% CON2XYZ computes the XYZ tristimulus values of a set of stimuli from
% the cone responses in a cone-space or in a colour-vision model.
%
% SYNTAX
% ----------------------------------------------------------------------------
% XYZ=CON2XYZ(LMS,MODEL,XYZB,WEIGHT,MODE,SIGMA)
%
% LMS = Conse responses. Colour format.
%
% MODEL = Integer (1-13) identifying the model. A brief description of each model and
%         the necessary parameters can be seen below.
%
% XYZB  = Background stimulus (3x1)
%
% ADAP  = 3x3 or 3x1 matrix, depending on the model, including adaptation effects or
%         adaptation conditions. See below.
%
% WEIGTHS = Contributions of test stimuli and the background to the adaptation stimulus.
%           Use only with models 8-11.
%
% MODE =  If ATD are increments on XYZB, mode=1. Otherwise, mode=2. 
%         Use only with models 8-11.
%
% SIGMA = Scalar parameter controlling the non-linearity at the cone stage. 
%         Use only with models 8-11.
%
% XYZ   = Output tristimulus values. The tristimulus space is either CIE-1931
%         or this space as modified by Judd or by Judd and Vos. See below for details.
%
% FUNDAMENTALS AND MODELS
%         MODEL=1 Vos and Walraven's fundamentals (Y=L+M+S)
%                 XYZ are computed with the CIE-1931 observer modified
%                 by Judd (1951).
%         MODEL=2 Wyszecki and Stiles's fundamentals (L(475.5)+M(475.5)=16S(475.5))
%                 XYZ are computed with the CIE-1931 observer modified
%                 by Judd (1951).
%         MODEL=3 MacLeod-Boynton's fundamentals (L(400)+M(400)=S(400))
%                 XYZ are computed with the CIE-1931 observer modified by Vos (1978).
%         MODEL=4 Jameson and Hurvich (1957)
%                 XYZ are described with the CIE-1931 observer.
%         MODEL=5 Ingling and Tsou (1977)
%         MODEL=6 Boynton (L(498)+M(498)=S(498)) (1986)
%         MODEL=7 Guth (1980) (L, M and S normalized to one)
%         MODEL=8 Guth (1990)  XYZ is normalized so that Y=0.0015 equals 100 Td
%                     Smith and Pokorny fundamentals, normalized to one
%                     L:M:S   0.66:1:0.55
%                     Cone gain-control:
%                      XYZB represents the background or the adapting stimulus. 
% 	                    If MODE=1, XYZT is an increment on background XYZB
%                      If MODE=2, XYZT are absolute values and XYZB is either the
%                      adapting stimulus or the background.
%                      Both the test and the background may contribute to the adapting
%                      stimulus. This is controlled by WEGHT:
%                          WEIGHT=[Test contribution, Background contribution]
%                          These values sum to one. In the different updates of the
%                          model, they may take any value.
%                      The meaning of XYZB, MODE and WEIGHT in models 8-11 is the same.
%                      Defaults: XYZB=[0 0 0], MODE=2, WEIGHT=[1 0]. These values
%                      apply also to models 9-11.
%         MODEL=9 Guth (1993): XYZ are transformed to trolands.
%                     Smith and Pokorny fundamentals, normalized to one
%                     L:M:S   0.66:1:0.45
%                     Gain-control
%                     LMS'=LMST*sigma/(sigma+LMST)
%                     SIGMA=400 except to compute MacAdam's ellipses (SIGMA=220).
%                     By default, SIGMA=400.
%         MODEL=10 Guth (1994):XYZ are transformed to trolands.
%                     Smith and Pokorny fundamentals, normalized to one
%                     L:M:S   0.66:1:3
%                     Gain-control
%                     LMS'=LMST*sigma/(sigma+LMST)
%                     SIGMA=400 except to compute MacAdam's ellipses (SIGMA=220).
%                     By default, SIGMA=400.
%         MODEL=11 Guth (1995):XYZ are transformed to trolands.
%                     Smith and Pokorny fundamentals, normalized to one
%                     L:M:S   0.66:1:0.43
%                     Gain-control
%                     LMS'=LMST*sigma/(sigma+LMST)
%                     SIGMA=300 except to compute MacAdam's ellipses (SIGMA=220).
%                     By default, SIGMA=300.
%         MODEL=12 Stockman and Sharpe's fundamentals (2000)
%
% With CON2XYZ(LMS,MODEL), the rest of the parameters are set to zero
% in MODEL<=7 and MODEL=12 and to the default parameters in the rest.
%
% Except for MODEL=1 and MODEL=12, the Smith and Pokorny fundamentals,
% with different normalization conditions, are used.
%
% REQUIRED FUNCTIONS
% ----------------------------------------------------------------------------
% XYZ2XYZN, INGANCON, XYZN2XYZ, CAMBIAL, XYZTD2L
%
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% XYZ2CON, XYZ2ATD, ATD2XYZ, ATD2PERC, PERC2ATD, CON2ATD, ATDF2CON, ATD1ATD2 
%
%Function used by ATD2XYZ.

if modelo==13 modelo=6;end
%Defaults
if nargin<6
 if modelo<=7 | modelo==12
   pesos=0;
   XYZf=0;
   modo=0;
   sigma=0;
 else
    if nargin<=5
     if modelo==9 | modelo==10
       sigma=400;
     elseif modelo==11
        sigma=300;
     elseif modelo==8
        sigma=0;
     end
    end
    if nargin<=4
       modo=2;
    end
    if nargin<=3
       pesos=[1 0];
    end
    if nargin==2
		 XYZf=0;  
    end
  end
end
if isempty(pesos)
   pesos=0;
end
if isempty(XYZf)
   XYZf=0;
end
if isempty(sigma)
   sigma=0;
end
if isempty(modo)
   modo=2;
end
if pesos==0
  if modelo<=7 | modelo==12 
     pesos=[0 0];
  else
     pesos=[1 0];
  end
end
if XYZf==0
   XYZf=zeros(1,3);
end
if sigma==0
   if modelo==9 | modelo==10
      sigma=400;
   elseif modelo==11
      sigma=300;
   end
end
if modo==0
   modo=2;
end


num=size(LMS);
if modelo<=7 | modelo==12
   noise=0;
end
if modelo==1
   t2c=[0.15516 0.54308 -0.03702; -0.15516 0.45692 0.02969; 0 0 0.00732];
elseif modelo==2
   t2c=[0.15514 0.54312 -0.03286; -0.15514 0.45684 0.03286; 0 0 0.00801];
elseif modelo==3
   t2c=[0.15516 0.54308 -0.032868; -0.15516 0.45692 0.032868; 0 0 0.01608];
elseif modelo==4
   t2c=[0 6.5341 0.1336;-0.3368 7.0009 0.0020;0.3329 6.4671 -0.1347];   
elseif modelo==5
   t2c=[0.2434 0.8524 -0.0516;-0.3954 1.1642 0.0837;0 0 0.6225];
elseif modelo==6
   t2c=[0.15516 0.54308 -0.032868; -0.15516 0.45692 0.032868; 0 0 1.0066];
elseif modelo==7
	t2c=[0.2435 0.8524 -0.0516; -0.3954 1.1642 0.0837; 0 0 0.6225];
elseif modelo==8
	t2c=[0.2435 0.8524 -0.0516; -0.3954 1.1642 0.0837; 0 0 0.6225];
   t2c=[0.66 0 0; 0 1 0; 0 0 0.55]*t2c;
  	noise=0.00004;
elseif modelo==9
	t2c=[0.2435 0.8524 -0.0516; -0.3954 1.1642 0.0837; 0 0 0.6225];
   t2c=[0.66 0 0; 0 1 0; 0 0 0.45]*t2c;
   noise=[0.002 0.003 0.00135]'*ones(1,num(1));
elseif modelo==10
	t2c=[0.2435 0.8524 -0.0516; -0.3954 1.1642 0.0837; 0 0 0.6225];
   t2c=[0.66 0 0; 0 1 0; 0 0 3]*t2c;
   noise=[0.002 0.003 0.00135]'*ones(1,num(1));
elseif modelo==11
	t2c=[0.2435 0.8524 -0.0516; -0.3954 1.1642 0.0837; 0 0 0.6225];
   t2c=[0.66 0 0; 0 1 0; 0 0 0.43]*t2c;
   noise=[0.024 0.036 0.31]'*ones(1,num(1));
end


%Fondo
XYZf0=XYZf;
if modelo>=8 & modelo<12 
 num=size(LMS);
 numf=size(XYZf);
 if numf(1)==1
	XYZf=XYZf(ones(num(1),1),:);
 end
 XYZf0=XYZf;
 XYZf=xyz2xyzn(XYZf,modelo);
 lmsf=(t2c*XYZf')';
else
 lmsf=[];
end
%Control de ganancia
lmsn=ingancon(LMS,lmsf,modelo,pesos,sigma);

%Ruido
lms=lmsn-noise';
if modelo>=9 & modelo<12
   lms=lms.^(1/0.7);
end
xyz=inv(t2c)*lms';
XYZ=xyz';
XYZ=xyzn2xyz(XYZ,modelo);
if modo==1
  XYZ=XYZ-XYZf0;
end