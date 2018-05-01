function map = cmgamma(cm,gtable)
%CMGAMMA Gamma correct colormap.
%	CMGAMMA(MAP,GTABLE) applies the gamma correction in the matrix
%	GTABLE to the colormap MAP and installs it as the current
%	colormap.  As for the TABLE1 function, GTABLE can be a m-by-2
%	or m-by-4 matrix.  If GTABLE is m-by-2, then CMGAMMA applies
%	the same correction to all three components of the colormap.
%	If GTABLE is m-by-4, then CMGAMMA applies the correction in
%	the columns of GTABLE to each component of the colormap separately.
%
%	CMGAMMA(MAP) invokes the function CMGAMDEF(COMPUTER) to define the
%	gamma correction table.  You can install your own default table
%	by providing a CMGAMDEF M-file on your path before this toolbox.
%
%	CMGAMMA or CMGAMMA(GTABLE) applies either the default gamma
%	correction table or GTABLE to the current colormap.
%
%	NEWMAP = CMGAMMA(...) returns the corrected colormap but does
%	not apply it.
%
%	See also CMGAMDEF, TABLE1.

%	Clay M. Thompson 1-19-93
%	Copyright (c) 1993 by The MathWorks, Inc.
%	$Revision: 1.11 $  $Date: 1993/09/08 16:34:50 $

error(nargchk(0,2,nargin));
if nargin==0, cm = colormap; end
if nargin<2, 
  if size(cm,2)~=3, 
    gtable = cm; cm = colormap; 
  else
    gtable = cmgamdef(computer);
  end
end

if size(gtable,2)==2, gtable = [gtable(:,1) gtable(:,2)*ones(1,3)]; end
if size(gtable,2)~=4, error('GTABLE must be a N-by-2 or N-by-4 matrix.'); end
if size(cm,2)~=3, error('MAP must be a N-by-3 colormap.'); end
if min(min(gtable))< 0 | max(max(gtable))>1,
  error('GTABLE must contain values between 0.0 and 1.0.');
end

% Apply gamma correction to each column of cm.
cm(:,1) = table1(gtable(:,[1 2]),cm(:,1));
cm(:,2) = table1(gtable(:,[1 3]),cm(:,2));
cm(:,3) = table1(gtable(:,[1 4]),cm(:,3));

if nargout==0, colormap(cm), return, end 
map = cm;


