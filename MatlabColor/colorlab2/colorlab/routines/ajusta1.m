function [xx,V,pchi,coefcorr]=ajusta1(x0,p,s1,ver,erre,errp,pasos,t)

% AJUSTA1 ajusta los parametros p de una funcion f(x,p) para que se
% minimice la distancia cuadratica entre unos valores experimentales
% y_exp y la funcion f(x,p) cuando no se dispone de datos sobre las in-
% certidumbres en los datos de abscisas y ordenadas.
% AJUSTA1, utiliza FMINS para minimizar el error cuadratico dado por
% ERROR1
%
% AJUSTA1 da los errores de los parametros y la probabilidad de que 
% la chi cuadrado sea mayor que el error cuadratico obtenido para el 
% numero de grados de libertad utilizado. Si esta probabilidad es su-
% perior a 0.05, el ajuste es aceptable (vease Leo Cap. 4). 
%
% AJUSTA1 calcula la matriz de covarianzas de los parametros derivando
% la funcion de error.
%
% La funcion de error calculada por ERROR1 es la que hay que minimizar
% segun el metodo de maxima verosimilitud.
%
% USO: [X,M_cov,P_chi,coefcorr]=ajusta1(X_parametros_iniciales,P_[x,y],'f(p(1,:),x(i))',...
% ver,toler(error),toler(parametros),N_pasos,paso_deriv);
%
% NOTA ( PORQUE HAY QUE INTRODUCIR LA FUNCION COMO f(P(1,:),X) ):
%
% Hay que introducir f(x,p) como f(P(1,:),X) porque hay que calcular la de-
% rivada del error cuadratico, que es una funcion de los parametros, por eso
% se denotan mediante X. Las abscisas y ordenadas experimentales y sus erro-
% res, son algo dado a la hora de calcular el error cuadratico, son parame-
% tros para el error, no variables, por eso se denotan con P.


% opciones=zeros(1,18);
% opciones(1)=ver;
% opciones(2)=erre;
% opciones(3)=errp;
% opciones(14)=pasos;
if ver==1 ver='on';else ver='off';end
opciones=optimset('Display',ver,'TolX',erre,'TolFun',errp,'MaxFunEvals',pasos);
%xx=fminsearch(@(x) error1(x,p,s1),x0,opciones);
xx=fminsearch('error1',x0,opciones,p,s1);

e0=error1(xx,p,s1);
nu=length(p(1,:))-length(xx);
pchi=1-chi2cdf(e0,nu);

l=length(xx);
x=xx;
cad=['sum(((p(2,:)-(',s1,')).^2))'];

for i=1:l
    for j=1:l
          v1=zeros(1,l);
          v2=v1;
          v1(i)=1;
          v2(j)=1;
          invv(i,j)=0.5*derivad2(cad,xx,p,v1,v2,t);
    end 
end

V=inv(invv);

coefcorr=corrcoef([p(1,:)' p(2,:)']);
coefcorr=coefcorr(1,2);