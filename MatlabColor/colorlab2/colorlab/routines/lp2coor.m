function tt=lp2coor(lpY,tipo,f_igual,utri,Yw,tW);

% LP2COOR  computes [t1 t2 Y] from [lambda_d P Y]
% 
% SYNTAX
% -------------------------------------------------------------------------------
%
% tY=lp2coor(lPY,opt,T_l,Yw,tW);
% 
% lPY = Input color-like variable (N*3 variable) with N colors.
% 
% opt = Indicates the meaning of the Purity in lPY
%       P_excitat   -> opt=1
%       P_chromatic -> opt=2
% 
% T_l = Color matching functions
%
% Yw  = Trichromatic units
%
% tW = [t1W t2W], chromaticity coordinates of the reference white
% (optional,default value [1/3 1/3]);
%
%
% REQUIRED FUNCTIONS
% ---------------------------------------------------------------------------------
% tri2coor.m
%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         						                                     %
% Interpolacion de las funciones de igualacion del color a 1nm  %  
%								                                        %	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin==4
    tW=[1/3 1/3];
end
xm=mini(f_igual(:,1));
xM=maxi(f_igual(:,1));

xx=round(xm:1:xM);

ff_igual(:,1)=xx';
ff_igual(:,2)=interp1(f_igual(:,1),f_igual(:,2),xx','linear');
ff_igual(:,3)=interp1(f_igual(:,1),f_igual(:,3),xx','linear');
ff_igual(:,4)=interp1(f_igual(:,1),f_igual(:,4),xx','linear');

f_igual=ff_igual;
clear ff_igual;

locus=f_igual(:,2:4)./[sum(f_igual(:,2:4)')' sum(f_igual(:,2:4)')' sum(f_igual(:,2:4)')'];
locus=locus(:,1:2);

long_loc=size(locus);
long_loc=long_loc(1);

vloc=locus-repmat(tW,long_loc,1);
angulos=atan2(vloc(:,2),vloc(:,1));

% Eliminacion del salto del angulo al pasar de 2*pi
% (aqui se podria haber utilizado unwrap.m, pero...)
%
% Ademas hacemos rotamos el locus haciendo que el angulo fijamos
% el minimo (extremo rojo o azul) sea cero.
%

  angulos=angulos.*(+(angulos>=0))+(angulos+2*pi).*(+(angulos<0));

  anm1=angulos(2:length(angulos));
  an=angulos(1:length(angulos)-1);
  incan=anm1-an;

  poscero=find(abs(incan)>0.9*2*pi);
  
  if length(poscero)>0
     angulos=[angulos(1:poscero);angulos(poscero+1:length(angulos))-sign(incan(poscero))*2*pi];
  end 

  incre=-min(angulos); 
  angulos=angulos+incre;

  angul1=angulos(1:floor(length(angulos)/2));
  angul2=angulos(floor(length(angulos)/2)+1:length(angulos));

  locus1=locus(1:floor(length(angulos)/2),:);
  locus1=locus1(length(angul1):-1:1,:);
  locus2=locus(floor(length(angulos)/2)+1:length(angulos),:);

  f_igual1=f_igual(1:floor(length(angulos)/2),:);
  f_igual1=f_igual1(length(angul1):-1:1,:);
  f_igual2=f_igual(floor(length(angulos)/2)+1:length(angulos),:);

% Eliminacion de los extremos rojo y azul del locus a partir de las lambdas de retorno
% (en principio solo debe ocurrir retorno en el extremo rojo, pero si los datos son
%  ruidosos y el sistema es critico -p.e. UVW- tambien puede haber confusion en los angulos
%  en el extremo azul)
%
% El retorno se detectara como un cambio de signo en la derivada del angulo
%

% Extremo rojo  

  anm12=angul2(2:length(angul2));
  an2=angul2(1:length(angul2)-1);
  incan2=anm12-an2;

  s12=sign(incan2(1));
  signos2=(sign(incan2)==s12);
  m2=min(find(signos2==0));

   
% Extremo azul

  angul1=angul1(length(angul1):-1:1);

  anm11=angul1(2:length(angul1));
  an1=angul1(1:length(angul1)-1);
  incan1=anm11-an1;

  s11=sign(incan1(1));
  signos1=(sign(incan1)==s11);
  m1=min(find(signos1==0));
  

% Definimos ahora los nuevos locus en la region bien comportada en angulos.

if length(m1)~=0
   angul1=angul1(1:m1);
   locus1=locus1(1:m1,:);
   f_igual1=f_igual1(1:m1,:);
   angul1=angul1(length(angul1):-1:1);
   locus1=locus1(length(angul1):-1:1,:);
   f_igual1=f_igual1(length(angul1):-1:1,:);
else
   angul1=angul1(length(angul1):-1:1);
   locus1=locus1(length(angul1):-1:1,:);
   f_igual1=f_igual1(length(angul1):-1:1,:);
end

if length(m2)~=0
   angul2=angul2(1:m2);
   locus2=locus2(1:m2,:);
   f_igual2=f_igual2(1:m2,:);
end

angulos=[angul1;angul2];
locus=[locus1;locus2];
f_igual=[f_igual1;f_igual2];

ff_igual=f_igual;
m=length(angulos);
incre=-min(angulos); 
angulos=angulos+incre;


tr=locus(m,1:2);
ta=locus(1,1:2);
v2=tr-ta;
v2=v2/sqrt(v2*v2');

xm=ff_igual(1,1);
xM=ff_igual(m,1);

l=size(lpY);
l=l(1);
tt=repmat(tW,l,1);


for i=1:l
  if lpY(i,2)==0
     tt(i,:)=tW;           
  else
     if abs(lpY(i,1))<xm 
        signo=sign(lpY(i,1));
        lpY(i,1)=signo*xm;
     elseif abs(lpY(i,1))>xM
        signo=sign(lpY(i,1));
        lpY(i,1)=signo*xM;
     end
     if lpY(i,2)==0
        tt(i,:)=tW;
     else
        if lpY(i,1)>0
           lan=lpY(i,1);
           lm=floor(lan);                              
           lM=ceil(lan);
           pm=find(ff_igual(1:m,1)==lm);
           if lm~=lM
              pM=find(ff_igual(1:m,1)==lM);                
              E=ff_igual(pm,2:4)+(ff_igual(pM,2:4)-ff_igual(pm,2:4))*(lan-lm)/(lM-lm);
           else
              E=ff_igual(pm,2:4);
           end
           D=E./[sum(E) sum(E) sum(E)];
           EE=D(:,1:2);
           tt(i,:)=tW+lpY(i,2)*(EE-tW);
        else
           lan=abs(lpY(i,1));
           lm=floor(lan);                              
           lM=ceil(lan);
           pm=find(ff_igual(1:m,1)==lm);
           if lm~=lM
              pM=find(ff_igual(1:m,1)==lM);
              E=ff_igual(pm,2:4)+(ff_igual(pM,2:4)-ff_igual(pm,2:4))*(lan-lm)/(lM-lm);
           else
              E=ff_igual(pm,2:4);
           end
           locE=E./[sum(E) sum(E) sum(E)];
           EE=locE(:,1:2);
           v1=EE-tW;
           v1=-v1/sqrt(v1*v1');
           l2=det([v1(1) ta(1)-tW(1);v1(2) ta(2)-tW(2)])/det([v1(1) -v2(1);v1(2) -v2(2)]);
           ptoint=ta+v2*l2;          
           ptoint(3)=1-sum(ptoint);
           D=ptoint;
%           ptoint(1)=(v(2)/(3*v(1))-1/3+locus(1,2)-locus(1,1)*w(2)/w(1))/(v(2)/v(1)-w(2)/w(1));
%           ptoint(2)=1/3+(ptoint(1)-1/3)*v(2)/v(1);
        end
     end
     if tipo==1
        tt(i,1:2)=tW+lpY(i,2)*(D(1:2)-tW);
     else
        TT=(lpY(i,3)*(1-lpY(i,2))/sum(utri))*coor2tri([tW 1],utri)+lpY(i,2)*lpY(i,3)*D/(D*utri');
        ttt=tri2coor(TT,utri);
        tt(i,:)=ttt(1:2); 
     end
  end

end 
tt=[tt lpY(:,3)];