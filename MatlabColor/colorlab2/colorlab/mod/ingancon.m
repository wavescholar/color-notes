function lms=ingancon(lmstgan,lmsf,modelo,pesos,sigma)

% INGANCON is the inverse of GANCON. The functions undoes the effect
% of the gain-control on the cone-responses computed with MODEL.
%
% SYNTAX
% ----------------------------------------------------------------------------
% LMS=INGANCON(LMSTGAN,LMSBACK,MODEL,WEIGHTS,SIGMA)
% 
% LMSTGAN = Gain-controlled cone-responses.
%           For N colours, this is a Nx3 matrix.
% LMSBACK = Tristimulus values of the background in the lineal cone-space of 
%           the corresponding model. The size of LMSF must be the same than that
%           of LMST. If all the stimuli in LMST are seen against the same 
%           background, this must be repeated the appropriate number of times.
%
% MODEL = Integer (1-13) identifying the model. See XYZ2ATD for details.
%
% WEIGHTS = [WT WB]. Contributions of test and background to the adapting stimulus
%           See XYZ2CON for details.
%
% SIGMA = Scalar controlling the non-linearity. See XYZ2CON for details.
%
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% GANCON.
%
%Function used by CON2XYZ



m=size(lmstgan);
if modelo<=7 | modelo==12
	noise=zeros(m);
elseif modelo==8
	noise=0.00004;
elseif modelo==9 | modelo==10
        noise=[0.002 0.003 0.00135];
elseif modelo==11
        noise=[0.024 0.036 0.31];
end

imax=m(1);

if modelo<=7 | modelo==12
	lms=lmstgan;
elseif modelo==8
	if pesos(1)==0
         B=pesos(2)*lmsf+noise;
         lms=(0.05+B).*lmstgan./(0.05+0.01*B);
   else
         A=lmstgan;
         B=pesos(2)*lmsf+(1-pesos(1))*noise;
         a=0.01*pesos(1);	
         b=(0.05+0.01*B-pesos(1)*A);
         c=-A.*(0.05+B);
         lms1=(-b+sqrt(b.*b-4*a.*c))./(2*a);
         lms2=(-b-sqrt(b.*b-4*a.*c))./(2*a);
         for i=1:3
           sign1=+(lms1(:,i)<0);
	        sign2=+(lms2(:,i)<0);
           lms(:,i)=lms1(:,i).*(1-sign1)+lms2(:,i).*(1-sign2);
         end
	end
elseif modelo>=9 & modelo<12
     n=noise(ones(m(1),1),:);
     if pesos(2)==0
         lms=lmstgan.*(sigma)./(sigma-lmstgan);
     elseif pesos(1)==0
         lms=lmstgan.*(sigma+n+(pesos(2)*lmsf).^0.7)/sigma;
      else
        opciones = optimset('MaxIter',6000,'TolX',1e-12,'TolFun',1e-12,'Display','off') ;
     for i=1:m(2)
         f=['norm(' num2str(sigma) '*abs(x)./(' num2str(sigma) '+ [' num2str(noise(1)) ' ' num2str(noise(2))  ' ' num2str(noise(3)) ']+(' num2str(pesos(1)) '*((abs(x)-[' num2str(noise(1)) ' ' num2str(noise(2))  ' ' num2str(noise(3)) ']).^(1/0.7))+' num2str(pesos(2)) '*[' num2str(lmsf(1,i)) ' ' num2str(lmsf(2,i)) ' ' num2str(lmsf(3,i)) ']).^0.7)-[' num2str(lmstgan(1,i)) ' ' num2str(lmstgan(2,i)) ' ' num2str(lmstgan(3,i)) '])' ];
         lms(i,:)=fminsearch(f,lmsf(:,i)',opciones);
      end;
      lms=abs(lms);
     end
end
