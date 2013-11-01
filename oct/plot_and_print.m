% Copyright (C) 2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} plot_and_print ()
%
% Produce plots and print for manuscript.
% @end deftypefn
%
function plot_and_print ()
    figDir = 'figs';
    mkdir(figDir);

    % state estimates
    set (figure(1), 'papersize', [9 8]);
    set (figure(1), 'paperposition', [0 0 9 8]);
    orient ('portrait');
    plot_states(1:4);
    saveas (figure(1), sprintf('%s/state1.svg', figDir));

    plot_states(5:8);
    saveas (figure(1), sprintf('%s/state2.svg', figDir));

    set (figure(1), 'papersize', [3.5 8]);
    set (figure(1), 'paperposition', [0 0 3.5 8]);
    orient ('landscape');
    hist_params;
    saveas (figure(1), sprintf('%s/param.svg', figDir));

    %plot_times;
    %saveas (figure(1), sprintf('%s/time.svg', figDir));

    %plot_bifurc;
    %saveas (figure(1), sprintf('%s/bifurc.svg', figDir));
end
