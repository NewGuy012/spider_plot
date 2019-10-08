# spider_plot
Create a spider or radar plot with individual axes.

## Syntax:
  spider_plot(P)
  

  spider_plot( ___, Name, Value)

## Input Arguments:
  (Required)
  
  P                - The data points used to plot the spider chart. The
                     rows are the groups of data and the columns are the
                     data points. The axes labels and axes limits are
                     automatically generated if not specified.
                     [vector | matrix]

## Name-Value Pair Arguments:
  (Optional)
  
  AxesLabels       - Used to specify the label each of the axes.
                     [cell of strings]

  AxesInterval     - Used to change the number of intervals displayed
                     between the webs. Set to 3 by default.
                     [integer]

  AxesPrecision    - Used to change the precision level on the value
                     displayed on the axes. Enter in 'none' to remove
                     axes text. Set to 1 by default.
                     [integer | 'none']

  AxesLimits       - Used to manually set the axes limits. A matrix of
                     2 x size(P, 2). The top row is the minimum axes
                     limits and the bottow row are the maximum axes limits.
                     [matrix]

  FillOption       - Used to toggle color fill option. Set off by default.
                     ['on' | 'off']

  FillTransparency - Used to set color fill transparency. Set to 0.1 by default.
                     [scalar in range (0, 1)]

  
## Examples:
  ### Example 1: Minimal number of arguments. All optional arguments are set to their default values. Axes labels and limits are automatically set.

  D1 = [5 3 9 1 2];   % Initialize data points
  
  D2 = [5 8 7 2 9];
  
  D3 = [8 2 1 4 6];
  
  P = [D1; D2; D3];
  
  spider_plot(P);
  
  legend('D1', 'D2', 'D3', 'Location', 'southoutside');

  ### Example 2: Manually setting the axes limits. All other optional arguments are set to their default values.

  axes_limits = [1, 2, 1, 1, 1; 10, 8, 9, 5, 10]; % Axes limits [min axes limits; max axes limits]
  
  spider_plot(P,...
  
      'AxesLimits', axes_limits);

  ### Example 3: Set fill option on. The fill transparency can be adjusted.

  axes_labels = {'S1', 'S2', 'S3', 'S4', 'S5'}; % Axes properties
  
  axes_interval = 2;
  
  fill_option = 'on';
  
  fill_transparency = 0.1;
  
  spider_plot(P,...
  
      'AxesLabels', axes_labels,...
      
      'AxesInterval', axes_interval,...
      
      'FillOption', fill_option,...
      
      'FillTransparency', fill_transparency);

  ### Example 4: Maximum number of arguments.

  axes_labels = {'S1', 'S2', 'S3', 'S4', 'S5'}; % Axes properties
  
  axes_interval = 4;
  
  axes_precision = 'none';
  
  axes_limits = [1, 2, 1, 1, 1; 10, 8, 9, 5, 10];
  
  fill_option = 'on';
  
  fill_transparency = 0.2;
  
  spider_plot(P,...
  
      'AxesLabels', axes_labels,...
      
      'AxesInterval', axes_interval,...
      
      'AxesPrecision', axes_precision,...
      
      'AxesLimits', axes_limits,...
      
      'FillOption', fill_option,...
      
      'FillTransparency', fill_transparency);


## Author:
  Moses Yoo, (jyoo at hatci dot com)
  
  2019-09-17: Major revision to improve speed, clarity, and functionality
  
  2019-10-08: Another major revision to convert to name-value pairs and add color fill option.

## Special Thanks:
  Special thanks to Gabriela Andrade & Andrés Garcia for their feature recommendations and suggested bug fixes.
