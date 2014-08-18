% Copyright (C) 2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} plot_bifurc ()
%
% Produce bifurcation plots for Lorenz '96 model.
%
% @end deftypefn
%
function plot_bifurc ()
    colormap(flipud(gray));
	 
    subplot(1, 2, 1);
    bi_image_bifurc('results/bifurc_deterministic.nc', 'F', [], 'x', 1, [], [40:801]);
    axis('tight');
    title('Deterministic');
    xlabel ('F');
    ylabel ('x');
    axis([0 12 -5 10]);

    subplot(1, 2, 2);
    bi_image_bifurc('results/bifurc_stochastic.nc', 'F', [], 'x', 1, [], [40:801]);
    axis('tight');
    title ('Stochastic');
    xlabel ('F');
    axis([0 12 -5 10]);
end
