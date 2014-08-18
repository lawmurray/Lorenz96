% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 2272 $
% $Date: 2011-12-12 19:53:13 +1100 (Mon, 12 Dec 2011) $

% -*- texinfo -*-
% @deftypefn {Function File} {} bi_image_bifurc (@var{file}, @var{param},
% @var{param_coord}, @var{state}, @var{state_coord}, @var{ps}, @var{ts})
%
% Plot bifurcation image using output of prior sample.
%
% @end deftypefn
%
function bi_image_bifurc (file, param, param_coord, state, state_coord, ps, ts)    
    % constants
    RES_X = 1280;
    RES_Y = 800;
        
    % check arguments
    if nargin < 4 || nargin > 7
        print_usage ();
    end
    if nargin < 5
        state_coord = [];
    elseif !isempty (state_coord) && !isvector (state_coord)
        error ('state_coord must be a vector');
    end
    if nargin < 6
        ps = [];
    elseif !isempty (ps) && !isvector (ps)
        error ('ps must be a vector');
    end
    if nargin < 7
       ts = [];
    elseif !isempty (ts) && !isvector (ts)
        error ('ts must be a vector');
    end
    
    % data
    x = bi_read_var (file, param, param_coord, ps, ts);
    y = bi_read_var (file, state, state_coord, ps, ts);
    
    % data extents
    xmin = 0; %min(x);
    xmax = 12; %max(x);
    ymin = -10; %min(y(:));
    ymax = 10; %max(y(:));
    xs = linspace(xmin, xmax, RES_X + 1);
    ys = linspace(ymin, ymax, RES_Y + 1);
    
    % bin
    [n1,ii] = histc(x, xs);
    n1 = n1(1:end-1); % chop off last bin
    n2 = histc(y, ys, 2);
    for i = 2:8
        y = bi_read_var (file, state, i, ps, ts);
	n2 = n2 + histc(y, ys, 2);
    end
    n3 = accumdim (ii, n2, 1)';
    n3 = n3 ./ repmat(n1', rows (n3), 1);
    for i = 1:columns (n3)
        mn = min (n3(:,i));
	mx = max (n3(:,i));
	n3(:,i) = (n3(:,i) - mn)/(mx - mn);
    end

    % plot
    imagesc (xs, ys, n3);
    axis([xmin xmax ymin ymax]);
    set(gca,'YDir','normal');
end
