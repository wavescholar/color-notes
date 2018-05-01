function [atd1,atd2]=xyz2atda(XYZ,modelo,XYZa,Ma,pesos,modos,sigma,Mc,Mo1,Mo2)

% XYZ2ATDa modifies the ATD opponent responses given by a model into the responses
% of a subject with a chromatic defect.
%
% SYNTAX
% ----------------------------------------------------------------------------
% [ATD1,ATD2]=xyz2atda(XYZ,model,XYZB,adap,weights,mode,sigma,Mc,Mo1,Mo2)
%
% XYZ   = Tristimulus values of the test stimuli. The colour observer may be the CIE-1931
%         standard observer, the observer modified by Judd or by Judd and Vos, depending
%         on the model.
%         For N stimuli, this is a Nx3 matrix.
%
% model = Integer (1-14) identifying the model. A brief description of each model and
%         the necessary parameters can be seen below.
%
% XYZB  = Background stimulus (3x1)
%
% adap  = 3x3 or 3x1 matrix, depending on the model, including adaptation effects or
%         adaptation conditions. See below.
%
% weigths = Contributions of test stimuli and the background to the adaptation stimulus.
%           Use only with models 8-11.
%
% mode =  If ATD are increments on XYZB, mode=1. Otherwise, mode=2. 
%         Use only with models 8-11.
%
% sigma = Scalar parameter controlling the non-linearity at the cone stage. 
%         Use only with models 8-11.
%
% Mc = Matrix multiplying the cone responses of the normal model to transform them into
%      the cone responses of a subject with a chromatic defect. For instance, protanopes
%      are described by Mc=[0 0 0;0 1 0;0 0 1], deuteranopes by Mc=[1 0 0;0 0 0;0 0 1]
%      and tritanopes by Mc=[1 0 0;0 1 0;0 0 0].
%
% Mo1 = Matrix multiplying the first-stage ATD responses of the normal model to transform
%       them into the responses of a subject with a chromatic defect. For instance,
%       in red-green defects (protan and deutan), Mo1=[1 0 0;0 0 0;0 0 1] and in blue-yellow
%       defects Mo1=[1 0 0;0 1 0;0 0 0].
%
% Mo2 = Matrix multiplying the second-stage ATD responses of the normal model to transform
%       them into the responses of a subject with a chromatic defect. For instance,
%       in red-green defects (protan and deutan), Mo2=[1 0 0;0 0 0;0 0 1] and in blue-yellow
%       defects Mo2=[1 0 0;0 1 0;0 0 0].
%
% ATD1, ATD2 =   Responses of the achromatic (A), red-green (T) and blue-yellow 
%                (D) mechanism to the test stimuli at the firs and second opponent stages,
%                respectively.
%                For N stimuli, these are Nx3 matrixes.
%
% COLORLAB includes a set of classic models: cone spaces (models 1-3 and 12), first-stage
% linear models (4-7), opponent modulation model (13) and non-linear two-opponent stages
% models (8-11). 
%
% In all the cone-spaces considered, LMS is computed as a linear transform
% of XYZ. With these models, use CON2XYZ. 
%
% The first stage models need at most the information about the background or the
% adaptation matrix, so the function may be used as XYZ=atd2xyz(ATD,1,model,[],adap)
% (models 4, 5 and 7), as XYZ=ATD2XYZ(ATD,1,model) (model 6) or
% ATD=xyz2atd(XYZ,1,model,xyzb)(model 13).
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
%        At threshold, ADAP=EYE(3). This is the default value.
%        XYZ must be computed with the CIE-1931 colorimetric observer.
% MODEL=5 Ingling and Tsou (1977)
%        One opponent linear stage, with different matrixes for
%        threshold (ADAP=1) and suprathreshold (ADAP=2) conditions.
%        By default, ADAP=2;
% MODEL=6 Boynton (L(498)+M(498)=S(498)) (1986)
%        One opponent linear stage, without adaptation. 
% MODEL=7 Guth (1980) (L, M and S normalized to one)
%        One opponent linear stage with adaptation matrix.
%        At threshold, ADAPTATION_MATRIX=EYE(3). This is the default value.
% MODEL=8 Guth (1990)  XYZ is normalized so that Y=0.0015 equals 100 Td
%                     Smith and Pokorny fundamentals, normalized to one
%                     L:M:S   0.66:1:0.55
%                     Cone gain-control:
%                      XYZB, WEIGHT, MODE and SIGMA are the parameters of the
%                      gain-control acting on the cone-stage of the model.
%                      XYZB represents the background or the adapting stimulus. 
% 	                    If MODE=1, XYZ are increments on background XYZB
%                      If MODE=2, XYZ are absolute values and XYZB is either the
%                      adapting stimulus or the background.
%                      Both the test and the background may contribute to the adapting
%                      stimulus. This is controlled by WEGHTS:
%                          WEIGHTS=[Test contribution, Background contribution]
%                          These values sum to one. In the different updates of the
%                          model, they may take any value.
%                      The meaning of XYZB, MODE and WEIGHT in models 8-11 
%                      is the same.
%                      Defaults: XYZBACKGROUND=[0 0 0], MODE=2, WEIGHT=[1 0]. These values
%                      apply also to models 9-11.
%                      Two opponent non-linear stages. The adaptation mechanism is already
%                      included in the model. The same happens with models 9-11.
% MODEL=9 Guth (1993): Guth90 modified.
%                     XYZ are transformed to trolands.
%                     Smith and Pokorny fundamentals, normalized to one
%                     L:M:S   0.66:1:0.45
%                     Gain-control
%                     LMS'=LMST*sigma/(sigma+LMST)
%                     SIGMA=400 except to compute MacAdam's ellipses (SIGMA=220).
%                     By default, SIGMA=400.
% MODEL=10 Guth (1994):Guth93 modified.
%                     XYZ are transformed to trolands.
%                     Smith and Pokorny fundamentals, normalized to one
%                     L:M:S   0.66:1:3
%                     Gain-control
%                     LMS'=LMST*sigma/(sigma+LMST)
%                     SIGMA=400 except to compute MacAdam's ellipses (SIGMA=220).
%                     By default, SIGMA=400.
% MODEL=11 Guth (1995):Guth94 modified.
%                     XYZ are transformed to trolands.
%                     Smith and Pokorny fundamentals, normalized to one
%                     L:M:S   0.66:1:0.43
%                     Gain-control
%                     LMS'=LMST*sigma/(sigma+LMST)
%                     SIGMA=300 except to compute MacAdam's ellipses (SIGMA=220).
%                     By default, SIGMA=300.
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
% For instance, [ATD1,ATD2]=xyz2atd(XYZ,11,XYZB,[],weights,mode) uses the default
% value of SIGMA in Guth95 (300), and indicates that ADAP is not used in this
% model. [ATD1,ATD2]=xyz2atd(XYZ,11) would set all the parameters to their default values.
%
% With one-opponent stage models, use ATD1=xyz2atd(...).
%
% REQUIRED FUNCTIONS
% ----------------------------------------------------------------------------
% xyz2con, con2atd, gancon, compcop, xyz2xyzn
%
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% xyz2atd, atd2xyz, atd2perc, perc2atd, atdf2con, con2xyz, incomcop, ingancon,
% and xyzn2xyz.
%
if nargin==8
   Mo1=eye(3);
   Mo2=eye(3);
elseif nargin==9
   Mo2=eye(3);
end
if modelo==13 modelo=6;end
if modelo<4
   disp('This model does not have opponent stages');
else
   LMS=xyz2con(XYZ,modelo,XYZa,pesos,modos,sigma);
   LMS=(Mc*LMS')';
   [atd1,atd2]=con2atd(LMS,modelo,Ma);
   atd1=(Mo1*atd1')';
   atd2=atd1atd2(atd1,1,modelo);
   atd2=(Mo2*atd2')';
end



