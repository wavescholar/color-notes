clear all;
hold on; 
%ML_SPEC_CF
[lambdaD65, D65] = illuminant('d65');
   subplot(1,2,1);
   plot(lambdaD65, D65)
   title('D_{65} illuminant')
   spectrumLabel(gca)
%        
% [lambdaEE, EE] = illuminant('EE');
%    subplot(1,2,2);
%    plot(lambdaEE, EE)
%    title('EE illuminant')
%    spectrumLabel(gca)
%         
%       
   cl_D65=load('iluminan.d65');
   lambdaD65 = cl_D65(:,1);
   subplot(2,2,1);
   plot(lambdaD65,100.00*cl_D65(:,2));title('D65 Daylight Illuminant');
   spectrumLabel(gca)
   cl_D50=load('iluminan.d50');
   lambdaD50 = cl_D50(:,1);
   subplot(2,2,2)
   plot(lambdaD50,100.0*cl_D50(:,2));title('D50 Daylight Illuminant');
   spectrumLabel(gca)
   
   cl_f7=load('iluminan.f7');
   lambdaf7 = cl_f7(:,1);
   subplot(2,2,3);
   plot(lambdaf7,100.00*cl_f7(:,2));title('F7  fluorescent Illuminant');
   spectrumLabel(gca)
   cl_f2=load('iluminan.f2');
   lambdaf2 = cl_f2(:,1);
   subplot(2,2,4)
   plot(lambdaf2,100.0*cl_f2(:,2));title('F2  fluorescent Illuminant');
   spectrumLabel(gca)
   
   
    image(roo2rgb(colorchecker,'srgb',lambdaD65));
    

 % PLot the spectral power distribution of the Macbeth Color Chart
 R_D65=COLORCHECKER(lambdaD65);
 
 %Show where in RGB space ColorChecker patches are located.
         rgb=roo2rgb(colorchecker, 'srgb');
         ballplot(rgb(:,:,1),rgb(:,:,2),rgb(:,:,3), rgb,.05,2);
         camlight;
         lighting phong
        
 pcount=0;
  for j=1:6;
      for i=1:4;
          i
          j
pcount=pcount+1
x=   R_D65(i,j,:);
z=squeeze(x);
%subplot(4,6,pcount); 
figure;
 plot(lambdaD65,z);set(gca,'Color',[rgb(i,j,1),rgb(i,j,2),rgb(i,j,3)])

spectrumLabel(gca)
 
      end;
end;
 
 
  
 
 
 
 
 
%    CIE_1931   CIE 1931 2-degree, XYZ
%    1931_FULL  CIE 1931 2-degree, XYZ  (at 1nm resolution)
%    CIE_1964   CIE 1964 10-degree, XYZ
%    1964_FULL  CIE 1964 10-degree, XYZ (at 1nm resolution)
%    Judd       CIE 1931 2-degree, XYZ modified by Judd (1951)
%    Judd_Vos   CIE 1931 2-degree, XYZ modified by Judd (1951) and Vos (1978)
%    Stiles_2   Stiles and Burch 2-degree, RGB (1955)
%    Stiles_10  Stiles and Burch 10-degree, RGB (1959)
   [lambdaCIE_1931, xFcnCIE_1931, yFcnCIE_1931, zFcnCIE_1931] = colorMatchFcn('CIE_1931');
   subplot(2,3,1);plot(xFcnCIE_1931);title('R CIE 1931');   spectrumLabel(gca);
   subplot(2,3,2);plot(yFcnCIE_1931);title('G CIE 1931');   spectrumLabel(gca);
   subplot(2,3,3);plot(zFcnCIE_1931);title('B CIE 1931');   spectrumLabel(gca);
   
      
   [lambdaCIE_1964, xFcnCIE_1964, yFcnCIE_1964, zFcnCIE_1964] = colorMatchFcn('CIE_1964');
   subplot(2,3,4);plot(xFcnCIE_1964);title('R CIE 1964');   spectrumLabel(gca);
   subplot(2,3,5);plot(yFcnCIE_1964);title('G CIE 1964');   spectrumLabel(gca);
   subplot(2,3,6);plot(zFcnCIE_1964);title('B CIE 1964');   spectrumLabel(gca);
   
   
   

   
   
   
   
   %OPTPROP
  rgb=cat(3,[1 0 0], [0 1 0], [0 0 1]);

  xyz=[rgb2xyz(rgb,'srgb','D50/2'); 
    
rgb2xyz(rgb,'adobe','D50/2')];
YCBCR = rgb2ycbcr(rgb);
xy=xyz2xy(xyz);

xyl=cat(2,xy,xy(:,1,:));
plot(xyl(:,:,1)',xyl(:,:,2)');
xlabel('x');ylabel('y')
legend('sRGB', 'Adobe');

clear all;
rgb=cat(3,[1 0 0], [0 1 0], [0 0 1]);
xyz=rgb2xyz(rgb,'srgb','D65/10');
xy=xyz2xy(xyz);
ballplot(xy(:,:,1),xy(:,:,2),zeros(size(xy(:,:,1))),rgb);
hold on
YCBCR=rgb2ycbcr(rgb);
xyz=rgb2xyz(YCBCR,'srgb','D65/10');
xy=xyz2xy(xyz);
ballplot(xy(:,:,1),xy(:,:,2),zeros(size(xy(:,:,1))),YCBCR);


clear all;
m=255;
h = (0:m-1)'/max(m,1);
rgb=[h ones(m,2)];
hsvmapinv = hsv2rgb([h ones(m,2)]);
hsvmapfdw = rgb2hsv([h ones(m,2)]);

ycbcrinv=rgb2ycbcr([h ones(m,2)]);
ycbncrfwd=ycbcr2rgb([h ones(m,2)]);

xyz=rgb2xyz(rgb,'srgb','Gamma', 1);
ballplot(xyz,rgb);
camorbit(90,0);
camlight;
lighting phong
xlabel('X');ylabel('Y'); zlabel('Z');

h=viewgamut(xyz,rgb, 'EdgeColor', [0 0 0]);
camorbit(90,0);
xlabel('X');ylabel('Y'); zlabel('Z');


clear all;
rgb=addmix(5,5);

hold on;
subplot(1,2,1);

xyz=rgb2xyz(rgb,'srgb','Gamma', 1);

ballplot(xyz,rgb);
subplot(1,2,2);

ycbcrinv=rgb2ycbcr(rgb);
xyz=rgb2xyz(rgb,'srgb','Gamma', 1);
ballplot(xyz,ycbcrinv);
camorbit(90,0);
camlight;
lighting phong
xlabel('Red');ylabel('Green'); zlabel('Blue');
hold off;

     [x,y,z] = sphere(8);
	   
     X = [x(:)*.5 x(:)*.75 x(:)];
     Y = [y(:)*.5 y(:)*.75 y(:)];
     Z = [z(:)*.5 z(:)*.75 z(:)];
     C = repmat([1 2 3],numel(x),1);
     ballplot(X,Y,Z,C(:));
     view(-60,10)
     camlight
     
     
     
     
         
     
     
     
     
     