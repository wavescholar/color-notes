function [reflec,Mval]=loadrefm(tray)

% LOADREFM loads a reflectance/transmitance from explicit file.
% 
% This file should have been generated with SAVEREFL or contain a
% spectral-like variable named 'reflec'.
% LOADREFM returns a spectral-like variable (wavelength-magnitude).
%
% LOADREFM also provides an easy way to load sets of Munsell 
% reflectances (which would be a pain otherwise!). 
% See SYNTAX and the note on Munsell reflectances below...
%  
% SYNTAX
% ----------------------------------------------------------------
% reflec=loadrefm(identif);
% 
% identif = Parameter that identifies the reflectance/transmitance file(s)
%           to be loaded.
%           This parameter can be a string indicating the path of the file
%           or it can be a matrix, [H V C h] (nx4 for n coloured samples)
%           or [N] (nx1 for n grey samples), that specifies the Munsell
%           reflectances to be loaded. See below the note on the Munsell
%           notation as used in this function.
%
%           Not all the combinations of H, V, C and h are valid. With the
%           options:
%
%                   [reflec, vHVCh]=loadrefm([H V C h])
%                   [reflec, vN]=loadrefm([N])
%
%           the function returns a matrix (vHVCh or vN) containing the subset
%           of our original descriptors corresponding to real colours in the
%           Munsell Atlas.
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

RE=[];

if isstr(tray)==0 
 %Caso en el que se introduce sólo la notación Munsell
 p=which('munsell.mat');
 p=fileparts(p);
 traye=fullfile(p,'munsell');
 M=tray;
 m=size(M);
 Mval=[];
 iMval=1;
 j=2;
 Mamp=[];
 if m(2)>1
 for i=1:m(1)
    if all(M(i,1:3)==0)
          k=1;
          for H=1.25:1.25:10;
             for V=0:10;
                for C=[0 1 2:16];
                   nuevo(k,:)=[H V C M(i,4)];
                   k=k+1;
                end
             end
          end
          Mamp=[Mamp;nuevo];
          clear nuevo
     else
       Mamp=[Mamp;M(i,:)];          
     end   
  end
  M=Mamp;
else
   if M==0;
      M=[0 0.5:0.25:9.5]';
   end
end
m=size(M);

 % Para saber cada extensión (tono), y cuantas muestras
 lista1=['B';'G';'Y';'R';'P'];
 lista2=['BG';'GY';'YR';'RP';'PB'];
 for i=1:m(1)
     if m(2)==1
   	ext='N';
     else
       if any([1:2:10]==M(i,4))
         cual=find([1:2:10]==M(i,4));
         ext=lista1(cual,:);
       else 
         cual=find([2:2:10]==M(i,4));
         ext=lista2(cual,:);
       end
     end
   if M(i,1)<1
    n1=['00' num2str(M(i,1)*100)];
   elseif 1<=M(i,1) & M(i,1)<10 
    n1=['0' num2str(M(i,1)*100)];
   else
    n1=num2str([M(i,1)*100]);
   end
   if m(2)==1
    nom=[n1 '.mat'];
   else
    if M(i,3)<10 
     n3=['0' num2str(M(i,3))];
    else
     n3=num2str([M(i,3)]);
    end
    nom=[n1 num2str([M(i,2)*10]) n3 '.mat'];
 end
   fffile=fullfile(traye,ext,nom);
   if exist(fffile)
     load(fffile);
     if exist('reflec')
       RE(:,1)=reflec(:,1);
       RE(:,j)=reflec(:,2);j=j+1;
       clear reflec;
       Mval(iMval,:)=M(i,:);iMval=iMval+1;
     else 
       disp(' ');
       disp('  The file chosen does not contain a reflectance in COLORLAB format.');
       disp('  See SAVEREFL.');
     end
   else 
      %disp(['  El fichero ' traye ext '\' nom]);
      %disp('  no existe');
   end
 end
 reflec=RE;
else
   load(tray)
   if exist('t')
      reflec=t;
      if any(reflec(:,2)>1) 
         reflec(:,2)=reflec(:,2)/100;
      end
   end
       
    if exist('reflec')~=1
       disp(' ');
       disp(['  File ' tray ' does not contain a spectral reflectance']);
       disp('  in COLORLAB format. See SAVEREFL.');
       reflec=[];
    end
end
