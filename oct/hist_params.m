% Copyright (C) 2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} hist_params
%
% Produce plot of parameter posteriors for Lorenz '96 model.
% @end deftypefn
%
function hist_params ()
    posteriorFile = 'results/posterior.nc';

    % work out appropriate sample range
    nc = netcdf (posteriorFile, 'r');
    P = length (nc('np'));
    ps = [5000:P];

    names = {
        'F';
        'sigma2';
    };
    titles = {
        'F';
        '{\sigma^2}';
    };
    prior_pdfs = {
        'unifpdf';
        'invgampdf';
    };
    prior_params = {
        {8, 12};
        {2, 0.25};
    };

    for i = 1:length (names)
        subplot(1, length (names), i);
        bi_hist (posteriorFile, names{i}, [], ps, [], 15);
	hold on;
	x = linspace(axis()(1), axis()(2), 500);
        bi_plot_prior (x, prior_pdfs{i}, prior_params{i});
	xlabel(titles{i});
	ylabel(sprintf("p(%s)", titles{i}));
	grid on;
	box off;
	hold off;
    end
end
