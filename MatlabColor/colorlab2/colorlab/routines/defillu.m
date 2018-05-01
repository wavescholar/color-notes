function [esp]=defillu(Y,tipo,paso,f_igual,utri,fi)

% DEFILLU graphic definition of illuminants
% 
% DEFILLU opens an interactive window where the user can
% define (draw) the relative spectral radiance. This relative
% spectrum is scaled to give the desired luminance or radiance.
%
% DEFILLU returns a spectral-like variable (wavelength-magnitude)
% in nm and W/str*m2 respectively.
% The wavelength domain will be given by the limits of the color 
% matching functions at hand.
% 
% SYNTAX:   
% --------------------------------------------------------------
%
% esp=defillu(Y,opt,lambda,T_l,Yw,fig);
%
%  Y        = Luminance (in cd/m2) or radiance (in W/str*m2) 
%             The meaning of Y (lum or rad) depends on the value
%             of 'opt'.
%
%  opt      = Selects the meaning of Y.
%             If opt==1, Y means luminance, else, Y means radiance.
%     
%  D_lambda = wavelength step (in nm) to sample the spectrum.
%  
%  T_l      = color matching functions.
%
%  Yw       = trichromatic units (in cd/m2).
%  
%  fig      = figure number
%

V=[f_igual(:,1) utri(1)*f_igual(:,2)+utri(2)*f_igual(:,3)+utri(3)*f_igual(:,4)];

xm=mini(V(:,1));
xM=maxi(V(:,1));
figure(fi),clf,axis([xm xM 0 1.3])
text(400,1.2,'Draw the relative spectral radiance using N mouse-defined points')
text(400,1.1,'Use the left button to select the spectrum. Press the right button to finish.')
xlabel('\lambda (nm)'),ylabel('Relative Spectral Radiance')

%[x,y]=ginput;

hold on
[t]=ginput(1);
plot(t(1),t(2),'r+');

cond=0;
tt=[0 0];
boton=1;
while boton<3,
      [tt(1),tt(2),boton]=ginput(1);
      if boton==1
         t=[t;tt];
         plot(tt(1),tt(2),'r+');         
      end    
end      
hold off 

l=length(t(:,1));
x=[xm;t(:,1);xM];
y=[t(1,2);t(:,2);t(l,2)];
%close(fi)
hold off
xx=xm:paso:xM;
VV=interp1(V(:,1),V(:,2),xx,'linear');
f=interp1(x,y,xx,'spline');
f=abs(f);
if tipo==1
   Yi=683*(f*VV'*paso);
else
   Yi=sum((f*paso)');
end 
fac=Y/Yi;
f=fac*f;
figure(fi),clf,plot(xx,f),axis([xm xM 0 1.1*fac]),title('Radiance:  C(\lambda)')
xlabel('\lambda (nm)'),ylabel('C(\lambda) (W/m^2*str)')
hold on
plot(x,y*fac,'r+')
hold off
esp=[xx' f'];