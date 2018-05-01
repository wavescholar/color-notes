function [reflec,Mval]=loadmunl(valor,tipo)

% LOADMUNL loads a locus of constant hue, value or chroma form the
% Munsell database.
%  
% SYNTAX
% ----------------------------------------------------------------
% [reflec,HVCh]=loadmunl(identif,percd);
% 
% identif = Parameter that identifies the locus to be loaded.
%
% percd   = 'h','V' or 'C' 
%
% HVCh    = Munsell color descriptors of the samples loaded.
%
%
% NOTE: The Munsell notation in COLORLAB.
% ----------------------------------------------------------------
%
% COLORLAB comes with a database of reflectances corresponding to the 
% color samples of the Munsell Book of Color. This colour atlas contains
% coloured and gray samples.
% 
% The gray samples are identified by a single parameter, N, describing
% their lightness. N takes values between 0.5 and 9.5, in 0.25 steps. The
% lower N, the darker appears the sample when seen agains the reference white.
%
% The coloured samples are classified according to Hue, Chroma and Value
% (Lightness).
%
% The main hue, h, is a name identifying the colour as blue, green-blue,
% green, green-yellow, yellow, yellow-red, red, red-purple, purple or
% purple blue. In this function, h is an integer between 1 and 10 (1 for 
% blue, 2 for green-blue, 3 for green, and so on). 
%
% H identifies different shades of the same hue. The number of shades for
% each hue is not constant. Possible H values are between 1.25 and 10, in
% 1.25 steps.
%
% The "value", V, is a measurement of the lightness of the sample. This
% descriptor takes integer values between 0 and 9.
%
% C is the chroma of the sample, a parameter measuring the colour content 
% of the sample compared with that of the reference white in the same scene.
% Possible chroma values are 0, 1 and even values between 2 and 16.
%
% LOADREFM accepts as input a matrix of the form [H1 V1 C1 h1;H2 V2 C2 h2;...]
% describing N colours by their Munsell notation. 
%
% NOTE (on the Munsell reflectance database)
% ----------------------------------------------------------------
% The directory COLORLAB/COLORDAT/REFLECT/MUNSELL contains a set of
% files with the reflectances of the glossy Munsell Atlas, organized as
% follows:
%
%   * The files are organized in hue-named folders:
%
%                   b, bg, g, gy, y, yr, r, rp, p, pb
%
%   * Inside each folder, the name of the files is made of 8 numbers:
%     
%                               HHHHVVCC  
%     
%     The first 4 numbers (HHHH) mean HUE. They may have values in the 
%     range HHHH=0000..0250....0500....1000. 
%     Going from 0000 to 1000 means fine change from one coarse hue to 
%     the next one (for example from 'green' -g- to green-blueish -bg-).
%
%     The next 2 numbers (VV) mean VALUE. They may have values in the 
%     range VV= 00, 10, 20, 30, 40, ...,90.
%
%     The last 2 numbers (CC) mean CHROMA. They may have values in 
%     the range CC= 00, 01, 02 ... 16.
%


if not(ischar(tipo))
   disp('Type must be a string. See help');
else
   nuevo=[];
   if tipo=='h'
     for H=10:-1.25:1.25;
       for V=0:10;
         for C=[0 1 2:16];
          nuevo=[nuevo;H V C valor];
         end
       end
     end
  elseif tipo=='V'
     for h=1:10
     for H=10:-1.25:1.25;
        for C=[0 1 2:16];
          nuevo=[nuevo;H valor C h];
         end
       end
     end
     
  elseif tipo=='C'
     for h=1:10
     for H=10:-1.25:1.25;
       for V=0:10;
             nuevo=[nuevo;H V valor h];
         end
       end
     end

  end
 end
 
 [reflec,Mval]=loadrefm(nuevo);