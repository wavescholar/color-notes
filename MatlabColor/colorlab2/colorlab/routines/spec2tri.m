function [T,R]=spec2tri(f_igual,paso,R,S,Y,utri)

% SPEC2TRI Tristimulus vectors from chromatic stimuli.
%
% SPEC2TRI computes the N tristimulus vectors (color-like variable) 
% from N chromatic stimuli (spectral-like variable).
%
% The N chromatic stimuli can be described in three different ways
% (options):
%
%  1. With N spectral radiances [in W/(m2*str)]. 
%
%  2. With N reflectances/transmitances and some spectral 
%     illuminant in absolute units [in W/(m2*str)].
%
%  3. With N reflectances/transmitances, some relative iluminant and
%     the desired luminance for this illuminant.
%
% Option 1 requires the color matching functions, T_l, and the palette of radiances R.
% Option 2 requires the color matching functions, T_l, a palette of reflectances R, and 
%          some illuminant S.
% Option 3 requires the color matching functions, T_l, a the palette of reflectances R,
%          the illuminant S, the desired luminance Y, and the trichromatic units, Yw.
%
% SPEC2TRI returns a color-like variable, T, and a spectral-like variable, RR, with
% the tristimulus values and the radiances of the input stimuli.
% The rows of T correspond to the columns of RR and R.
% 
% SYNTAX
% --------------------------------------------------------------------------------------
%
% [T,RR]=spec2tri(T_l,D_lambda,R,S,Y,Yw);
%
% T_l      = Color Matching Funfctions.
% 
% D_lambda = Wavelength step used in the spectrum interpolation for tristimulus 
%            vector computation.
%            Note that (FORTUNATELY!) the sampling of the input color matching 
%            functions, reflectances and illuminant do not have to be the same.
%            (You dont have to care about that: SPEC2TRI resamples for you).
% 
% R        = Radiances (option 1) or reflectances/transmitances (option 2,3)
% 
% S        = Illuminant (options 2,3). 
%
% Y        = Required luminance (option 3).
%
% Yw       = Trichromatic units (option 3).  
% 



%Option
if nargin==3
   opt=1;
elseif nargin==4
   opt=2;
elseif nargin>4
   opt=3;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         							%
% Interpolacion de las funciones de igualacion del color a P nm %  
%								%	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xm=mini(f_igual(:,1));
xM=maxi(f_igual(:,1));

xx=xm:paso:xM;

ff_igual(:,1)=xx';
ff_igual(:,2)=interp1(f_igual(:,1),f_igual(:,2),xx','linear');
ff_igual(:,3)=interp1(f_igual(:,1),f_igual(:,3),xx','linear');
ff_igual(:,4)=interp1(f_igual(:,1),f_igual(:,4),xx','linear');

f_igual=ff_igual;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         						   %
% Interpolacion de las reflectancias (o radiancias) a P nm % 
% (en el rango de las funciones de igualacion)             %  
%							   %	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xmr=mini(R(:,1));
xMr=maxi(R(:,1));

s=size(R);

if (xmr>xm)&(xMr<xM)
   RR=zeros(s(1)+2,s(2));
   RR=[xm R(1,2:s(2));R;xM R(s(1),2:s(2))];
   R=zeros(length(xx),s(2));
   R(:,1)=xx';
   if s(2)>2
      h = waitbar(0,'Spectrum Interpolation...');
      for i=2:s(2),
          waitbar((i*100/(s(2)-1))/100) 
          R(:,i)=interp1(RR(:,1),RR(:,i),xx');
      end
      close(h)
   else
       R(:,2)=interp1(RR(:,1),RR(:,2),xx');
   end
   clear RR
elseif (xmr==xm)&(xMr==xM)
   RR=zeros(length(xx),s(2));
   RR(:,1)=xx';
   if s(2)>2
      h = waitbar(0,'Spectrum Interpolation...');
      for i=2:s(2),
          waitbar((i*100/(s(2)-1))/100) 
          RR(:,i)=interp1(R(:,1),R(:,i),xx');
      end
      close(h)
   else
       RR(:,2)=interp1(R(:,1),R(:,2),xx');
   end
   R=RR;
   clear RR
elseif (xmr>xm)&(xMr>=xM)
   RR=zeros(s(1)+1,s(2));
   RR=[xm R(1,2:s(2));R];
   R=zeros(length(xx),s(2));
   R(:,1)=xx';
   if s(2)>2
      h = waitbar(0,'Spectrum Interpolation...');
      for i=2:s(2),
          waitbar((i*100/(s(2)-1))/100) 
          R(:,i)=interp1(RR(:,1),RR(:,i),xx');
      end
      close(h)
   else
      R(:,2)=interp1(RR(:,1),RR(:,2),xx');
   end
   clear RR
elseif (xmr==xm)&(xMr>=xM)
   RR=zeros(length(xx),s(2));
   RR(:,1)=xx';
   if s(2)>2
      h = waitbar(0,'Spectrum Interpolation...');
      for i=2:s(2),
          waitbar((i*100/(s(2)-1))/100) 
          RR(:,i)=interp1(R(:,1),R(:,i),xx');
      end
      close(h)
   else
      RR(:,2)=interp1(R(:,1),R(:,2),xx');
   end
   R=RR;
   clear RR
elseif (xmr<=xm)&(xMr<xM)
   RR=zeros(s(1)+1,s(2));
   RR=[R;xM R(s(1),2:s(2))];
   R=zeros(length(xx),s(2));
   R(:,1)=xx';
   if s(2)>2
      h = waitbar(0,'Spectrum Interpolation...');
      for i=2:s(2),
          waitbar((i*100/(s(2)-1))/100) 
          R(:,i)=interp1(RR(:,1),RR(:,i),xx');
      end
      close(h)
   else
      R(:,2)=interp1(RR(:,1),RR(:,2),xx');
   end
   clear RR
elseif (xmr<=xm)&(xMr==xM)
   RR=zeros(length(xx),s(2));
   RR(:,1)=xx';
   if s(2)>2
      h = waitbar(0,'Spectrum Interpolation...');
      for i=2:s(2),
          waitbar((i*100/(s(2)-1))/100) 
          RR(:,i)=interp1(R(:,1),R(:,i),xx');
      end
      close(h)
   else
       RR(:,2)=interp1(R(:,1),R(:,2),xx');
   end
   R=RR;
   clear RR
else
   RR=zeros(length(xx),s(2));
   RR(:,1)=xx';
   if s(2)>2
      h = waitbar(0,'Spectrum Interpolation...');
      for i=2:s(2),
          waitbar((i*100/(s(2)-1))/100) 
          RR(:,i)=interp1(R(:,1),R(:,i),xx');
      end
      close(h)
   else
       RR(:,2)=interp1(R(:,1),R(:,2),xx');
   end
   R=RR;
   clear RR
end

if opt>1

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %         				 	                       		    %
   % Interpolacion del iluminante a P nm en el rango de las funciones de igualacion %  
   %							                            %	
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   iluminan=S;

   xmr=mini(iluminan(:,1));
   xMr=maxi(iluminan(:,1));
   l=length(iluminan(:,1));

   if (xmr>xm)&(xMr<xM)
      iluminan=[xm iluminan(1,2);iluminan;xM iluminan(l,2)];
      iluminan=[xx' interp1(iluminan(:,1),iluminan(:,2),xx')];
   elseif (xmr==xm)&(xMr==xM)
      iluminan=[xx' interp1(iluminan(:,1),iluminan(:,2),xx')];
   elseif (xmr>xm)&(xMr>=xM)
      iluminan=[xm iluminan(1,2);iluminan];
      re=[xx' interp1(iluminan(:,1),iluminan(:,2),xx')];
      iluminan=re; 
   elseif (xmr==xm)&(xMr>=xM)
      re=[xx' interp1(iluminan(:,1),iluminan(:,2),xx')];
      iluminan=re;
   elseif (xmr<=xm)&(xMr<xM)
      iluminan=[iluminan;xM iluminan(l,2)];
      re=[xx' interp1(iluminan(:,1),iluminan(:,2),xx')];
      iluminan=re; 
   elseif (xmr<=xm)&(xMr==xM)
      re=[xx' interp1(iluminan(:,1),iluminan(:,2),xx')];
      iluminan=re;
   else
      re=[xx' interp1(iluminan(:,1),iluminan(:,2),xx')];
      iluminan=re;
   end
   S=iluminan;
   clear iluminan re

   if opt>2
      
%      X=[0.0037 0.3230 0.2720;0.1201 0.7932 0.0572;0.4487 0.9949 0.0087];
%      C1=[f_igual(find(f_igual(:,1)==500),2:4);f_igual(find(f_igual(:,1)==525),2:4);f_igual(find(f_igual(:,1)==550),2:4)];
%      A1=inv(C1)*X1(:,1); 
%      A2=inv(C1)*X1(:,2);
%      A3=inv(C1)*X1(:,3);
%      M1X=[A1';A2';A3'];
%      utri=M1X(2,:);

      VV=utri(1)*f_igual(:,2)+utri(2)*f_igual(:,3)+utri(3)*f_igual(:,4);
                
      Yi=683*(S(:,2)'*VV*paso);
      fac=Y/Yi;

      S(:,2)=fac*S(:,2);
   end
 
   for i=2:s(2)
       R(:,i)=S(:,2).*R(:,i);
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         		                %
% Y por fin la integracion...  %  
%			                      %	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

T=(f_igual(:,2:4))'*R(:,2:s(2))*paso/(1/683);
T=T';
