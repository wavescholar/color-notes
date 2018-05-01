function [R,HVCh]=loadlm(cval,type)

%LOADLM loads Munsell loci of constant hue, value or chroma.
%
%USE: [R,HVCh]=LOADLM(CVAL,TYPE);
%
%    CVAL = value of the main hue (TYPE=1), secondary hue (TYPE=2),
%           value (TYPE=3), or chroma (TYPE=4) we want to load.
%           For gray samples, use LOADREFM
%    R    = reflectance matrix
%    HVCh = Munsell descriptors of the loaded samples.
% 
%
%  The gray samples are identified by a single parameter, N, describing
%  their lightness. N takes values between 0.5 and 9.5, in 0.25 steps. The
%  lower N, the darker appears the sample when seen agains the reference white.
% 
%  The coloured samples are classified according to Hue, Chroma and Value
%  (Lightness).
% 
%  The main hue, h, is a name identifying the colour as blue, green-blue,
%  green, green-yellow, yellow, yellow-red, red, red-purple, purple or
%  purple blue. In this function, h is an integer between 1 and 10 (1 for 
%  blue, 2 for green-blue, 3 for green, and so on). 
% 
%  H identifies different shades of the same hue. The number of shades for
%  each hue is not constant. Possible H values are between 1.25 and 10, in
%  1.25 steps.
% 
%  The "value", V, is a measurement of the lightness of the sample. This
%  descriptor takes integer values between 0 and 9.
% 
%  C is the chroma of the sample, a parameter measuring the colour content 
%  of the sample compared with that of the reference white in the same scene.
%  Possible chroma values are 0, 1 and even values between 2 and 16.
%
%

V=0:9;
h=1:10;
C=[0 1 2:2:16];
H=0.5:0.25:10;

if type==1
   ii=H;
   ij=V;
   ik=C;
elseif type==2
   ii=V;
   ij=C;
   ik=h;
elseif type==3
   ii=H;
   ij=C;
   ik=h;
elseif type==4
   ii=H;
   ij=V;
   ik=h;
end

mun=[];
if type<5
   for i=ii
      for j=ij
         for k=ik
             mun=[mun;i j k];        
         end
      end
   end
end

cuant=size(mun,1);
if type==1
   mun=[mun cval*ones(cuant,1)];
elseif type==2
   mun=[cval*ones(cuant,1) mun];
elseif type==3
   mun=[mun(:,1) cval*ones(cuant,1) mun(:,2:3)];
elseif type==4
   mun=[mun(:,1:2) cval*ones(cuant,1) mun(:,3)];
end
[R,HVCh]=loadrefm(mun);