function p = chi2cdf(x,v)
%CHI2CDF Chi-square cumulative distribution function.
%	P = CHI2CDF(X,V) returns the chi-square cumulative distribution
%	function with V degrees of freedom at the values in X.
%	The chi-square density function with V degrees of freedom,
%	is the same as a gamma density function with parameters V/2 and 2.
%
%	The size of P is the common size of X and V. A scalar input   
%	functions as a constant matrix of the same size as the other input.	 

%	References:
%	   [1]  M. Abramowitz and I. A. Stegun, "Handbook of Mathematical
%	   Functions", Government Printing Office, 1964, 26.4.

%	Copyright (c) 1993 by The MathWorks, Inc.
%	$Revision: 1.1 $  $Date: 1993/05/24 18:53:49 $

if   nargin < 2, 
    error('Requires two input arguments.');
end

[errorcode x v] = distchck(2,x,v);

if errorcode > 0
    error('The arguments must be the same size or be scalars.');
end
    
% Call the gamma distribution function. 
p = gamcdf(x,v/2,2);

% Return NaN if the degrees of freedom is not a positive integer.
k = find(v < 0  |  round(v) ~= v);
if any(k)
    p(k) = NaN * ones(size(k));
end
