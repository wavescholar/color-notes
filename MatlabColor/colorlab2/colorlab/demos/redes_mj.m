%Genera redes alrededor del blanco, en los ejes A, T y D de Boynton


startcol
x=linspace(0,1,256);
x=x(ones(256,1),:);

%REDES ESPACIALES
%Red acromática
atd1=xyz2atd([40 40 40],6);
A=40+20*sin(2*pi*4*x);
T=ones(size(A))*atd1(:,2);
D=ones(size(A))*atd1(:,3);
imag(:,:,1)=A;
imag(:,:,2)=T;
imag(:,:,3)=D;
[im,atd]=true2pal(imag,256);
XYZ=atd2xyz(atd,1,6);
[n,saturat,Tn]=tri2val(XYZ,Yw,tm,a,g,8);
colormap(n);image(im);axis image;axis off

%Red cromática rojo-verde
A=ones(size(A))*40;
T=atd1(:,2)+35*atd1(:,2)*sin(2*pi*4*x);
D=ones(size(A))*atd1(:,3);
imag(:,:,1)=A;
imag(:,:,2)=T;
imag(:,:,3)=D;
[im,atd]=true2pal(imag,256);
XYZ=atd2xyz(atd,1,6);
[n,saturat,Tn]=tri2val(XYZ,Yw,tm,a,g,8);
colormap(n);image(im);axis image;axis off

%Red cromática azul-amarillo
A=ones(size(A))*40;
D=atd1(:,3)+50*atd1(:,3)*sin(2*pi*4*x);
T=ones(size(A))*atd1(:,2);
imag(:,:,1)=A;
imag(:,:,2)=T;
imag(:,:,3)=D;
[im,atd]=true2pal(imag,256);
XYZ=atd2xyz(atd,1,6);
[n,saturat,Tn]=tri2val(XYZ,Yw,tm,a,g,8);
colormap(n);image(im);axis image;axis off


%REDES TEMPORALES
%Acromáticas
t=linspace(0,1,24);

A=40+20*sin(2*pi*t);
T=ones(size(A))*atd1(:,2);
D=ones(size(A))*atd1(:,3);
M=moviein(length(t))

for i=1:length(t)
 imag(:,:,1)=A(i);
 imag(:,:,2)=T(i);
 imag(:,:,3)=D(i);
 [im,atd]=true2pal(imag,256);
 XYZ=atd2xyz(atd,1,6);
 [n,saturat,Tn]=tri2val(XYZ,Yw,tm,a,g,8);
 colormap(n);image(im);axis image;axis off
 M(:,i)=getframe;
end

%Rojo-Verde
T=atd1(:,2)+35*atd1(:,2)*sin(2*pi*t);
A=40*ones(size(T));
D=atd1(:,3)*ones(size(T));
M=moviein(length(t))

for i=1:length(t)
 imag(:,:,1)=A(i);
 imag(:,:,2)=T(i);
 imag(:,:,3)=D(i);
 [im,atd]=true2pal(imag,256);
 XYZ=atd2xyz(atd,1,6);
 [n,saturat,Tn]=tri2val(XYZ,Yw,tm,a,g,8);
 colormap(n);image(im);axis image;axis off
 M(:,i)=getframe;
end

figure;axis off;colormap(n);movie(M,5,10);

%REDES ESPACIO-TEMPORALES

x=linspace(0,1,256);
x=x(ones(256,1),:);
M=moviein(length(t));
for i=1:length(t)
 A=40+20*sin(2*pi*4*x)*sin(2*pi*t(i));
 T=ones(size(A))*atd1(:,2);
 D=ones(size(A))*atd1(:,3);
 imag(:,:,1)=A;
 imag(:,:,2)=T;
 imag(:,:,3)=D;
 [im,atd]=true2pal(imag,256);
 XYZ=atd2xyz(atd,1,6);
 [n,saturat,Tn]=tri2val(XYZ,Yw,tm,a,g,8);
 colormap(n);image(im);axis image;axis off
 M(:,i)=getframe;
end
figure;axis off;colormap(n);movie(M,5,10);
