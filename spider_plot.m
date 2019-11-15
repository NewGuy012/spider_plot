function spider_plot(P, varargin)
%spider_plot Create a spider or radar plot with individual axes.
%
% Syntax:
%   spider_plot(P)
%   spider_plot(___, Name, Value)
%
% Input Arguments:
%   (Required)
%   P                - The data points used to plot the spider chart. The
%                      rows are the groups of data and the columns are the
%                      data points. The axes labels and axes limits are
%                      automatically generated if not specified.
%                      [vector | matrix]
%
% Name-Value Pair Arguments:
%   (Optional)
%   AxesLabels       - Used to specify the label each of the axes.
%                      [auto-generated (default) | cell of strings | 'none']
%
%   AxesInterval     - Used to change the number of intervals displayed
%                      between the webs.
%                      [3 (default) | integer]
%
%   AxesPrecision    - Used to change the precision level on the value
%                      displayed on the axes. 
%                      [1 (default) | integer]
%
%   AxesDisplay      - Used to change the number of axes in which the 
%                      axes text are displayed. 'None' or 'one' can be used
%                      to simplify the plot appearance for normalized data.
%                      ['all' (default) | 'none' | 'one']
%
%   AxesLimits       - Used to manually set the axes limits. A matrix of
%                      2 x size(P, 2). The top row is the minimum axes
%                      limits and the bottow row is the maximum axes limits.
%                      [auto-scaled (default) | matrix]
%
%   FillOption       - Used to toggle color fill option.
%                      ['off' (default) | 'on']
%
%   FillTransparency - Used to set color fill transparency.
%                      [0.1 (default) | scalar in range (0, 1)]
%
%   Color            - Used to specify the line color, specified as an RGB
%                      triplet. The intensities must be in the range (0, 1).
%                      [MATLAB colors (default) | RGB triplet]
%
%   LineStyle        - Used to change the line style of the plots.
%                      ['-' (default) | '--' | ':' | '-.' | 'none']
%
%   LineWidth        - Used to change the line width, where 1 point is 
%                      1/72 of an inch.
%                      [0.5 (default) | positive value]
%
%   Marker           - Used to change the marker symbol of the plots.
%                      ['o' (default) | 'none' | '*' | 's' | 'd' | ...]
%
%   MarkerSize       - Used to change the marker size, where 1 point is
%                      1/72 of an inch.
%                      [8 (default) | positive value]
%
%   AxesFontSize     - Used to change the font size of the values
%                      displayed on the axes.
%                      [10 (default) | scalar value greater than zero]
%
%   LabelFontSize    - Used to change the font size of the labels.
%                      [10 (default) | scalar value greater than zero]
%
%   Direction        - Used to change the direction of rotation of the 
%                      plotted data and axis labels.
%                      [counterclockwise (default) | clockwise]
%
% Examples:
%   % Example 1: Minimal number of arguments. All non-specified, optional
%                arguments are set to their default values. Axes labels
%                and limits are automatically generated and set.
%
%   D1 = [5 3 9 1 2];   % Initialize data points
%   D2 = [5 8 7 2 9];
%   D3 = [8 2 1 4 6];
%   P = [D1; D2; D3];
%   spider_plot(P);
%   legend('D1', 'D2', 'D3', 'Location', 'southoutside');
%
%   % Example 2: Manually setting the axes limits. All non-specified,
%                optional arguments are set to their default values.
%
%   D1 = [5 3 9 1 2];   % Initialize data points
%   D2 = [5 8 7 2 9];
%   D3 = [8 2 1 4 6];
%   P = [D1; D2; D3];
%   AxesLimits = [1, 2, 1, 1, 1; 10, 8, 9, 5, 10]; % Axes limits [min axes limits; max axes limits]
%   spider_plot(P,...
%       'AxesLimits', AxesLimits);
%
%   % Example 3: Set fill option on. The fill transparency can be adjusted.
%
%   D1 = [5 3 9 1 2];   % Initialize data points
%   D2 = [5 8 7 2 9];
%   D3 = [8 2 1 4 6];
%   P = [D1; D2; D3];
%   AxesLabels = {'S1', 'S2', 'S3', 'S4', 'S5'}; % Axes properties
%   AxesInterval = 2;
%   FillOption = 'on';
%   FillTransparency = 0.1;
%   spider_plot(P,...
%       'AxesLabels', AxesLabels,...
%       'AxesInterval', AxesInterval,...
%       'FillOption', FillOption,...
%       'FillTransparency', FillTransparency);
%
%   % Example 4: Maximum number of arguments.
%
%   D1 = [5 3 9 1 2];   % Initialize data points
%   D2 = [5 8 7 2 9];
%   D3 = [8 2 1 4 6];
%   P = [D1; D2; D3];
%   AxesLabels = {'S1', 'S2', 'S3', 'S4', 'S5'}; % Axes properties
%   AxesInterval = 4;
%   AxesPrecision = 0;
%   AxesDisplay = 'one';
%   AxesLimits = [1, 2, 1, 1, 1; 10, 8, 9, 5, 10];
%   FillOption = 'on';
%   FillTransparency = 0.2;
%   Color = [1, 0, 0; 0, 1, 0; 0, 0, 1];
%   LineStyle = '--';
%   LineWidth = 3;
%   Marker = 'd';
%   MarkerSize = 10;
%   AxesFontSize = 12;
%   LabelFontSize = 10;
%   Direction = 'clockwise';
%   spider_plot(P,...
%       'AxesLabels', AxesLabels,...
%       'AxesInterval', AxesInterval,...
%       'AxesPrecision', AxesPrecision,...
%       'AxesDisplay', AxesDisplay,...
%       'AxesLimits', AxesLimits,...
%       'FillOption', FillOption,...
%       'FillTransparency', FillTransparency,...
%       'Color', Color,...
%       'LineStyle', LineStyle,...
%       'LineWidth', LineWidth,...
%       'Marker', Marker,...
%       'MarkerSize', MarkerSize,...
%       'AxesFontSize', AxesFontSize,...
%       'LabelFontSize', LabelFontSize,...
%       'Direction', Direction);
%
%   % Example 5: Excel-like radar charts.
%
%   D1 = [5, 0, 3, 4, 4]; % Initialize data
%   D2 = [2, 1, 5, 5, 4];
%   P = [D1; D2];
%   AxesInterval = 5; % Axes properties
%   AxesPrecision = 0;
%   AxesDisplay = 'one';
%   AxesLimits = [0, 0, 0, 0, 0; 5, 5, 5, 5, 5];
%   FillPption = 'on';
%   FillTransparency = 0.1;
%   Colors = [139, 0, 0; 240, 128, 128]/255;
%   LineWidth = 4;
%   MarkerType = 'none';
%   AxesFontSize = 14;
%   LabelFontSize = 10;
%   spider_plot(P,...
%       'AxesInterval', AxesInterval,...
%       'AxesPrecision', AxesPrecision,...
%       'AxesDisplay', AxesDisplay,...
%       'AxesLimits', AxesLimits,...
%       'FillOption', FillOption,...
%       'FillTransparency', FillTransparency,...
%       'Color', Colors,...
%       'LineWidth', LineWidth,...
%       'Marker', MarkerType,...
%       'AxesFontSize', AxesFontSize,...
%       'LabelFontSize', LabelFontSize);
%   title(sprintf('Excel-like\n Radar Chart'),...
%       'Units', 'normalized',...
%       'Position', [-0.2, 0.3, 0],...
%       'FontSize', 14);
%   legend_str = {'D1', 'D2'};
%   legend(legend_str, 'Location', 'southoutside');
%
% Author:
%   Moses Yoo, (jyoo at hatci dot com)
%   2019-11-15: Add feature to customize the plot rotational direction.
%   2019-10-23: Minor revision to set starting axes as the vertical line.
%               Add customization option for font sizes and axes display.
%   2019-10-16: Minor revision to add name-value pairs for customizing
%               color, marker, and line settings.
%   2019-10-08: Another major revision to convert to name-value pairs and
%               add color fill option.
%   2019-09-17: Major revision to improve speed, clarity, and functionality
%
% Special Thanks:
%   Special thanks to Gabriela Andrade, Andrés Garcia, & Alex Grenyer for
%   their feature recommendations and suggested bug fixes.

%%% Data Properties %%%
% Point properties
[num_data_groups, num_data_points] = size(P);

% Number of optional arguments
numvarargs = length(varargin);

% Check for even number of name-value pair argments
if mod(numvarargs, 2) == 1
    error('Error: Please check name-value pair arguments');
end

% Create default labels
axes_labels = cell(1, num_data_points);

% Iterate through number of data points
for ii = 1:num_data_points
    % Default axes labels
    axes_labels{ii} = sprintf('Label %i', ii);
end

% Default arguments
axes_interval = 3;
axes_precision = 1;
axes_display = 'all';
axes_limits = [];
fill_option = 'off';
fill_transparency = 0.2;
colors = [0, 0.4470, 0.7410;...
    0.8500, 0.3250, 0.0980;...
    0.9290, 0.6940, 0.1250;...
    0.4940, 0.1840, 0.5560;...
    0.4660, 0.6740, 0.1880;...
    0.3010, 0.7450, 0.9330;...
    0.6350, 0.0780, 0.1840];
line_style = '-';
line_width = 2;
marker_type = 'o';
marker_size = 8;
axes_font_size = 10;
label_font_size = 10;
direction = 'counterclockwise';

% Check if optional arguments were specified
if numvarargs > 1
    % Initialze name-value arguments
    name_arguments = varargin(1:2:end);
    value_arguments = varargin(2:2:end);
    
    % Iterate through name-value arguments
    for ii = 1:length(name_arguments)
        % Set value arguments depending on name
        switch lower(name_arguments{ii})
            case 'axeslabels'
                axes_labels = value_arguments{ii};
            case 'axesinterval'
                axes_interval = value_arguments{ii};
            case 'axesprecision'
                axes_precision = value_arguments{ii};
            case 'axesdisplay'
                axes_display = value_arguments{ii};
            case 'axeslimits'
                axes_limits = value_arguments{ii};
            case 'filloption'
                fill_option = value_arguments{ii};
            case 'filltransparency'
                fill_transparency = value_arguments{ii};
            case 'color'
                colors = value_arguments{ii};
            case 'linestyle'
                line_style = value_arguments{ii};
            case 'linewidth'
                line_width = value_arguments{ii};
            case 'marker'
                marker_type = value_arguments{ii};
            case 'markersize'
                marker_size = value_arguments{ii};
            case 'axesfontsize'
                axes_font_size = value_arguments{ii};
            case 'labelfontsize'
                label_font_size = value_arguments{ii};
            case 'direction'
                direction = value_arguments{ii};
            otherwise
                error('Error: Please enter in a valid name-value pair.');
        end
    end
    
end

%%% Error Check %%%
% Check if axes labels is a cell
if iscell(axes_labels)
    % Check if the axes labels are the same number as the number of points
    if length(axes_labels) ~= num_data_points
        error('Error: Please make sure the number of labels is the same as the number of points.');
    end
else
    % Check if valid string entry
    if ~contains(axes_labels, 'none')
        error('Error: Please enter in valid labels or "none" to remove labels.');
    end
end

% Check if axes limits is not empty
if ~isempty(axes_limits)
    % Check if the axes limits same length as the number of points
    if size(axes_limits, 1) ~= 2 || size(axes_limits, 2) ~= num_data_points
        error('Error: Please make sure the min and max axes limits match the number of data points.');
    end
end

% Check if axes properties are an integer
if floor(axes_interval) ~= axes_interval || floor(axes_precision) ~= axes_precision
    error('Error: Please enter in an integer for the axes properties.');
end

% Check if axes properties are positive
if axes_interval < 1 || axes_precision < 0
    error('Error: Please enter a positive for the axes properties.');
end

% Check if axes display is valid string entry
if ~ismember(axes_display, {'all', 'none', 'one'})
    error('Error: Invalid axes display entry. Please enter in "all", "none", or "one" to set axes text.');
end

% Check if not a valid fill option arguement
if ~ismember(fill_option, {'off', 'on'})
    error('Error: Please enter either "off" or "on" for fill option.');
end

% Check if fill transparency is valid
if fill_transparency < 0 || fill_transparency > 1
    error('Error: Please enter a transparency value between [0, 1].');
end

% Check if font size is greater than zero
if axes_font_size <= 0 || label_font_size <= 0
    error('Error: Please enter a font size greater than zero.');
end

% Check if direction is valid string entry
if ~ismember(direction, {'counterclockwise', 'clockwise'})
    error('Error: Invalid direction entry. Please enter in "counterclockwise" or "clockwise" to set direction of rotation.');
end

%%% Figure Properties %%%
% Figure background
fig = figure;
fig.Color = 'white';

% Axis limits
hold on;
axis square;
axis off;

% Plot colors
grey = [0.5, 0.5, 0.5];

% Repeat colors as necessary
repeat_colors = fix(num_data_points/size(colors, 1))+1;
colors = repmat(colors, repeat_colors, 1);

% Polar increments
theta_increment = 2*pi/num_data_points;
rho_increment = 1/(axes_interval+1);

%%% Scale Data %%%
% Pre-allocation
P_scaled = zeros(size(P));
axes_range = zeros(3, num_data_points);

% Iterate through number of data points
for ii = 1:num_data_points
    % Group of points
    group_points = P(:, ii);
    
    % Automatically the range of each group
    min_value = min(group_points);
    max_value = max(group_points);
    range = max_value - min_value;
    
    % Check if axes_limits is empty
    if isempty(axes_limits)
        % Scale points to range from [rho_increment, 1]
        P_scaled(:, ii) = ((group_points - min_value) / range) * (1 - rho_increment) + rho_increment;
    else
        % Manually set the range of each group
        min_value = axes_limits(1, ii);
        max_value = axes_limits(2, ii);
        range = max_value - min_value;
        
        % Check if the axes limits are within range of points
        if min_value > min(group_points) || max_value < max(group_points)
            error('Error: Please make the manually specified axes limits are within range of the data points.');
        end
        
        % Scale points to range from [rho_increment, 1]
        P_scaled(:, ii) = ((group_points - min_value) / range) * (1 - rho_increment) + rho_increment;
    end
    
    % Store to array
    axes_range(:, ii) = [min_value; max_value; range];
end

%%% Polar Axes %%%
% Polar coordinates
rho = 0:rho_increment:1;

% Check rotational direction
switch direction
    case 'counterclockwise'
        % Shift by pi/2 to set starting axis the vertical line
        theta = (0:theta_increment:2*pi) + (pi/2);
    case 'clockwise'
        % Shift by pi/2 to set starting axis the vertical line
        theta = (0:-theta_increment:-2*pi) + (pi/2);
end

% Remainder after using a modulus of 2*pi
theta = mod(theta, 2*pi);

% Iterate through each theta
for ii = 1:length(theta)-1
    % Convert polar to cartesian coordinates
    [x_axes, y_axes] = pol2cart(theta(ii), rho);
    
    % Plot webs
    h = plot(x_axes, y_axes,...
        'LineWidth', 1.5,...
        'Color', grey);
    
    % Turn off legend annotation
    h.Annotation.LegendInformation.IconDisplayStyle = 'off';
end

% Iterate through each rho
for ii = 2:length(rho)
    % Convert polar to cartesian coordinates
    [x_axes, y_axes] = pol2cart(theta, rho(ii));
    
    % Plot axes
    h = plot(x_axes, y_axes,...
        'Color', grey);
    
    % Turn off legend annotation
    h.Annotation.LegendInformation.IconDisplayStyle = 'off';
end

% Set end index depending on axes display argument
switch axes_display
    case 'all'
        theta_end_index = length(theta)-1;
    case 'one'
        theta_end_index = 1;
    case 'none'
        theta_end_index = 0;
end

% Iterate through each theta
for ii = 1:theta_end_index
    % Convert polar to cartesian coordinates
    [x_axes, y_axes] = pol2cart(theta(ii), rho);
    
    % Iterate through points on isocurve
    for jj = 2:length(rho)
        % Axes increment value
        min_value = axes_range(1, ii);
        range = axes_range(3, ii);
        axes_value = min_value + (range/axes_interval) * (jj-2);
        
        % Display axes text
        text_str = sprintf(sprintf('%%.%if', axes_precision), axes_value);
        text(x_axes(jj), y_axes(jj), text_str,...
            'Units', 'Data',...
            'Color', 'k',...
            'FontSize', axes_font_size,...
            'HorizontalAlignment', 'center',...
            'VerticalAlignment', 'middle');
    end
end

%%% Plot %%%
% Iterate through number of data groups
for ii = 1:num_data_groups
    % Convert polar to cartesian coordinates
    [x_points, y_points] = pol2cart(theta(1:end-1), P_scaled(ii, :));
    
    % Make points circular
    x_circular = [x_points, x_points(1)];
    y_circular = [y_points, y_points(1)];
    
    % Plot data points
    plot(x_circular, y_circular,...
        'LineStyle', line_style,...
        'Marker', marker_type,...
        'Color', colors(ii, :),...
        'LineWidth', line_width,...
        'MarkerSize', marker_size,...
        'MarkerFaceColor', colors(ii, :));
    
    % Check if fill option is toggled on
    if strcmp(fill_option, 'on')
        % Fill area within polygon
        h = patch(x_circular, y_circular, colors(ii, :),...
            'EdgeColor', 'none',...
            'FaceAlpha', fill_transparency);
        
        % Turn off legend annotation
        h.Annotation.LegendInformation.IconDisplayStyle = 'off';
    end
end

% Find object handles
text_handles = findobj(fig.Children,...
    'Type', 'Text');
patch_handles = findobj(fig.Children,...
    'Type', 'Patch');
isocurve_handles = findobj(fig.Children,...
    'Color', grey,...
    '-and', 'Type', 'Line');
plot_handles = findobj(fig.Children, '-not',...
    'Color', grey,...
    '-and', 'Type', 'Line');

% Manually set the stack order
h = [text_handles; plot_handles; patch_handles; isocurve_handles];
set(fig.Children, 'Children', h);

%%% Labels %%%
% Shift axis label
shift_pos = 0.1;

% Check labels argument
if ~strcmp(axes_labels, 'none')
    % Convert polar to cartesian coordinates
    [x_axes, y_axes] = pol2cart(theta, rho(end));
    
    % Iterate through number of data points
    for ii = 1:length(axes_labels)
        % Angle of point in radians
        theta_point = theta(ii);
        
        % Find out which quadrant the point is in
        if theta_point == 0
            quadrant = 0;
        elseif theta_point == pi/2
            quadrant = 1.5;
        elseif theta_point == pi
            quadrant = 2.5;
        elseif theta_point == 3*pi/2
            quadrant = 3.5;
        elseif theta_point == 2*pi
            quadrant = 0;
        elseif theta_point > 0 && theta_point < pi/2
            quadrant = 1;
        elseif theta_point > pi/2 && theta_point < pi
            quadrant = 2;
        elseif theta_point > pi && theta_point < 3*pi/2
            quadrant = 3;
        elseif theta_point > 3*pi/2 && theta_point < 2*pi
            quadrant = 4;
        end
        
        % Adjust label alignment depending on quadrant
        switch quadrant
            case 0
                horz_align = 'left';
                vert_align = 'middle';
                x_pos = shift_pos;
                y_pos = 0;
            case 1
                horz_align = 'left';
                vert_align = 'bottom';
                x_pos = shift_pos;
                y_pos = shift_pos;
            case 1.5
                horz_align = 'center';
                vert_align = 'bottom';
                x_pos = 0;
                y_pos = shift_pos;
            case 2
                horz_align = 'right';
                vert_align = 'bottom';
                x_pos = -shift_pos;
                y_pos = shift_pos;
            case 2.5
                horz_align = 'right';
                vert_align = 'middle';
                x_pos = -shift_pos;
                y_pos = 0;
            case 3
                horz_align = 'right';
                vert_align = 'top';
                x_pos = -shift_pos;
                y_pos = -shift_pos;
            case 3.5
                horz_align = 'center';
                vert_align = 'top';
                x_pos = 0;
                y_pos = -shift_pos;
            case 4
                horz_align = 'left';
                vert_align = 'top';
                x_pos = shift_pos;
                y_pos = -shift_pos;
        end
        
        % Display text label
        text(x_axes(ii)+x_pos, y_axes(ii)+y_pos, axes_labels{ii},...
            'Units', 'Data',...
            'HorizontalAlignment', horz_align,...
            'VerticalAlignment', vert_align,...
            'EdgeColor', 'k',...
            'BackgroundColor', 'w',...
            'FontSize', label_font_size);
    end
end
