function [im]=pal2true(imind,paletri,wtbar)

% PAL2TRUE converts the image+palette representation to true color representation
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
%   (see PAL2TRUE.M). This is why, when more powerful systems were available and it 
%   began to be possible to work with 3 M*N matrices people called that 
%   representation 'true color' because it hadnt the C-colors limitation.
%
% PAL2TRUE converts the image+palette representation to true color representation
%
% SYNTAX
% ---------------------------------------------------------------------------------------
% 
% im=pal2true(ind_im,map,wtbar);
% im=pal2true(ind_im,map);
%
%
% INPUT variables
% 
% ind_im = Indexed image (M*N matrix).
%
% map    = Palette or colormap (color-like variable: C*3 matrix).
%          The input colormap (C*3 matrix) may use any 3D color
%          representation (not only tristimulus values in any space, 
%          but also chromatic coordinates and luminance, MATLAB digital 
%          values or -standard- 8 bit digital values).
%
% wtbar  =If wtbar==1, a waitbar is displayed to monitor de progress of the operation.
%         If wtbar==0, no waitbar is shown.
%         By default, wtbar=1;
%
% OUTPUT variables
%
% im    = True color image (M*N*3 matrix) 
%
% REQUIRED FUNCTIONS
% ---------------------------------------------------------------------------------------
% waitbar.m (image processing toolbox)
% 


if nargin==2
   wtbar=1;
end
s=size(imind);

im=zeros(s(1),s(2),3);
if isa(imind,'uint8')
   imind=double(imind)+1;
end
if isa(imind,'uint16')
   imind=double(imind)+1;
end
if wtbar==1
   h=waitbar(0,'Generating the true color image...');
end
for i=1:s(1)
    if wtbar==1;waitbar(i/s(1));end
    for j=1:s(2)
        color=imind(i,j);
        im(i,j,1:3)=paletri(color,1:3);
    end
 end
if wtbar==1
    close(h)
end