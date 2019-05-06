spider_plot(P, P_labels, axes_interval, axes_precision, varargin)
creates a spider web or radar plot with an axes specified for each column

spider_plot(P, P_labels, axes_interval, axes_precision) creates a spider
web plot using the points specified in the array P. The column of P
contains the data points and the rows of P contain the multiple sets of
data points. Each point must be accompanied by a label specified in the
cell P_labels. The number of intervals that separate the axes is
specified by axes_interval. The number of decimal precision points is
specified by axes_precision.

P - [vector | matrix]
P_labels - [cell of string]
axes_interval - [integer]
axes_precision - [integer]

spider_plot(P, P_labels, axes_interval, axes_precision, line_spec) works
the same as the function above. Additional line properties can be added
in the same format as the default "plot" function in MATLAB.

line_spec - [character vector]

%%%%%%%%%%%%%%%%%%% Example of a Generic Spider Plot %%%%%%%%%%%%%%%%%%%
% Clear workspace
close all;
clearvars;
clc;

% Point properties
num_of_points = 6;
row_of_points = 4;

% Random data
P = rand(row_of_points, num_of_points);

% Scale points by a factor
P(:, 2) = P(:, 2) * 2;
P(:, 3) = P(:, 3) * 3;
P(:, 4) = P(:, 4) * 4;
P(:, 5) = P(:, 5) * 5;

% Make random values negative
P(1:3, 3) = P(1:3, 3) * -1;
P(:, 5) = P(:, 5) * -1;

% Create generic labels
P_labels = cell(num_of_points, 1);

for ii = 1:num_of_points
    P_labels{ii} = sprintf('Label %i', ii);
end

% Figure properties
figure('units', 'normalized', 'outerposition', [0 0.05 1 0.95]);

% Axes properties
axes_interval = 2;
axes_precision = 1;

% Spider plot
spider_plot(P, P_labels, axes_interval, axes_precision,...
    'Marker', 'o',...
    'LineStyle', '-',...
    'LineWidth', 2,...
    'MarkerSize', 5);

% Title properties
title('Sample Spider Plot',...
    'Fontweight', 'bold',...
    'FontSize', 12);

% Legend properties
legend('show', 'Location', 'southoutside');
