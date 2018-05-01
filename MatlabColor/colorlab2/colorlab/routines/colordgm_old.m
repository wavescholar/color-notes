function colordgm(C,cara,f_igual,utri,varargin);

% COLORDGM plots colors in the chromatic diagram.
% 
% COLORDGM represents a set of colors together with the spectral colors in the
% chromatic diagram of the current color space.
% COLORDGM accepts colors in any tristimulus-based representation: 
% tristimulus vectors, T, chromatic coordinates and luminance, (t,Y), or
% dominant wavelength, purity and luminance, (l,P,Y).
%
% COLORDDGM may also plot two convenient 'all positive' triangles: 
% - The limits of colors with positive tristimulus values in the current basis.
% - The limits of the color gammut reproducible in the current monitor (given by 
%   the chromaticities of the guns with maximum saturation).
% 
% COLORDGM allows the user to control many parameters of the plot: 
% - the color and width of the lines. 
% - the font size in the axis and labels.
% - the symbols representing the colors, its size and color. 
% - a line may be plotted through the color points. 
% - numbers may be given to the plotted colors.
% - the auxiliar color regions (the all positive triangles) may be enabled or disabled.
% 
% This function may be used in two ways: 
% - Easy. Only 5 colorimetric parameters and default graphic parameters.
% - Comprehensive. 5 colorimetric parameters and 8 graphic parameters.
% If you dont specify the optional graphic parameters the easy way is taken.
% 
% SYNTAX
% ---------------------------------------------------------------------------------------
% 
% Easy:          colordgm(C,characteriz,T_l,Yw);
% Comprehensive: colordgm(C,characteriz,T_l,Yw,'parameter1',value1,'parameter2',value2,...);
%
%
% C            = N*3 matrix (color-like variable) containing the set of N colors 
%
% characteriz  = Number indicating the color characterization used in the matrix C.
%                characteriz = 1  ->  Tristimulus vectors
%                characteriz = 2  ->  chromatic coordinates and luminance
%                characteriz = 3  ->  dom. wavelength, excitation purity and luminance
%                characteriz = 4  ->  dom. wavelength, chromatic purity and luminance
% 
% T_l           = Color Matching Functions in the current basis (M*4 spectral-like matrix).
%
% Yw            = Trichromatic units (1*3 vector).
%
% Possible parameters are the following:
%
% symb          = String containing the symbol to be used to represent the colors.
%
% show_lin      = Parameter to enable/disable the plot of a line through the 
%                 color points.
%                 if show_lin = 1 -> Plots the line 
%                 if show_lin = 0 -> No line
%
% show_numb     = Parameter to enable/disable the plot of numbers to identify the colors.
%                 if show_numb = 1 -> Plots the numbers
%                 if show_numb = 0 -> No number
%
% showtriang = Parameter to enable/disable the plot of the 'all positive' triangles 
%              if showtriang = 0 
%                  REPLOCUS doesnt plot any triangle at all 
%              if showtriang = 1 
%                  It ONLY plots the triangle of the colors with all positive  
%                  tristimulus values. 
%              if showtriang = {2,tm} 
%                  It ONLY plots the triangle of generable colors. 
%                  tm are the chromaticity coordinates of the monitor phosphors,
%                  as obtained with LOADMON and LOADMONM
%              if showtriang = {3,tm} 
%                  It plots BOTH triangles. 
% 
% linecolors     = 8*3 matrix containing the MATLAB notation of the color for the
%                  following objects:
%                  1- Lines of the bounding box
%                  2- Locus of spectral colors
%                  3- Axis of the plot
%                  4- Triangle of primaries of the system
%                  5- Triangle of 'primaries' of the monitor
%                  6- Line through the colors.
%                  7- Symbols representing the colors
%                  8- Numbers associated to the colors.
%
% linewidths = 1*6 vector containing the widths of the lines (in the order given above). 
%              The LineWidth of the symbols and the numbers cannot be selected becuse
%              they are not lines!
%
% linestyles = 6*2 matrix containing the strings that define the style of 
%              the lines (in the order given above) according to the convention
%              used in plot.m. 
%              The LineStyle of the symbols and the numbers cannot be selected becuse
%              they are not lines!
%              
% sizes      = 1*4 vector containing the sizes of:
%              1- the numbers in the axis. 
%              2- the labels of the axis.
%              3- the symbols used to represent the colors.
%              4- the numbers used to represent the colors.
%
%
% EXAMPLE: 
%         colordgm([1 1 1],1,T_l,Yw,'symb','s','sizes(3)',8)
%         colordgm([1 1 1],1,T_l,Yw,'symb','s','sizes(3)',8,'showtriang',{2,tm})
%
%
% REQUIRED FUNCTIONS
% ---------------------------------------------------------------------------------------
% tri2coor.m   niv2coor.m    mini.m  ganadora.m
%  lp2coor.m   replocus.m    maxi.m
%

%Parámetros válidos
parval=strvcat('symb','show_lin','show_numb','showtriang','linecolors','linewidths','linestyles','sizes');
tammax=[1 1;1 1;1 1;1 2;8 3;1 6;6 2;1 4];
%Valores por defecto
    %symb 
    symb='o'; 
    %show_lin 
    show_lin=0; 
    %show_numb 
    show_numb=0; 
    %showtriang 
    showtriang=1; coor=[];
    %linecolors 
    linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0 0 0;0 0 0;0 0 0]; 
    %linewidths 
    linewidths=[0.5 0.5 0.5 0.5 0.5 0.5]; 
    %linestyles 
    linestyles=['- ';'- ';'- ';'- ';': ';'- ']; 
    %sizes 
    sizes=[10 12 1.5 8]; 

if nargin<4
   disp('Not enough input arguments')
   doit=0;
   tm=[];
elseif nargin==4
   doit=1; 
   tm=[];
elseif nargin==5
   showtriang=3;
   doit=1;
   eval(['tm=varargin{1};'])
else
   tm=[];
   doit=1;
   cuantasvar=size(varargin,2);
    for i=1:2:cuantasvar
       variable=varargin{i};
       if iscell(varargin{i+1}) & size(varargin{i+1},2)==2
          nuevo=varargin{i+1};
          eval([variable '=nuevo{1};']);
          tm=nuevo{2};
       else
          eval([variable '=varargin{i+1};']);
       end
       hayparentesis=findstr(variable,'(');
       if isempty(hayparentesis)
          var=variable;
       else
          var=variable(1:(hayparentesis-1));
       end
       siono=strmatch(var,parval,'exact');
       if isempty(siono);
          alt=strmatch(var,parval);   
          disp(['Warning: ' var ' is not a valid parameter.']);
          if not(isempty(alt))
             disp(['Try instead ' parval(alt(1),:)]);
          else
             disp('Valid parameters are: ');
             for ip=1:size(parval,1)
                disp(['   ' parval(ip,:)])
             end
          end
       else
          if not(isempty(hayparentesis))
             haycoma=findstr(variable,',');
             hayparentesisf=findstr(variable,')');
             if isempty(haycoma) 
                final=hayparentesisf-1;
                eval(['que(1)=[max(' variable(hayparentesis+1:final) ')<=tammax(siono,2)];'])
             else final=haycoma-1;
             end
             if not(isempty(haycoma))
                eval(['que(1)=[max(' variable(hayparentesis+1:final) ')<=tammax(siono,1)];'])
                haypuntos=findstr(variable,':');
                if isempty(haypuntos)
                   eval(['que(2)=[max(' variable(haycoma+1:hayparentesisf-1) ')<=tammax(siono,2)];'])
                end
             end
             que=all(que);
             coletilla=' matrix.';      
         else 
            que=all(size(eval(variable))<=tammax(siono,:));
            if siono==1;
               que=all([que isstr(eval(variable))]);
               coletilla=' string.';
               if not(isstr(eval(variable)))
                  doit=0;
               end
            else
               que=all([que not(isstr(eval(variable)))]);
               if not(isstr(eval(variable)))
                  coletilla=' matrix.';
               else
                  coletilla=' matrix, not a string';doit=0;
               end
            end
          end        
          if que==0
             disp(['Option error: variable ' var ' must be a [' num2str(tammax(siono,:)) ']' coletilla]); 
             doit=0;
          end
          
       end
    end
    if exist('tm')==0;tm=[];end
end   

if doit==1

if cara==1
    t=tri2coor(C,utri); 
    t=t(:,1:2);
elseif cara==2
    t=C(:,1:2);
elseif cara==3
    t=lp2coor(C,1,f_igual,utri); 
    t=t(:,1:2);
else
    t=lp2coor(C,2,f_igual,utri);
    t=t(:,1:2);
end

limits=[min(t(:,1)) max(t(:,1)) min(t(:,2)) max(t(:,2))];

%replocus(f_igual,pintatri,coor,fig,color),hold on
replocus(f_igual,tm,limits,showtriang,linecolors(1:5,:),linewidths(1:5),linestyles(1:5,:),sizes(1:2));
hold on

%if color==0
%   plot(t(:,1),t(:,2),'k.');
%   h=get(fig,'Children');
%   hh=get(h,'Children');
%   set(hh,'MarkerSize',3);
%   hold off
%else

h=plot(t(:,1),t(:,2));
if show_lin==0 set(h,'LineStyle','none');end
set(h,'Marker',symb,'MarkerFaceColor',linecolors(7,:),'MarkerEdgeColor',linecolors(7,:),'MarkerSize',sizes(3));
%end
if (show_lin==1)&(show_numb==0)
   
  % h=plot(t(:,1),t(:,2));
   set(h,'Color',linecolors(6,:),'LineStyle',linestyles(6,:),'LineWidth',linewidths(6));
elseif (show_lin==0)&(show_numb==1)
   l=size(C);
   l=l(1);
   for i=1:l
       h=text(t(i,1)+0.01,t(i,2)+0.01,int2str(i));
       set(h,'Color',linecolors(8,:),'FontSize',sizes(4));
   end    
    
elseif (show_lin==1)&(show_numb==1)
   
   h=plot([t(:,1);t(1,1)],[t(:,2);t(1,2)]);
   set(h,'Color',linecolors(6,:),'LineStyle',linestyles(6,:),'LineWidth',linewidths(6));
   
   
   l=size(C);
   l=l(1);
   for i=1:l
       h=text(t(i,1)+0.01,t(i,2)+0.01,int2str(i));
       set(h,'Color',linecolors(8,:),'FontSize',sizes(4));
   end    
end
hold off

end