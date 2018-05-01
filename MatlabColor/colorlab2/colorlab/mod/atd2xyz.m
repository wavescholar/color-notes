function [XYZ]=atd2xyz(atd,etapa,modelo,XYZa,Ma,pesos,modos,sigma)
  
% ATD2XYZ computes the tristimulus values XYZ from ATD opponent responses of the
% specified STAGE of a given MODEL,in the specified observation conditions.
% ATD must include the non-linearities of the model.
%
% SYNTAX
% ----------------------------------------------------------------------------
% XYZ=atd2xyz(ATD,stage,model,XYZB,adap,weights,mode,sigma)
%
% ATD =   Responses of the achromatic (A), red-green (T) and blue-yellow (D) mechanism
%         to the test stimuli.
%         For N stimuli, ATD is a Nx3 matrix.
%         If the model has non-linearities, ATD must include them.
% stage = 1 if ATD are first opponent-stage descriptors and 2 if ATD are second opponent-
%         stage.
% model = Integer (1-14) identifying the model. A brief description of each model and
%         the necessary parameters can be seen below.
%
% XYZB  = Background stimulus (3x1)
%
% adap  = 3x3 or 3x1 matrix, depending on the model, including adaptation effects or
%         adaptation conditions. See below.
%
% weights = Contributions of test stimuli and the background to the adaptation stimulus.
%           Use only with models 8-11.
%
% mode =  If ATD are increments on XYZB, mode=1. Otherwise, mode=2. 
%         Use only with models 8-11.
%
% sigma = Scalar parameter controlling the non-linearity at the cone stage. 
%         Use only with models 8-11.
%
% XYZ   = Tristimulus values of the test stimuli. The colour observer may be the CIE-1931
%         standard observer, the observer modified by Judd or by Judd and Vos, depending
%         on the model.
%
% COLORLAB includes a set of classic models: cone spaces (models 1-3 and 12), first-stage
% linear models (4-7), opponent modulation model (13) and non-linear two-opponent stages
% models (8-11). 
%
% In all the cone-spaces considered, LMS is computed as a linear transform
% of XYZ. With these models, use CON2XYZ. 
%
% The first stage models need at most the information about the background or the
% adaptation matrix, so the function may be used as XYZ=ATD2XYZ(ATD,1,MODEL,[],ADAP)
% (models 4, 5 and 7), as XYZ=atd2xyz(ATD,1,model) (model 6) or
% ATD=atd2xyz(XYZ,1,model,XYZB)(model 13).
%
% MODEL=1 Vos and Walraven's fundamentals (Y=L+M+S)
%        Cone space. Use only with XYZ2CON and CON2XYZ
%        XYZ must be computed with the CIE-1931 observer modified by Judd (1951).
% MODEL=2 Wyszecki and Stiles's fundamentals (L(475.5)+M(475.5)=16S(475.5))
%        Cone space. Use only with XYZ2CON and CON2XYZ
%        XYZ must be computed with the CIE-1931 observer modified by Judd (1951).
% MODEL=3 MacLeod-Boynton's fundamentals (L(400)+M(400)=S(400))
%        Cone space. Use only with XYZ2CON and CON2XYZ
%        XYZ must be computed the CIE-1931 observer modified by Vos (1978).
% MODEL=4 Jameson and Hurvich (1957)
%        One opponent linear stage with adaptation matrix.
%        At threshold, adap=eye(3). This is the default value.
%        XYZ must be computed with the CIE-1931 colorimetric observer.
% MODEL=5 Ingling and Tsou (1977)
%        One opponent linear stage, with different matrixes for
%        threshold (adap=1) and suprathreshold (adap=2) conditions.
%        By default, adap=2;
% MODEL=6 Boynton (L(498)+M(498)=S(498)) (1986)
%        One opponent linear stage, without adaptation. 
% MODEL=7 Guth (1980) (L, M and S normalized to one)
%        One opponent linear stage with adaptation matrix.
%        At threshold, adap=eye(3). This is the default value.
% MODEL=8 Guth (1990)  XYZ is normalized so that Y=0.0015 equals 100 Td
%                     Smith and Pokorny fundamentals, normalized to one
%                     L:M:S   0.66:1:0.55
%                     Cone gain-control:
%                      XYZB, weights, mode and sigma are the parameters of the
%                      gain-control acting on the cone-stage of the model.
%                      XYZB represents the background or the adapting stimulus. 
% 	                    If mode=1, XYZ are increments on background XYZB
%                      If mode=2, XYZ are absolute values and XYZB is either the
%                      adapting stimulus or the background.
%                      Both the test and the background may contribute to the adapting
%                      stimulus. This is controlled by WEGHTS:
%                          weights=[Test contribution, Background contribution]
%                          These values sum to one. In the different updates of the
%                          model, they may take any value.
%                      The meaning of XYZB, MODE and WEIGHT in models 8-11 
%                      is the same.
%                      Defaults: XYZB=[0 0 0], mode=2, weights=[1 0]. These values
%                      apply also to models 9-11.
%                      Two opponent non-linear stages. The adaptation mechanism is already
%                      included in the model. The same happens with models 9-11.
% MODEL=9 Guth (1993): Guth90 modified.
%                     XYZ are transformed to trolands.
%                     Smith and Pokorny fundamentals, normalized to one
%                     L:M:S   0.66:1:0.45
%                     Gain-control
%                     LMS'=LMST*sigma/(sigma+LMST)
%                     sigma=400 except to compute MacAdam's ellipses (sigma=220).
%                     By default, sigma=400.
% MODEL=10 Guth (1994):Guth93 modified.
%                     XYZ are transformed to trolands.
%                     Smith and Pokorny fundamentals, normalized to one
%                     L:M:S   0.66:1:3
%                     Gain-control
%                     LMS'=LMST*sigma/(sigma+LMST)
%                     sigma=400 except to compute MacAdam's ellipses (sigma=220).
%                     By default, sigma=400.
% MODEL=11 Guth (1995):Guth94 modified.
%                     XYZ are transformed to trolands.
%                     Smith and Pokorny fundamentals, normalized to one
%                     L:M:S   0.66:1:0.43
%                     Gain-control
%                     LMS'=LMST*sigma/(sigma+LMST)
%                     sigma=300 except to compute MacAdam's ellipses (sigma=220).
%                     By default, sigma=300.
% MODEL=12 Stockman and Sharpe's fundamentals (2000)
%
% MODEL=13 DKL  
%         Opponent modulation space. LMS must be increments on a background with 
%         tristimulus values XYZB.  
%         The only condition on LMS is that they be the Smith-Pokorny fundamentals,
%         with Y=L+M; the scaling conditions on the S-cones is inmaterial. In this
%         function, Boynton's scaling is used.
%
% If a model does not use a given parameter, write []. To use the default values
% of a parameter, use [] if any parameter with a user-defined value comes behind, or just
% leave them out if they are the last inputs of the function.
%
% REQUIRED FUNCTIONS
% ----------------------------------------------------------------------------
% XYZ2CON, CON2ATD, ATD1ATD2, GANCON, COMPCOP, ICOMPCOP, XYZ2XYZN
%
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% XYZ2ATD, ATD2PERC, PERC2ATD, ATDF2CON, CON2XYZ, INCOMCOP, INGANCON,  and XYZN2XYZ.

if modelo<4
      disp('The model specified has not opponent stages');
else
if etapa==2
   atd=atd1atd2(atd,2,modelo);
end


param(1,:)='pesos';
param(2,:)='modos';
param(3,:)='sigma';
tristim='XYZ=con2xyz(LMS,modelo,XYZa,';
if nargin==3
 LMS=atdf2con(atd,modelo);
 XYZ=con2xyz(LMS,modelo);
elseif nargin==4 
   if modelo==13
    LMS=atdf2con(atd,modelo,XYZa);
    XYZ=con2xyz(LMS,6);
   else
    LMS=atdf2con(atd,modelo);
    XYZ=con2xyz(LMS,modelo,XYZa);
   end
elseif nargin==5
    LMS=atdf2con(atd,modelo,Ma);
    XYZ=con2xyz(LMS,modelo,XYZa);
else
   cuantosmas=nargin-5;
   if modelo==13
      LMS=atdf2con(atd,modelo,XYZa);
      modelo=6;
   else
      LMS=atdf2con(atd,modelo,Ma);
   end
   for indic=1:cuantosmas
      if indic==cuantosmas
         tristim=[tristim param(indic,:) ');'];      
      else 
         tristim=[tristim param(indic,:) ','];      
      end  
   end
   eval(tristim);
end
end




