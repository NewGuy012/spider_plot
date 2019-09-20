function spider_plot(P, varargin)
%spider_plot Create a spider or radar plot with individual axes.
%
% Syntax:
%   spider_plot(P)
%   spider_plot(P, axes_labels)
%   spider_plot(P, axes_labels, axes_interval)
%   spider_plot(P, axes_labels, axes_interval, axes_precision)
%   spider_plot(P, axes_labels, axes_interval, axes_precision, axes_limits)
%   spider_plot(P, [], [], [], axes_limits);
%
% Input Arguments:
%   (Required)
%   P              - The data points used to plot the spider chart. The
%                    rows are the groups of data and the columns are the
%                    data points. [vector | matrix]
%
%   (Optional)
%   axes_labels    - Used to label each of the axes. [cell of strings]
%   axes_interval  - Used to change the number of intervals displayed
%                    between the webs. [integer]
%   axes_precision - Used to change the precision level on the value
%                    displayed on the axes. [integer]
%   axes_limits    - Used to manually set the axes limits. A matrix of
%                    2 x size(P, 2). The top row is the minimum axes limits
%                    and the bottow row are the maximum axes limits. [matrix]
%
%   To input use default value for optional arguments, specify as empty [].
%
% Examples:
%
%   % Example 1: Minimal number of arguments. Optional arguments are set to
%                the default values. Axes limits are automatically set.
%
%   D1 = [5 3 9 1 2];   % Initialize data points
%   D2 = [5 8 7 2 9];
%   D3 = [8 2 1 4 6];
%   P = [D1; D2; D3];
%   spider_plot(P);
%   legend('D1', 'D2', 'D3', 'Location', 'southoutside');
% 
%   % Example 2: Manually setting the axes limits. Other optional arguments
%                are set to the default values.
%
%   axes_limits = [1, 2, 1, 1, 1; 10, 8, 9, 5, 10]; % Axes limits [min axes limits; max axes limits]
%   spider_plot(P, [], [] ,[], axes_limits);
% 
%   % Example 3: Partial number of arguments. Non-specified optional
%                arguments are set to the default values.
%
%   axes_labels = {'S1', 'S2', 'S3', 'S4', 'S5'}; % Axes properties
%   axes_interval = 2;
%   spider_plot(P, axes_labels, axes_interval);
% 
%   % Example 4: Maximum number of arguments.
%
%   axes_labels = {'S1', 'S2', 'S3', 'S4', 'S5'}; % Axes properties
%   axes_interval = 4;
%   axes_precision = 'none';
%   axes_limits = [1, 2, 1, 1, 1; 10, 8, 9, 5, 10]; 
%   spider_plot(P, axes_labels, axes_interval, axes_precision, axes_limits);
%
% Author:
%   Moses Yoo, (jyoo at jyoo dot com)
%   2019-09-17: Major revision to improve speed, clarity, and functionality
%
% Special Thanks:
%   Special thanks to Gabriela Andrade & Andrés Garcia for their
%   feature recommendations and suggested bug fixes.

%%% Data Properties %%%
% Point properties
[num_data_groups, num_data_points] = size(P);

% Number of optional arguments
numvarargs = length(varargin);

% Check if optional arguments are greater than 4
if numvarargs > 4
    error('Error: Too many inputs. Can handle up to 4 optional inputs');
end

% Create default labels
default_labels = cell(1, num_data_points);

% Iterate through number of data points
for ii = 1:num_data_points
    % Default axes labels
    default_labels{ii} = sprintf('Label %i', ii);
end

% Default arguments
default_interval = 3;
default_precision = 1;
default_limits = [];
default_args = cell(1, 4);
default_args(1:numvarargs) = varargin;

% Check if first optional argument is empty
if isempty(default_args{1})
    % Set to default value
    default_args{1} = default_labels;
end

% Check if second optional argument is empty
if isempty(default_args{2})
    % Set to default value
    default_args{2} = default_interval;
end

% Check if third optional argument is empty
if isempty(default_args{3})
    % Set to default value
    default_args{3} = default_precision;
end

% Check if fourth optional argument is empty
if isempty(default_args{4})
    % Set to default value
    default_args{4} = default_limits;
end

% Initialize variables
[axes_labels, axes_interval, axes_precision, axes_limits] = default_args{:};

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
        error('Error: Invalid axes precision entry. Please enter in "none" to remove axes precision.');
    end
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

% Repeat colors is necessary
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
for ii = 1:num_data_groups
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
    uistack(h, 'bottom');
end

%%% Labels %%%
% Shift axis label
shift_pos = 0.1;

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
