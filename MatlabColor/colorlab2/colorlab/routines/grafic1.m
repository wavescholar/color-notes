function grafic1(x,y,xx,yy,domx,p,pchi,coef,s,fig)

% GRAFIC1 representa datos experimentales y la funcion ajustada (con JUSTA1).
%
% USO: grafic1(x_exp,y_exp,domin_x,param,p_chi2,coefcorr,'f(x)',figura)

figure(fig)

axis([min(xx) max(xx) min(yy) max(yy)])
plot(x,y,'co'),hold on

ss=['y(p)=',s,'   '];
for i=1:length(p)
    si=['x(',int2str(i),')=',num2str(p(i)),' '];
    ss=[ss,si]; 
end

plot(xx,yy,'b-'),xlabel(['P(Chi^2 > error)=',num2str(pchi),'       Correl.Coef.=',num2str(coef),' ']),title(ss)

hold off  









