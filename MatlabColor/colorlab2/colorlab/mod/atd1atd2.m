function atdb=atd1atd2(atda,etapa,modelo);

% ATD1ATD2 transforms the ATD0 of MODEL from the first to the second stages 
% or the other way round. The model non-linearities are included in the output
% stage and MUST BE INCLUDED in the input stage also.
%
% SYNTAX
% ----------------------------------------------------------------------------
% ATD=ATD1ATD2(ATD0,STAGE0,MODEL)
%
% ATD0   = ATD responses of the input stage.
%          For N stimuli, atd0 is a Nx3 matrix.
% 
% stage0 = Input stage (1 or 2)
%
% model  = Integer identifying the model (1-13). See XYZ2ATD for details.
%
% ATD    = Output ATD in the desired stage. If stage0=1, ATD are the second-stage
%          descriptors. Conversely, if stage0=2, ATD are the first-stage
%          descriptors.
%          For N colors, ATD is a Nx3 matrix.
%            
%
% REQUIRED FUNCTIONS
% ----------------------------------------------------------------------------
% COMPCOP, ICOMPCOP
%
% This function is used by ATD2XYZ.

if modelo<4
   disp('The model specified has not opponent stages');
else
if modelo<=7 | modelo==12 | modelo==13
  	M=eye(3);
elseif modelo==8
	M=[0.1 0 0; 0 0.388 1; 0 0 1];
elseif modelo>=9 & modelo<12
	M=[0.09 0 0; 0 0.43 0.76; 0 0 1];
end;

if etapa==1
   aaa=icompcop(atda,1,modelo);
   aaa=aaa';
   atdb=compcop((M*aaa)',2,modelo); 
else
   aaa=icompcop(atda,2,modelo);
   aaa=aaa';
   atdb=compcop((inv(M)*aaa)',1,modelo);
end
end
