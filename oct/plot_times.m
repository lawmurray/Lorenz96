% Copyright (C) 2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} plot_times ()
%
% Produce timing plots for Lorenz 96 model.
%
% @end deftypefn
%
function plot_times ()
    names = {
        'pf';
        'pmmh';
        'smc2';
    };
    titles = {
        'Particle filter';
        'PMCMC';
        'SMC^2';
    };
    for i = 1:length (names)
        file = sprintf ('%s.csv', names{i});
	subplot (1, 3, i);

	times = dlmread (file);
        x = 1:columns (times);
    	y = quantile (times, 0.5);
    	ly = quantile (times, 0.25);
    	uy = quantile (times, 0.75);

    	h = bar (y);
    	set (h, 'facecolor', [.7 .7 .7]);
	set (gca, 'xtick', x);

	% errorbar seems to produce raster lines on SVG output, do manually
    	%h = errorbar (x, y, ly, uy, '~');
    	%set (h, 'linestyle', 'none', 'color', 'k', 'linewidth', 2);
	for j = 1:length (y)
	    line ([j j], [ly(j), uy(j)], 'color', 'k',
    	        'linewidth', 2);
            line ([j - 0.2, j + 0.2], [ly(j) ly(j)], 'color', 'k',
    	        'linewidth', 2); 
            line ([j - 0.2, j + 0.2], [uy(j) uy(j)], 'color', 'k',
    	        'linewidth', 2); 
        end

	title (titles{i});
	xlabel ('Configuration');
	if i == 1
	    ylabel ('Execution time (s)');
        end
	grid on;
	box off;
	ax = axis();
	axis([0 x(end) + 1 ax(3) ax(4)]);
    end
end
