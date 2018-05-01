startcol
im=imread('c:\temp\marijosi.jpg');
[imi,pal]=true2pal(im,100);
T=val2tri(pal,Yw,tm,a,g);
colormap(pal),image(imi),axis('off')
figure,colordgm(T,1,T_l,Yw,tm);
t=tri2coor(T,Yw);
Ymax=max(t(:,3));
W=[Ymax Ymax Ymax];
LAB=xyz2lab(T,W);
LhC=lab2perc(LAB);

ang=0:0.6:2*pi;

tic
for i=1:length(ang)
    LhC2=[LhC(:,1) mod(LhC(:,2)-ang(i),2*pi) LhC(:,3)];
    LAB2=perc2lab(LhC2);
    T2=lab2xyz(LAB2,W);
    [pal2,saturat,Tn]=tri2val(T2,Yw,tm,a,g,8);
    t2=tri2coor(T2,Yw);
    figure,colormap(pal2),image(imi),axis('off')
    figure,colordgm(t2,2,T_l,Yw,tm);
    print('-djpeg90',['c:\temp\colores',num2str(ang(i)),'.jpg'])
    imwrite(imi,pal2,['c:\temp\mari',num2str(ang(i)),'.jpg'],'jpg');
    
end 
toc