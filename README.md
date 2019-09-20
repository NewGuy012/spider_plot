# spider_plot
spider_plot Create a spider or radar plot with individual axes.

## Syntax:
  spider_plot(P)
  spider_plot(P, axes_labels)
  spider_plot(P, axes_labels, axes_interval)
  spider_plot(P, axes_labels, axes_interval, axes_precision)
  spider_plot(P, axes_labels, axes_interval, axes_precision, axes_limits)
  spider_plot(P, [], [], [], axes_limits);

## Input Arguments:
  (Required)
  P              - The data points used to plot the spider chart. The
                   rows are the groups of data and the columns are the
                   data points. [vector | matrix]

  (Optional)
  axes_labels    - Used to label each of the axes. [cell of strings]
  axes_interval  - Used to change the number of intervals displayed
                   between the webs. [integer]
  axes_precision - Used to change the precision level on the value
                   displayed on the axes. [integer]
  axes_limits    - Used to manually set the axes limits. A matrix of
                   2 x size(P, 2). The top row is the minimum axes limits
                   and the bottow row are the maximum axes limits. [matrix]

  To input use default value for optional arguments, specify as empty [].
  
## Examples:
  % Example 1: Minimal number of arguments. Optional arguments are set to
               the default values. Axes limits are automatically set.

  D1 = [5 3 9 1 2];   % Initialize data points
  D2 = [5 8 7 2 9];
  D3 = [8 2 1 4 6];
  P =  [D1; D2; D3];
  spider_plot(P);
  legend('D1', 'D2', 'D3', 'Location', 'southoutside');

  % Example 2: Manually setting the axes limits. Other optional arguments
               are set to the default values.

  axes_limits = [1, 2, 1, 1, 1; 10, 8, 9, 5, 10]; % Axes limits [min axes limits; max axes limits]
  spider_plot(P, [], [] ,[], axes_limits);

  % Example 3: Partial number of arguments. Non-specified optional
               arguments are set to the default values.

  axes_labels = {'S1', 'S2', 'S3', 'S4', 'S5'}; % Axes properties
  axes_interval = 2;
  spider_plot(P, axes_labels, axes_interval);

  % Example 4: Maximum number of arguments.

  axes_labels = {'S1', 'S2', 'S3', 'S4', 'S5'}; % Axes properties
  axes_interval = 4;
  axes_precision = 'none';
  axes_limits = [1, 2, 1, 1, 1; 10, 8, 9, 5, 10]; 
  spider_plot(P, axes_labels, axes_interval, axes_precision, axes_limits);

## Author:
  Moses Yoo, (jyoo at jyoo dot com)
  2019-09-17: Major revision and overhaul to improve speed and clarity

## Special Thanks:
  Special thanks to Gabriela Andrade & Andrés Garcia for their
  feature recommendations and suggested bug fixes.
