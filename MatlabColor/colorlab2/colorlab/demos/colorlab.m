
p=which('ciergb.mat');
path_data=p(1:end-18);

[T_l,Yw,Mbx]=loadsysm([path_data,'systems\ciexyz']);
[tm,a,g]=loadmonm([path_data,'monitor\std_crt'],Mbx);

clc
K=0;
%while K<10
while K<9
   close all;
   K=menmen;
   if K==1
      l=menu('Choose:','Calibration Demo','Monitor Data');
      if l==1
         clc
         democal;
         disp(' ')
         disp(' ')
         disp(' ')
         disp('   Press any key to turn to')
         disp('   the main menu...')
         pause
      else
         clc
         repmon;
         disp(' ')
         disp(' ')
         disp(' ')
         disp('   Press any key to turn to')
         disp('   the main menu...')
         pause
      end 
   elseif K==2
      clc
      demogen
   elseif K==3
      clc
      %cd('c:\matlab\toolbox\colorlab\colordat\images\images\')
      demodes;
      clc      
      disp(' ')
      disp(' ')
      disp(' ')
         disp('   Press any key to turn to')
         disp('   the main menu...')
      pause
   elseif K==5
      clc
      %cd('c:\matlab\toolbox\colorlab\colordat\images\im20\')
      demoilu;
   elseif K==4
      %cd('c:\matlab\toolbox\colorlab\colordat\images\im20\')
      [lpy,Ymax0,s_lum,s_pur,txtlum2,txtpur2,im]=demosat;
      clc
      disp(' ')
      disp(' ')
      disp(' ')
         disp('   Press any key to turn to')
         disp('   the main menu...')
      pause
      K=1;
   elseif K==6
      clc
      %cd('c:\matlab\toolbox\colorlab\colordat\images\im200\')
      demofilt;
      clc
   elseif K==7
      clc
      %cd('c:\matlab\toolbox\colorlab\colordat\images\im200\')
      demovq;
%   elseif K==8
%      clc
%      demored;
%      clc
%      disp(' ')
%      disp(' ')
%      disp(' ')
%      disp('   PULSA CUALQUIER TECLA PARA')
%      disp('   VOLVER AL MENÚ PRINCIPAL...')
%      pause 
   elseif K==8
      clc;
      repsis;
         clc 
         disp(' ')
         disp(' ')
         disp(' ')
         disp('   Press any key to turn to')
         disp('   the main menu...')
      pause
   else
      K=9;
   end
end