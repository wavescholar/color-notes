function [im,mapa]=true2pal(im3,varargin)

% TRUE2PAL generates the indexed image and the palette from the true color image.
% 
% Digital images are arrays of M*N pixels. Each pixel may have a different color.
% Therefore, digital color images may be described in two ways:
% 
% * True color image.
%   A true color image consists of 3 M*N matrices indicating the tristimulus 
%   value (or any other color component) of the image in each pixel (spatial 
%   location). 
%   This is the straightforward description of the color samples obtained from
%   a natural image. This is referred to as true color image because you may have 
%   a lot of different colors in the image: the number of different colors is only
%   limited by the size of the image (M*N) and the available resolution of the 
%   guns, (2^b)^3, (b=8 in standard VGAs).
%
% * Indexed image and color palette
%   This description consists of one M*N matrix (the indexed image) and one C*3 
%   matrix (the color palette). The rows of the color palette contain the 
%   tristimulus values (or any other color components) of the C colors in the 
%   scene. Each number of the indexed matrix is an integer that indicates the 
%   color of the palette (the row of the palette) that corresponds to that pixel 
%   (spatial location).
%   In principle in the image+palette representation you may have the same number
%   of colors than in a true color image but the image+palette representation was
%   originally intended to work with a very restricted set of colors to save data 
%   (see below). This is why, when more powerful systems were available and it 
%   began to be possible to work with 3 M*N matrices people called that 
%   representation 'true color' because it hadnt the C-colors limitation.
% 
% The image+palette representation may be convenient due to two reasons:
% 
% * (Important) It is useful to work separately with the color content.
%   For instance to desaturate the image or equalize the luminances you
%   only have to work on the palette (spatial position doesnt matter).
%
% * (Historical) It may be more efficient than true color representation.
%   If the number of different colors in the image is small ( C<(2/3)M*N ), 
%   this representation requires less data than the true color representation.
%   This had a lot of importance in the past when VGAs had limited graphic memory
%   and couldnt support true color. In that case the limitation of C was the
%   (trivial) way to save memory. C=256 (only 256 different colors at a time) 
%   was a typical limitation in old VGAs.
%   
% TRUE2PAL computes the image+palette representation from the true color image.
% TRUE2PAL normalizes the colors in the scene to put them in a unit volume cube
% and then it applies RGB2IND to select the palette.
% 
% RGB2IND converts a true color image to indexed image with limited size palette 
% using one of three different methods: uniform quantization, minimum 
% variance quantization, colormap approximation.
% Also it may use direct translation: i.e. it may generate an indexed image with 
% a non-restricted palette (containing all the colors of the true color image).
%  
% SYNTAX
% ---------------------------------------------------------------------------------------
% 
% [X,map]=true2pal(im3,p);
%
% OUTPUT variables
% 
% X   = Indexed image (M*N matrix).
%
% map = Palette (color-like variable: C*3 matrix).
%
% INPUT variables
%
% im3 = True color image (M*N*3 matrix) 
%       The input true color image (M*N*3 matrix) may use any 3D color
%       representation (not only tristimulus values in any space, but also
%       chromatic coordinates and luminance, MATLAB digital values or 
%       (standard) 8 bit digital values). 
%
% p   = Parameter to control the palette selection algorithm in RGB2IND.
%       We have four different options:
%       (1) Uniform quantization of each color axis (scalar quantization)
%           [X,MAP]=true2pal(im3,TOL) converts the true color image, im3, to an
%           indexed image X using uniform quantization. MAP contains at most
%           C=(FLOOR(1/TOL)+1)^3 colors. TOL must be between 0.0 and 1.0.
%
%       (2) Minimum Variance Quantization (vector quantization)
%           [X,MAP] = true2pal(im3,C) converts the true color image, im3, to an 
%           indexed image X using minimum variance quantization. MAP contains at 
%           most C colors.
%
%       (3) Colormap approximation
%           X=true2pal(im3,MAP) converts the true color image, im3, to an indexed
%           image X with colormap (palette) MAP by matching colors in RGB with the 
%           nearest color in the colormap MAP.
%
%       (4) Direct translation   
%           [X,MAP] = true2pal(im3) converts the true color image, im3, to an indexed 
%           image X with colormap MAP using direct translation. The resulting colormap
%           may be very long, as it has one entry for each pixel in RGB. 
%
% REQUIRED FUNCTIONS
% ---------------------------------------------------------------------------------------
%  rgb2ind.m (image processing toolbox)
% cmunique.m (image processing toolbox)
% 
% RELATED FUNCTIONS
% ---------------------------------------------------------------------------------------
% See imread.m and imwrite.m to learn on how to read and write images in standard formats
%
% See image.m (Matlab), imshow.m (Matlab) and dispim.m (Colorlab) to learn on how to
% display an image. 
% WARNING: note that Matlab 5.3 versions of image and imshow do not support colormaps
% (palettes) with more than 256 colors. In order to show images with bigger palettes 
% use dispim.m (Colorlab) or the true color format (M*N*3 matrix).
% 

s=[];
if isa(im3,'double')
   a0=[min(min(im3(:,:,1))) min(min(im3(:,:,2))) min(min(im3(:,:,3)))];
   c=[max(max(im3(:,:,1)-a0(1))) max(max(im3(:,:,2)-a0(2))) max(max(im3(:,:,3)-a0(3)))];
   mm=(c==0);
   im3_2=cat(3, (im3(:,:,1)-a0(1)+0.5*mm(1))/(c(1)+mm(1)) , (im3(:,:,2)-a0(2)+0.5*mm(2))/(c(2)+mm(2)) , (im3(:,:,3)-a0(3)+0.5*mm(3))/(c(3)+mm(3)) );
   clear im3
   dou=1;
else
   im3_2=im3;
   clear im3
   dou=0;
end 

if nargin>1
   eval(['parametro=varargin{1};']) 
   s=size(parametro);
   if prod(s)>1
      a1=min(parametro); 
      para=parametro-ones(s(1),1)*a1;    
      cc=max(para)+(max(para)==0);
      parametro=[para(:,1)/cc(1) para(:,2)/cc(2) para(:,3)/cc(3)]; 
      clear para
   end
   [im,map]=rgb2ind(im3_2,parametro);
else
   [im,map]=cmunique(im3_2);   
end   

if isa(im,'uint8')
   im=double(im)+1; 
elseif  isa(im,'uint16')   
   im=double(im)+1; 
else
   im=im; 
end

%im=uint8(double(im)+1);
l=size(map);

if dou==1
   if prod(s)>1
      mapa=[cc(1)*map(:,1)+a1(1) cc(2)*map(:,2)+a1(2) cc(3)*map(:,3)+a1(3)];
   else
      mapa=[c(1)*map(:,1)+a0(1) c(2)*map(:,2)+a0(2) c(3)*map(:,3)+a0(3)];
   end
else
   mapa=map;
end   
