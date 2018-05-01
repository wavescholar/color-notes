function colorspc(C,cara,f_igual,utri,varargin);

% COLORSPC plots colors in the tristimulus space
% 
% COLORSPC accepts colors in any tristimulus-based color description:
% tristimulus vectors, T, chromatic coordinates and luminance, (t,Y), or
% dominant wavelength, purity and luminance, (l,P,Y).
% COLORSPC may also plot the chromatic diagram in the tristimulus space.
%
% COLORSPC allows the user to control many parameters of the plot: 
% - the color and width of the lines. 
% - the font size in the axis and labels.
% - the symbols representing the colors, its size and color. 
% - vector lines may be associated to the color points.
% - a line may be plotted through the color points. 
% - numbers may be given to the plotted colors. 
% - the different elements of the chromatic diagram may be enabled or disabled. 
% 
% This function may be used in two ways: 
% - Easy. Only 5 colorimetric parameters and default graphic parameters.
% - Comprehensive. 5 colorimetric parameters and different graphic parameters among
% a choice of 11.
% If you dont specify the optional graphic parameters the easy way is taken.
% 
% SYNTAX
% ---------------------------------------------------------------------------------------
%
% Easy:         
% colorspc(C,characteriz,T_l,Yw);
%
% Comprehensive: 
% colorspc(C,characteriz,T_l,'parameter1',value1,'parameter2',value2...);
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
% tm            = Chromaticities of the monitor. 7*N matrix with the calibration data.
%                (see CALIBRAT.M or LOADMON.M).
%
% Possible parameters are the following:
%
% symb          = String containing the symbol to be used to represent the colors.
%
% lim_axis      = Automatic/manual axis limits
%                 if lim_axis=0 -> Automatic determination of the limits
%                 else, lim_axis must be a 1*6 vector containing the limits of 
%                 the 3D axis as in the axis.m function.
%
% show_box      = Bounding box
%                 if show_box=1 the box bounding the colors T is shown (default value)
%                 if show_box=2 the box bounding all colors in the figure is shown 
%                 if show_box=0 the bounding box is not shown (best when colorspc
%                 is used more than once to plot different groups of colours in the
%                 same figure;use show_box=2 in the last plot)
%
% showvectors   = Parameter to enable/disable the plot of a vector line for each color 
%                 if showvectors = 1 -> Plot vector lines
%                 if showvectors = 0 -> No vector lines
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
% showdiag      = Parameter to enable/disable the plot of the chromatic diagram 
%                 if showdiag = 1 -> Plots the diagram
%                 if showdiag = 0 -> Doesnt plot the diagram
% 
% showtriang = Parameter to enable/disable the plot of the 'all positive' triangles 
%              (when showdiag=0 this parameter has no effect)
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
% 
% linecolors = 9*3 matrix containing the MATLAB notation of the color for the
%              following objects: 
%              1- Lines of the bounding box
%              2- Locus of spectral colors
%              3- Axis of the plot
%              4- Triangle of primaries of the system
%              5- Triangle of 'primaries' of the monitor
%              6- Line through the colors.
%              7- Vector lines  
%              8- Symbols representing the colors
%              9- Numbers associated to the colors.
%
%              Note that you have to specify something even if you choose not
%              to plot a perticular object.
%
% linewidths = 1*7 vector containing the widths of the lines (in the order given above). 
%              The LineWidth of the symbols and the numbers cannot be selected becuse
%              they are not lines!
%
% linestyles = 7*2 matrix containing the strings that define the style of 
%              the lines (in the order given above) according to the convention
%              used in plot.m. 
%              The LineStyle of the symbols and the numbers cannot be selected becuse
%              they are not lines!
%              
% sizes  = 1*4 vector containing the sizes of:
%              1- the numbers in the axis. 
%              2- the labels of the axis.
%              3- the symbols used to represent the colors.
%              4- the numbers used to represent the colors.
%
%
%
% EXAMPLE: 
%
%  colorspc([1 1 1],1,T_l,Yw,'showvectors',1,'symb','<','sizes(3)',5,'showtriang',{3,tm})    
%  colorspc([1 1 1],1,T_l,Yw,'show_numb',1)       
%
% REQUIRED FUNCTIONS
% ---------------------------------------------------------------------------------------
% tri2coor.m
% lp2coor.m
% mini.m, maxi.m, niv2coor.m, ganadora.m
% 


if cara==1
    T=C;
elseif cara==2
    T=coor2tri(C,utri);
elseif cara==3
    t=lp2coor(C,1,f_igual,utri);
    T=coor2tri(t,utri);
else
    t=lp2coor(C,2,f_igual,utri);
    T=coor2tri(t,utri);
end 

%Parámetros válidos
parval=strvcat('lim_axis','show_box','showvectors','showdiag','symb','show_lin','show_numb','showtriang','linecolors','linewidths','linestyles','sizes');
tammax=[1 6;1 1;1 1;1 1;1 1;1 1;1 1;1 2;9 3;1 6;6 2;1 4];
simb=strmatch('symb',parval,'exact');
%Valores por defecto
   show_box=1;
   %symb 
   symb='o'; 
   %show_lin 
   show_lin=0; 
   %showvectors
   showvectors=0;
   %show_numb 
   show_numb=0; 
   %showtriang 
   showtriang=1; 
   %linecolors 
   linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.3 0.2 0;0.6 0.2 0;0.3 0.2 0;0 0 0];
   %linewidths 
   linewidths=[0.5 0.5 0.5 0.5 0.5 0.5 0.5];
   %linestyles 
   linestyles=['- ';'- ';'- ';'- ';': ';'- ';'- '];
   %sizes 
   sizes=[10 12 1.5 8]; 
   tm=[];
   doit=1;
   lim_axis=0;
   showdiag=0;   


if nargin>4
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
            if siono==simb;
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
elseif nargin<4
   disp('Not enough input arguments') 
   doit=0;
end   



if doit==1,

if showdiag==1 & (showtriang==2 | showtriang==3)
   s=size(tm);
   Nmax=tm(1,s(2));
   tm=niv2coor([Nmax Nmax Nmax],tm);
end




% Representa colores (puntos)

  h=plot3(T(:,1),T(:,2),T(:,3),symb);
  set(h,'MarkerFaceColor',linecolors(8,:),'MarkerEdgeColor',linecolors(8,:),'MarkerSize',sizes(3));
  hold on;  
% Respresenta linea uniendo los puntos (si escau)   

  if show_lin==1
     h=plot3(T(:,1),T(:,2),T(:,3));
     set(h,'Color',linecolors(6,:),'LineStyle',linestyles(6,:),'LineWidth',linewidths(6));
  end   
  
% Representa numeros (si escau)   
   
   if show_numb==1
      l=size(C);
      l=l(1);
      for i=1:l
          h=text(T(i,1)+0.01,T(i,2)+0.01,T(i,3)+0.01,int2str(i));
          set(h,'Color',linecolors(9,:),'FontSize',sizes(4));
      end
   end
   
% Respresenta vectores (si escau)   
   
   if showvectors==1
      P1=[0 0 0];
      l=size(C);
      l=l(1);
       
      for i=1:l
          PC=T(i,:);
          den=sum(PC);
          PCd=PC./[den den den];
          if (den>1)&(showdiag==1)
             % Entre el origen y el diagrama
             h=plot3([P1(1) PCd(1)],[P1(2) PCd(2)],[P1(3) PCd(3)]);
             colorpalido=linecolors(7,:)+[0.4 0.4 0.4];
             if max(colorpalido)>1
                colorpalido=colorpalido/max(colorpalido);
             end   
             set(h,'Color',colorpalido,'LineStyle',linestyles(7,:),'LineWidth',linewidths(7));
             % Mas alla del diagrama
             h=plot3([PCd(1) PC(1)],[PCd(2) PC(2)],[PCd(3) PC(3)]);
             set(h,'Color',linecolors(7,:),'LineStyle',linestyles(7,:),'LineWidth',linewidths(7));
          else
             % Entre el origen y el diagrama (color con poca luminancia...)
             h=plot3([P1(1) PC(1)],[P1(2) PC(2)],[P1(3) PC(3)]);
             set(h,'Color',linecolors(7,:),'LineStyle',linestyles(7,:),'LineWidth',linewidths(7));
          end
       end
   end  
   
% Labels  

   h1=xlabel('\it T_1');
   h2=ylabel('\it T_2');
   h3=zlabel('\it T_3');
   set(h1,'Color',linecolors(1,:),'FontSize',sizes(2));
   set(h2,'Color',linecolors(1,:),'FontSize',sizes(2));
   set(h3,'Color',linecolors(1,:),'FontSize',sizes(2),'Rotation',0);

% Representa diagrama cromatico
   
   if showdiag==1
      
      % Calculo locus
            
      locus=f_igual(:,2:4)./[sum(f_igual(:,2:4)')' sum(f_igual(:,2:4)')' sum(f_igual(:,2:4)')'];
      locus=locus(:,1:2);
      
      locus=[locus 1-locus(:,1)-locus(:,2)];
      if (showtriang==2 | showtriang==3)
         tm=[tm 1-tm(:,1)-tm(:,2)];
      end
      
      % Pinta Locus 
      
      h=plot3(locus(:,1),locus(:,2),locus(:,3)); 
      set(h,'Color',linecolors(2,:),'LineStyle',linestyles(2,:),'LineWidth',linewidths(2));
      
      lonloc=length(locus(:,1)); 

      h=plot3([locus(1,1) locus(lonloc,1)],[locus(1,2) locus(lonloc,2)],[locus(1,3) locus(lonloc,3)]);
      set(h,'Color',linecolors(2,:),'LineStyle',linestyles(2,:),'LineWidth',linewidths(2));
      
      % Triangulo de primarios
      
      if (showtriang==1)|(showtriang==3)
         h=plot3([1 0],[0 0],[0 1]);
         set(h,'Color',linecolors(4,:),'LineStyle',linestyles(4,:),'LineWidth',linewidths(4));
         h=plot3([1 0],[0 1],[0 0]);
         set(h,'Color',linecolors(4,:),'LineStyle',linestyles(4,:),'LineWidth',linewidths(4));
         h=plot3([0 0],[1 0],[0 1]);
         set(h,'Color',linecolors(4,:),'LineStyle',linestyles(4,:),'LineWidth',linewidths(4));
      end
      
      % Triangulo del monitor
      
      if (showtriang==2)|(showtriang==3)
         h=plot3([tm(1,1) tm(2,1)],[tm(1,2) tm(2,2)],[tm(1,3) tm(2,3)]);
         set(h,'Color',linecolors(5,:),'LineStyle',linestyles(5,:),'LineWidth',linewidths(5));
         h=plot3([tm(2,1) tm(3,1)],[tm(2,2) tm(3,2)],[tm(2,3) tm(3,3)]);
         set(h,'Color',linecolors(5,:),'LineStyle',linestyles(5,:),'LineWidth',linewidths(5));
         h=plot3([tm(3,1) tm(1,1)],[tm(3,2) tm(1,2)],[tm(3,3) tm(1,3)]);
         set(h,'Color',linecolors(5,:),'LineStyle',linestyles(5,:),'LineWidth',linewidths(5));
      end
      
      % colores en el diagrama
      
      st=sum(T')';
      hh=plot3(T(:,1)./st,T(:,2)./st,T(:,3)./st,symb);
      
      colorpalido1=linecolors(8,:)+[0.4 0.4 0.4];
      if max(colorpalido1)>1
         colorpalido1=colorpalido1/max(colorpalido1);
      end
      set(hh,'MarkerFaceColor',colorpalido1,'MarkerEdgeColor',colorpalido1,'MarkerSize',sizes(3));
      
      % Y, si hace falta, los une con una linea y todo!
      
      if show_lin==1
         h=plot3(T(:,1)./st,T(:,2)./st,T(:,3)./st);
         colorpalido2=linecolors(7,:)+[0.4 0.4 0.4];
         if max(colorpalido2)>1
            colorpalido2=colorpalido2/max(colorpalido2);
         end
         set(h,'Color',colorpalido2,'LineStyle',linestyles(6,:),'LineWidth',linewidths(6));
      end 
      
   end
   
   %   hold off
   
   if lim_axis==0
   
   % Calculo limites
   m1=min([T(:,1);0]);
   M1=max([T(:,1);0]);
   m2=min([T(:,2);0]);
   M2=max([T(:,2);0]);
   m3=min([T(:,3);0]);
   M3=max([T(:,3);0]);
   
   if strcmp(get(gca,'NextPlot'),'add') & show_box==2
      m1=min(m1,min(get(gca,'XLim')));
      M1=max(M1,max(get(gca,'XLim')));
      m2=min(m2,min(get(gca,'YLim')));
      M2=max(M2,max(get(gca,'YLim')));
      m3=min(m3,min(get(gca,'ZLim')));
      M3=max(M3,max(get(gca,'ZLim')));
   end
      
      

   lim_axis=[m1-((M1-m1)/15) M1+((M1-m1)/15) m2-((M2-m2)/15) M2+((M2-m2)/15) m3-((M3-m3)/15) M3+((M3-m3)/15)];
end   

   
   % Bounding Box
   
   view([-15 24]),
   axis(lim_axis),
  % axis('square')
  % axis('equal'),
  %hold on   

   set(get(gcf,'Children'),'XColor',linecolors(1,:),'YColor',linecolors(1,:),'ZColor',linecolors(1,:),'LineWidth',linewidths(1),'FontSize',sizes(1),'LineStyle',linestyles(1,:));
  if show_box>0    
   P1=[lim_axis(1) lim_axis(3) lim_axis(5)];
   P2=[lim_axis(1) lim_axis(3) lim_axis(5)]+[lim_axis(2)-lim_axis(1) 0 0];
   P3=P2+[0 0 lim_axis(6)-lim_axis(5)];
   P4=P3-[lim_axis(2)-lim_axis(1) 0 0];
   P5=P1+[0 lim_axis(4)-lim_axis(3) 0];
   P6=P2+[0 lim_axis(4)-lim_axis(3) 0];   
   P7=P3+[0 lim_axis(4)-lim_axis(3) 0];
   P8=P4+[0 lim_axis(4)-lim_axis(3) 0];
   h=plot3([P1(1) P2(1)],[P1(2) P2(2)],[P1(3) P2(3)]);
   set(h,'Color',linecolors(1,:),'LineWidth',linewidths(1),'LineStyle',linestyles(1,:));
   h=plot3([P1(1) P4(1)],[P1(2) P4(2)],[P1(3) P4(3)]);
   set(h,'Color',linecolors(1,:),'LineWidth',linewidths(1),'LineStyle',linestyles(1,:));
   h=plot3([P1(1) P5(1)],[P1(2) P5(2)],[P1(3) P5(3)]);
   set(h,'Color',linecolors(1,:),'LineWidth',linewidths(1),'LineStyle',linestyles(1,:));
   h=plot3([P2(1) P3(1)],[P2(2) P3(2)],[P2(3) P3(3)]);
   set(h,'Color',linecolors(1,:),'LineWidth',linewidths(1),'LineStyle',linestyles(1,:));
   h=plot3([P2(1) P6(1)],[P2(2) P6(2)],[P2(3) P6(3)]);
   set(h,'Color',linecolors(1,:),'LineWidth',linewidths(1),'LineStyle',linestyles(1,:));
   h=plot3([P3(1) P4(1)],[P3(2) P4(2)],[P3(3) P4(3)]);
   set(h,'Color',linecolors(1,:),'LineWidth',linewidths(1),'LineStyle',linestyles(1,:));
   h=plot3([P3(1) P7(1)],[P3(2) P7(2)],[P3(3) P7(3)]);
   set(h,'Color',linecolors(1,:),'LineWidth',linewidths(1),'LineStyle',linestyles(1,:));
   h=plot3([P6(1) P7(1)],[P6(2) P7(2)],[P6(3) P7(3)]);
   set(h,'Color',linecolors(1,:),'LineWidth',linewidths(1),'LineStyle',linestyles(1,:));
   h=plot3([P6(1) P5(1)],[P6(2) P5(2)],[P6(3) P5(3)]);
   set(h,'Color',linecolors(1,:),'LineWidth',linewidths(1),'LineStyle',linestyles(1,:));
   h=plot3([P8(1) P7(1)],[P8(2) P7(2)],[P8(3) P7(3)]);
   set(h,'Color',linecolors(1,:),'LineWidth',linewidths(1),'LineStyle',linestyles(1,:));
   h=plot3([P8(1) P5(1)],[P8(2) P5(2)],[P8(3) P5(3)]);
   set(h,'Color',linecolors(1,:),'LineWidth',linewidths(1),'LineStyle',linestyles(1,:));
   h=plot3([P8(1) P4(1)],[P8(2) P4(2)],[P8(3) P4(3)]);
   set(h,'Color',linecolors(1,:),'LineWidth',linewidths(1),'LineStyle',linestyles(1,:));
  end
% Axis
   
   h=plot3([0 0],[0 0],[0 lim_axis(6)]);
   set(h,'Color',linecolors(3,:),'LineWidth',linewidths(3),'LineStyle',linestyles(3,:));
   h=plot3([0 0],[0 0],[0 lim_axis(5)]);
   set(h,'Color',linecolors(3,:),'LineWidth',linewidths(3),'LineStyle',linestyles(3,:));
   h=plot3([0 0],[0 lim_axis(4)],[0 0]);
   set(h,'Color',linecolors(3,:),'LineWidth',linewidths(3),'LineStyle',linestyles(3,:));
   h=plot3([0 0],[0 lim_axis(3)],[0 0]);
   set(h,'Color',linecolors(3,:),'LineWidth',linewidths(3),'LineStyle',linestyles(3,:));
   h=plot3([0 lim_axis(1)],[0 0],[0 0]);
   set(h,'Color',linecolors(3,:),'LineWidth',linewidths(3),'LineStyle',linestyles(3,:));
   h=plot3([0 lim_axis(2)],[0 0],[0 0]);
   set(h,'Color',linecolors(3,:),'LineWidth',linewidths(3),'LineStyle',linestyles(3,:));

   
end   
axis('equal');
%   hold off
%else       
%   figure(fig),plot3(T(:,1),T(:,2),T(:,3),'k.');
%   xlabel('\it T_1'),ylabel('\it T_2'),zlabel('\it T_3'),
%   view(viu),axis(lim_axis),ax,
%   h=get(fig,'Children');
%   hh=get(h,'Children');
%   set(hh,'MarkerSize',3);
%   hold on
%   if sionu==1
%      l=size(C);
%      l=l(1);
%      for i=1:l
%          text(T(i,1)+0.01,T(i,2)+0.01,T(i,3)+0.01,int2str(i));
%      end    
%   end
%   if vec==1
%      P1=[0 0 0]; 
%      l=size(C);
%      l=l(1);
%      for i=1:l
%          PC=T(i,:);
%          den=sum(PC);
%          PCd=PC./[den den den];
%          if den>1 
%             plot3([P1(1) PCd(1)],[P1(2) PCd(2)],[P1(3) PCd(3)],'k:');
%             plot3([PCd(1) PC(1)],[PCd(2) PC(2)],[PCd(3) PC(3)],'k-');
%          else
%             plot3([P1(1) PC(1)],[P1(2) PC(2)],[P1(3) PC(3)],'k:');
%          end
%       end    
%   end
%   
%   P1=[lim_axis(1) lim_axis(3) lim_axis(5)];
%   P2=[lim_axis(1) lim_axis(3) lim_axis(5)]+[lim_axis(2)-lim_axis(1) 0 0];
%   P3=P2+[0 0 lim_axis(6)-lim_axis(5)];
%   P4=P3-[lim_axis(2)-lim_axis(1) 0 0];
%   P5=P1+[0 lim_axis(4)-lim_axis(3) 0];
%   P6=P2+[0 lim_axis(4)-lim_axis(3) 0];   
%   P7=P3+[0 lim_axis(4)-lim_axis(3) 0];
%   P8=P4+[0 lim_axis(4)-lim_axis(3) 0];
%   plot3([P1(1) P2(1)],[P1(2) P2(2)],[P1(3) P2(3)],'k-');
%   plot3([P1(1) P4(1)],[P1(2) P4(2)],[P1(3) P4(3)],'k-');
%   plot3([P1(1) P5(1)],[P1(2) P5(2)],[P1(3) P5(3)],'k-');
%   plot3([P2(1) P3(1)],[P2(2) P3(2)],[P2(3) P3(3)],'k-');
%   plot3([P2(1) P6(1)],[P2(2) P6(2)],[P2(3) P6(3)],'k-');
%   plot3([P3(1) P4(1)],[P3(2) P4(2)],[P3(3) P4(3)],'k-');
%   plot3([P3(1) P7(1)],[P3(2) P7(2)],[P3(3) P7(3)],'k-');
%   plot3([P6(1) P7(1)],[P6(2) P7(2)],[P6(3) P7(3)],'k-');
%   plot3([P6(1) P5(1)],[P6(2) P5(2)],[P6(3) P5(3)],'k-');
%   plot3([P8(1) P7(1)],[P8(2) P7(2)],[P8(3) P7(3)],'k-');
%   plot3([P8(1) P5(1)],[P8(2) P5(2)],[P8(3) P5(3)],'k-');
%   plot3([P8(1) P4(1)],[P8(2) P4(2)],[P8(3) P4(3)],'k-');
%   plot3([0 0],[0 0],[0 lim_axis(6)],'k:');
%   plot3([0 0],[0 0],[0 lim_axis(5)],'k:');
%   plot3([0 0],[0 lim_axis(4)],[0 0],'k:');
%   plot3([0 0],[0 lim_axis(3)],[0 0],'k:');
%   plot3([0 lim_axis(1)],[0 0],[0 0],'k:');
%   plot3([0 lim_axis(2)],[0 0],[0 0],'k:');
%   
%   
%   if rep==1
%      locus=[locus 1-locus(:,1)-locus(:,2)];
%      tm=[tm 1-tm(:,1)-tm(:,2)];
%      lonloc=length(locus(:,1));
%      plot3(locus(:,1),locus(:,2),locus(:,3),'k-')
%      plot3([locus(1,1) locus(lonloc,1)],[locus(1,2) locus(lonloc,2)],[locus(1,3) locus(lonloc,3)],'k-')    
%      plot3([1 0],[0 0],[0 1],'b-');
%      plot3([1 0],[0 1],[0 0],'b-');
%      plot3([0 0],[1 0],[0 1],'b-');
%      plot3([tm(1,1) tm(2,1)],[tm(1,2) tm(2,2)],[tm(1,3) tm(2,3)],'b-');
%      plot3([tm(2,1) tm(3,1)],[tm(2,2) tm(3,2)],[tm(2,3) tm(3,3)],'b-');
%      plot3([tm(3,1) tm(1,1)],[tm(3,2) tm(1,2)],[tm(3,3) tm(1,3)],'b-');
%      st=sum(T')';
%      plot3(T(:,1)./st,T(:,2)./st,T(:,3)./st,'k.')
%      h=get(fig,'Children');
%      hh=get(h,'Children');
%      set(hh,'MarkerSize',3);
%   end
%   hold off
%end

set(gca,'NextPlot','replace');
set(gcf,'NextPlot','replace');