function gtable = cmgamdef(c)
%CMGAMDEF Default gamma correction table.
%	CMGAMDEF('computer') returns the default gamma correction 
%	table for the computer in the string computer.  See the
%	function COMPUTER for possiblities.  CMGAMDEF is called
%	by CMGAMMA.
%
%	CMGAMDEF returns the default gamma correction table for
%	the computer currently running MATLAB.
%
%	See also CMGAMMA, COMPUTER.

%	Clay M. Thompson 1-19-93
%	Copyright (c) 1993 by The MathWorks, Inc.
%	$Revision: 1.8 $  $Date: 1993/09/08 16:24:52 $

if nargin == 0, c = computer; end
if ~isstr(c), error('Input argument must be a string.'); end

% Note: the gtable can have any number of rows.  See TABLE1 and
% CMGAMMA for details.
gtable = [0:.05:1]'*ones(1,4);
