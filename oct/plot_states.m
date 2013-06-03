% Copyright (C) 2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} plot_states (@var{is})
%
% Produce plots of state posteriors for Lorenz 96 model.
%
% @itemize @var{is} Dimension indices.
%
% @end deftypefn
%
function plot_states (is)
    priorFile = 'results/prior.nc';
    posteriorFile = 'results/posterior.nc';
    predictionFile = 'results/prediction.nc';
    obsFile = 'data/obs_sparse.nc';
    ps = [20000:100000];

    for i = 1:length (is)
        subplot (length (is)/2, 2, i);
        bi_plot_quantiles (priorFile, 'x', is(i));
	pos = get (gca, 'position');
	pos(1) = pos(1) - 0.02;
	pos(2) = pos(2) - 0.04;
	pos(3) = pos(3) + 0.04;
	pos(4) = pos(4) + 0.08;
	set (gca, 'position', pos);

	grid on;
	box off;
        hold on;
        bi_plot_quantiles (posteriorFile, 'x', is(i), ps);
        bi_plot_quantiles (predictionFile, 'x', is(i), ps);
        if is(i) <= 4
           bi_plot_paths (obsFile, 'y', is(i));
        end
        hold off

        ylabel (nice_name(sprintf('x_%d', is(i))));
	if i <= length (is) - 2  % turn off xlabel and tics if not on bottom
	    set (gca, 'xticklabel', {});
	else
            xlabel ('t');
	end
	if mod (i, 2) == 0  % turn off ytics if not on left
	    set(gca, 'yticklabel', {});
	end
	if i == 2
	   legend ("prior", "", "posterior", "", "prediction", "", "observed");
        end
    end
end
