function [pp,Mcov,pchi,coefcorr]=justa1(x0,p,s1,ver,erre,errp,pasos,t,domx,fi)


% JUSTA1 ajusta casi cualquier cosa minimizando el error cuadratico y encima lo representa.
%
% Primero utiliza AJUSTA1 para obtener los parametros optimos de la funcion que queremos ajustar,
% y luego utiliza GRAFIC1 para representar los datos experimentales y la curva ajustada.
% (Esto se utiliza cuando no conocemos las desviaciones de los datos)
% 
% [p,Mcov,P(chi>err),coefcorr]=
% justa1(p_inicial,[x;y],'f(p(1,:),x(i))',ver,toler(error),toler(parametros),
% N_pasos,paso_deriv,[xm xM],fig);

[pp,Mcov,pchi,coefcorr]=ajusta1(x0,p,s1,ver,erre,errp,pasos,t);

xe=p(1,:);
ye=p(2,:);

p=linspace(domx(1),domx(2),50*length(xe));
x=pp;
eval(['fx=',s1,';'])

grafic1(xe,ye,p,fx,domx,pp,pchi,coefcorr,s1,fi)   



