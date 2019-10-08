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
%                      [cell of strings]
%
%   AxesInterval     - Used to change the number of intervals displayed
%                      between the webs. Set to 3 by default.
%                      [integer]
%
%   AxesPrecision    - Used to change the precision level on the value
%                      displayed on the axes. Enter in 'none' to remove
%                      axes text. Set to 1 by default.
%                      [integer | 'none']
%
%   AxesLimits       - Used to manually set the axes limits. A matrix of
%                      2 x size(P, 2). The top row is the minimum axes
%                      limits and the bottow row are the maximum axes limits.
%                      [matrix]
%
%   FillOption       - Used to toggle color fill option. Set off by default.
%                      ['on' | 'off']
%
%   FillTransparency - Used to set color fill transparency. Set to 0.1 by default.
%                      [scalar in range (0, 1)]
%
% Examples:
%   % Example 1: Minimal number of arguments. All optional arguments are
%                set to their default values. Axes labels and limits are
%                automatically set.
%
%   D1 = [5 3 9 1 2];   % Initialize data points
%   D2 = [5 8 7 2 9];
%   D3 = [8 2 1 4 6];
%   P = [D1; D2; D3];
%   spider_plot(P);
%   legend('D1', 'D2', 'D3', 'Location', 'southoutside');
% 
%   % Example 2: Manually setting the axes limits. All other optional
%                arguments are set to their default values.
%
%   axes_limits = [1, 2, 1, 1, 1; 10, 8, 9, 5, 10]; % Axes limits [min axes limits; max axes limits]
%   spider_plot(P, 'AxesLimits', axes_limits);
% 
%   % Example 3: Set fill option on.
%
%   axes_labels = {'S1', 'S2', 'S3', 'S4', 'S5'}; % Axes properties
%   axes_interval = 2;
%   fill_option = 'on';
%   fill_transparency = 0.1;
%   spider_plot(P,...
%       'AxesLabels', axes_labels,...
%       'AxesInterval', axes_interval,...
%       'FillOption', fill_option,...
%       'FillTransparency', fill_transparency);
% 
%   % Example 4: Maximum number of arguments.
%
%   axes_labels = {'S1', 'S2', 'S3', 'S4', 'S5'}; % Axes properties
%   axes_interval = 4;
%   axes_precision = 'none';
%   axes_limits = [1, 2, 1, 1, 1; 10, 8, 9, 5, 10];
%   fill_option = 'on';
%   fill_transparency = 0.2;
%   spider_plot(P,...
%       'AxesLabels', axes_labels,...
%       'AxesInterval', axes_interval,...
%       'AxesPrecision', axes_precision,...
%       'AxesLimits', axes_limits,...
%       'FillOption', fill_option,...
%       'FillTransparency', fill_transparency);
% 
% Author:
%   Moses Yoo, (jyoo at hatci dot com)
%   2019-09-17: Major revision to improve speed, clarity, and functionality
%   2019-10-08: Another major revision to convert to name-value pairs and
%               add color fill option.
%
% Special Thanks:
%   Special thanks to Gabriela Andrade & Andrés Garcia for their
%   feature recommendations and suggested bug fixes.

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
axes_limits = [];
fill_option = 'off';
fill_transparency = 0.2;

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
            case 'axeslimits'
                axes_limits = value_arguments{ii};
            case 'filloption'
                fill_option = value_arguments{ii};
            case 'filltransparency'
                fill_transparency = value_arguments{ii};
            otherwise
                error('Error: Please enter in a valid name-value pair.');
        end
    end
    
end

%%% Error Check %%%
% Check if the axes labels are the same number as the number of points
if length(axes_labels) ~= num_data_points
    error('Error: Please make sure the number of labels is the same as the number of points.');
end

% Check if axes limits is not empty
if ~isempty(axes_limits)
    % Check if the axes limits same length as the number of points
    if size(axes_limits, 1) ~= 2 || size(axes_limits, 2) ~= num_data_points
        error('Error: Please make sure the min and max axes limits match the number of data points.');
    end
end

% Check if axes precision is string
if ~ischar(axes_precision)
    % Check if axes properties are an integer
    if floor(axes_interval) ~= axes_interval || floor(axes_precision) ~= axes_precision
        error('Error: Please enter in an integer for the axes properties.');
    end
    
    % Check if axes properties are positive
    if axes_interval < 1 || axes_precision < 1
        error('Error: Please enter value greater than one for the axes properties.');
    end
    
else
    % Check if axes precision is valid string entry
    if ~strcmp(axes_precision, 'none')
        error('Error: Invalid axes precision entry. Please enter in "none" to remove axes text.');
    end
end

% Check if not a valid fill option arguement
if ~ismember(fill_option, {'off', 'on'})
    error('Error: Please enter either "off" or "on" for fill option.');
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
colors = [0, 0.4470, 0.7410;...
    0.8500, 0.3250, 0.0980;...
    0.9290, 0.6940, 0.1250;...
    0.4940, 0.1840, 0.5560;...
    0.4660, 0.6740, 0.1880;...
    0.3010, 0.7450, 0.9330;...
    0.6350, 0.0780, 0.1840];

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
theta = 0:theta_increment:2*pi;

% Iterate through each theta
for ii = 1:length(theta)-1
    % Convert polar to cartesian coordinates
    [x_axes, y_axes] = pol2cart(theta(ii), rho);
    
    % Plot
    plot(x_axes, y_axes,...
        'LineWidth', 1.5,...
        'Color', grey);
    
    % Check if axes_labels is empty
    if ~strcmp(axes_precision, 'none')
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
                'FontSize', 10,...
                'HorizontalAlignment', 'center',...
                'VerticalAlignment', 'middle');
        end
    end
end

% Iterate through each rho
for ii = 2:length(rho)
    % Convert polar to cartesian coordinates
    [x_axes, y_axes] = pol2cart(theta, rho(ii));
    
    % Plot
    plot(x_axes, y_axes,...
        'Color', grey);
end

%%% Plot %%%
% Iterate through number of data groups
for ii = num_data_groups:-1:1
    % Convert polar to cartesian coordinates
    [x_points, y_points] = pol2cart(theta(1:end-1), P_scaled(ii, :));
    
    % Make points circular
    x_circular = [x_points, x_points(1)];
    y_circular = [y_points, y_points(1)];
    
    % Plot data points
    h = plot(x_circular, y_circular,...
        '-o',...
        'Color', colors(ii, :),...
        'LineWidth', 2,...
        'MarkerSize', 8,...
        'MarkerFaceColor', colors(ii, :));
    
    % Change stack order to bottom
    uistack(h, 'bottom');
    
    % Check if fill option is toggled on
    if strcmp(fill_option, 'on')
        % Fill area within polygon
        patch(x_circular, y_circular, colors(ii, :),...
            'EdgeColor', colors(ii, :),...
            'FaceAlpha', fill_transparency);
    end
end

%%% Labels %%%
% Shift axis label
shift_pos = 0.13;

% Iterate through number of data points
for ii = 1:num_data_points
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
        'BackgroundColor', 'w');
end
