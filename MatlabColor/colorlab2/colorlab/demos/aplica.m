function [lpy]=aplica(im,lpyx,Ymax0,s_lum,s_pur,txtlum2,txtpur2)

% APLICA funcion interna de botoncitos de DEMOSAT 
% que aplica la luminancia y la pureza elegida con las
% barritas 

p=which('ciergb.mat');
path_data=p(1:end-18);

[f_igual,utri,Msx]=loadsysm([path_data,'systems\ciexyz']);
[coco,a,g]=loadmonm([path_data,'monitor\std_crt'],Msx);


lum=get(s_lum,'Value');
pur=get(s_pur,'Value');
set(txtpur2,'String',num2str(pur))
set(txtlum2,'String',[num2str(lum),' (cd/m2)'])
Pmed=mean(lpyx(:,2));
Ymax=max(lpyx(:,3));
lpy=[lpyx(:,1) pur*lpyx(:,2)/Pmed lum*lpyx(:,3)/Ymax];

%[nmonit,nmatlab,satur,Tposible]=tri2niv4(coco,utri,a,g,1,coor2tri(lp2coor(lpy,2,f_igual,utri),utri));
[nmatlab,saturat,Tn]=tri2val(coor2tri(lp2coor(lpy,2,f_igual,utri),utri),utri,coco,a,g,8);

figure(2),clf,colormap(nmatlab),image(im),ax,axis('off')
figure(6),clf,colordgm(Tn,1,f_igual,utri,coco);
figure(7),clf,%colorspc(Tn/20,1,f_igual,utri,coco);
  symb='o';
  lim_axis=0;
  showvectors=0;
  show_lin=0;
  show_numb=0;
  showdiag=1;
  showtriang=3;
  linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.3 0.2 0;0.6 0.2 0;0.3 0.2 0;0.3 0.2 0];
  linewidths=[0.5 0.5 0.5 0.5 0.5 0.5 0.5];
  linestyles=['- ';'- ';'- ';'- ';': ';'- ';'- '];
  sizes=[10 12 1.5 8];
 
%colorspc(Tn/50,1,f_igual,utri,coco,symb,[0 Ymax0 0 Ymax0 0 Ymax0]/50,showvectors,show_lin,show_numb,showdiag,showtriang,linecolors,linewidths,linestyles,fontsizes);
colorspc(Tn/50,1,f_igual,utri,'symb','o','lim_axis',[0 Ymax0 0 Ymax0 0 Ymax0]/50,'sizes',sizes,'showtriang',{3,coco},'showdiag',1,'linecolors',linecolors)




%colorend(Tposible,1,f_igual,utri,1,coco,0,1,6);
%colorene(2.2*Tposible/Ymax0,1,1,f_igual,utri,coco,0,0,7,1,[0 2.5 0 2.5 0 2.5],[100 30]);

%lpy=coor2lp(tri2coor(Tposible,utri),1,f_igual,utri,0,1);