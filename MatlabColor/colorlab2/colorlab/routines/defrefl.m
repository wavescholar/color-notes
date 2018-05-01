function [esp]=defrefl(lan,fi)

% DEFREFL graphic definition of spectral reflectances/transmitances
% 
% DEFREFL opens an interactive window where the user can
% define (draw) the spectral reflectance or transmitance.
% The reflectance (transmit.) should always be in the range [0 1].
% 
% DEFREFL returns a spectral-like variable (wavelength-magnitude).
% The reflectance (transmit.) is interpolated in steps of 1 nm for the 
% given range.
% 
% SYNTAX:   
% --------------------------------------------------------------
% 
% refl=defrefl([l_min l_max],fig);
%
%  [l_min l_max] = wavelength range (in nm) 
%  
%  fig           = figure number
%

xm=mini(lan);
xM=maxi(lan);
figure(fi),clf,axis([xm xM 0 1.3])
%text(400,1.2,'Draw the spectral reflectance (or transmitance) using N')
%text(400,1.1,'mouse-defined points. Press ENTER when finished.')
text(400,1.2,'Draw the reflectance using N mouse-defined points')
text(400,1.1,'Use the left button to select the points. Press the right button to finish.')
xlabel('\lambda (nm)'),ylabel('Reflectance/Transmitance')
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
xx=xm:xM;
f=interp1(x,y,xx','spline');
f=abs(f);
l=length(f);

f=f.*(+(f<1))+(+(f>=1)).*ones(l,1);
%close(fi)
figure(fi),clf,plot(xx,f),axis([xm xM 0 1.1]),title('Reflectance or Transmitance')
xlabel('\lambda (nm)'),ylabel(' r(\lambda) or \tau(\lambda)')
hold on
plot(x,y,'r+')
hold off
lan=xx';
esp=[xx' f];