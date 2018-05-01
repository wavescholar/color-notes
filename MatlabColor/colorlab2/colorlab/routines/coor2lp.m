function [lpY]=coor2lp(tY,tipo,f_igual,utri,tW)

% COOR2LP  compute dominant wavelength, purity and luminance from chromatic coordinates and luminance.
% 
% We can choose chromatic or excitation purity:
% 
%      P_excitat -> opt=1
%      P_chromat -> opt=2 
%
% SYNTAX
% ---------------------------------------------------------------------------------------
%
% lpY=coor2lp(tY,opt,T_l,Yw,tW);
%
% tY  = Input chromatic coordinates and luminances (color-like variable)
%  
% opt = Selects the kind of purity in the output:
%       P_excitat -> opt=1
%       P_chromat -> opt=2 
%
% T_l = Color matching functions
%
% Yw  = Trichromatic units
%
% lpY = Output colors expressed in dominant wavelength, purity and luminance [lambda P Y] 
%       Purples are characterized by the complementary dominant wavelength with negative sign.
% 
%  tW = [t1W t2W], chromaticity coordinates of the reference white
% (optional,default value [1/3 1/3]);
%
% REQUIRED FUNCTIONS
% ----------------------------------------------------------------------------------------
%
% coor2tri.m
% 

if nargin==4
    tW=[1/3 1/3];
end

locus=f_igual(:,2:4)./[sum(f_igual(:,2:4)')' sum(f_igual(:,2:4)')' sum(f_igual(:,2:4)')'];
locus=locus(:,1:2);

long_loc=size(locus);
long_loc=long_loc(1);

vloc=locus-repmat(tW,long_loc,1);
angulos0=atan2(vloc(:,2),vloc(:,1));

% Eliminacion del salto del angulo al pasar de 2*pi
% (aqui se podria haber utilizado unwrap.m, pero...)
%
% Ademas hacemos rotamos el locus haciendo que el angulo fijamos
% el minimo (extremo rojo o azul) sea cero.
%

  angulos=angulos0.*(angulos0>=0)+(angulos0+2*pi).*(angulos0<0);

  anm1=angulos(2:length(angulos));
  an=angulos(1:length(angulos)-1);
  incan=anm1-an;

  poscero=find(abs(incan)>0.9*2*pi);

  if length(poscero)>0
     angulos=[angulos(1:poscero);angulos(poscero+1:length(angulos))-sign(incan(poscero))*2*pi];
  end 

  incre1=-min(angulos);
  angulos=angulos+incre1;

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

     if angulos(m)==0
        orden=1;
       alfa=angulos0(m);
     else
        orden=-1;
       alfa=angulos0(1);
     end
     
l=size(tY);
l=l(1);

Y=tY(:,3);

tr=locus(m,1:2);
ta=locus(1,1:2);
v2=tr-ta;
v2=v2/sqrt(v2*v2');

for i=1:l
    t=tY(i,1:2);
    if (t(1)==tW(1))&(t(2)==tW(2))
       lan=555;
       P=0;
    else
       T=coor2tri(tY(i,:),utri);
       vv=t-tW; 
       ang=atan2(vv(2),vv(1));
       angulo=ang*(ang>=0)+(ang+2*pi)*(ang<0);
       if orden==1
            if (ang>=alfa) & (ang<0)
               angulo=angulo-sign(incan(poscero))*2*pi;
            else
               angulo=angulo;
            end
       else
            if (ang>=alfa) & (ang<0)
               angulo=angulo;
            else
               angulo=angulo-sign(incan(poscero))*2*pi;
            end        
       end
       angulo=angulo+incre+incre1;
       angus(i)=angulo;
       angula=angulo;
       
       condcolor=(angula>max(angulos));
           
       if condcolor==0
           lan=interp1(angulos,ff_igual(:,1),angula);
%           lm=floor(lan);                              
%           lM=ceil(lan);
%           pm=find(ff_igual(1:m,1)==lm);               
            pm=max(find(ff_igual(:,1)<=lan));
            pM=min(find(ff_igual(:,1)>=lan));
            lm=ff_igual(pm,1);                
            lM=ff_igual(pM,1);
           if lm~=lM
%              pM=find(ff_igual(1:m,1)==lM);                
              E=ff_igual(pm,2:4)+(ff_igual(pM,2:4)-ff_igual(pm,2:4))*(lan-lm)/(lM-lm);
           else
              E=ff_igual(pm,2:4);
           end
           D=E./[sum(E) sum(E) sum(E)];
       else
           ang=ang-pi;
           angulo=ang*(+(ang>=0))+(ang+2*pi)*(+(ang<0));
           if orden==1
             if (ang>=alfa) & (ang<0)
                angulo=angulo-sign(incan(poscero))*2*pi;
             else
                angulo=angulo;
             end
           else
             if (ang>=alfa) & (ang<0)
                angulo=angulo;
             else
                angulo=angulo-sign(incan(poscero))*2*pi;
             end        
           end
           angulo=angulo+incre+incre1;
           angula=angulo;
           anglanda=angulo;
     
           lan=-interp1(angulos,ff_igual(:,1),anglanda);
     
           v1=t-tW;
           v1=v1/sqrt(v1*v1');
            
           l2=det([v1(1) ta(1)-tW(1);v1(2) ta(2)-tW(1)])/det([v1(1) -v2(1);v1(2) -v2(2)]);
           ptoint=ta+v2*l2;          
 
           ptoint(3)=1-sum(ptoint);
           D=ptoint;
        end
        Pe=sqrt(sum((t-tW).^2))/sqrt(sum((D(1:2)-tW).^2));
        if tipo==2
           tt=[t 1-sum(t)];
           if Pe>1
              Pc=Pe*(utri*D')/(utri*tt');
           else
              Pc=abs(Pe*(utri*D')/(utri*tt'));
           end
         P=Pc;
        else
         P=Pe;
        end 
  
    end
   lpY(i,:)=[lan P];
end
lpY=[lpY Y];