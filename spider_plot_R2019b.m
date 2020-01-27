function spider_plot_R2019b(P, options)
%spider_plot Create a spider or radar plot with individual axes.
%
% Syntax:
%   spider_plot_R2019b(P)
%   spider_plot_R2019b(___, Name, Value)
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
%   Marker           - Used to change the options.Marker symbol of the plots.
%                      ['o' (default) | 'none' | '*' | 's' | 'd' | ...]
%
%   MarkerSize       - Used to change the options.Marker size, where 1 point is
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
%   AxesLabelsOffset - Used to adjust the position offset of the axes
%                      labels.
%                      [0.1 (default) | positive value]
%
%   AxesScaling      - Used to change the scaling of the axes.
%                      ['linear' (default) | 'log']
%
% Examples:
%   % Example 1: Minimal number of arguments. All non-specified, optional
%                arguments are set to their default values. Axes labels
%                and limits are automatically generated and set.
%
%   D1 = [5 3 9 1 2];
%   D2 = [5 8 7 2 9];
%   D3 = [8 2 1 4 6];
%   P = [D1; D2; D3];
%   spider_plot_R2019b(P);
%   legend('D1', 'D2', 'D3', 'Location', 'southoutside');
%
%   % Example 2: Manually setting the axes limits. All non-specified,
%                optional arguments are set to their default values.
%
%   D1 = [5 3 9 1 2];
%   D2 = [5 8 7 2 9];
%   D3 = [8 2 1 4 6];
%   P = [D1; D2; D3];
%   spider_plot_R2019b(P,...
%       'AxesLimits', [1, 2, 1, 1, 1; 10, 8, 9, 5, 10]); % [min axes limits; max axes limits]
%
%   % Example 3: Set fill option on. The fill transparency can be adjusted.
%
%   D1 = [5 3 9 1 2];
%   D2 = [5 8 7 2 9];
%   D3 = [8 2 1 4 6];
%   P = [D1; D2; D3];
%   spider_plot_R2019b(P,...
%       'AxesLabels', {'S1', 'S2', 'S3', 'S4', 'S5'},...
%       'AxesInterval', 2,...
%       'FillOption', 'on',...
%       'FillTransparency', 0.1);
%
%   % Example 4: Maximum number of arguments.
%
%   D1 = [5 3 9 1 2];
%   D2 = [5 8 7 2 9];
%   D3 = [8 2 1 4 6];
%   P = [D1; D2; D3];
%   spider_plot_R2019b(P,...
%       'AxesLabels', {'S1', 'S2', 'S3', 'S4', 'S5'},...
%       'AxesInterval', 4,...
%       'AxesPrecision', 0,...
%       'AxesDisplay', 'one',...
%       'AxesLimits', [1, 2, 1, 1, 1; 10, 8, 9, 5, 10],...
%       'FillOption', 'on',...
%       'FillTransparency', 0.2,...
%       'Color', [1, 0, 0; 0, 1, 0; 0, 0, 1],...
%       'LineStyle', '--',...
%       'LineWidth', 3,...
%       'Marker', 'd',...
%       'MarkerSize', 10,...
%       'AxesFontSize', 12,...
%       'LabelFontSize', 10,...
%       'Direction', 'clockwise',...
%       'AxesLabelsOffset', 0,...
%       'AxesScaling', 'linear');
%
%   % Example 5: Excel-like radar charts.
%
%   D1 = [5 0 3 4 4];
%   D2 = [2 1 5 5 4];
%   P = [D1; D2];
%   spider_plot_R2019b(P,...
%       'AxesInterval', 5,...
%       'AxesPrecision', 0,...
%       'AxesDisplay', 'one',...
%       'AxesLimits', [0, 0, 0, 0, 0; 5, 5, 5, 5, 5],...
%       'FillOption', 'on',...
%       'FillTransparency', 0.1,...
%       'Color', [139, 0, 0; 240, 128, 128]/255,...
%       'LineWidth', 4,...
%       'Marker', 'none',...
%       'AxesFontSize', 14,...
%       'LabelFontSize', 10);
%   title('Excel-like Radar Chart',...
%       'FontSize', 14);
%   legend_str = {'D1', 'D2'};
%   legend(legend_str, 'Location', 'southoutside');
%
%   % Example 6: Logarithimic scale on all axes. Axes limits and axes
%                intervals are automatically set to factors of 10.
%
%   D1 = [-1 10 1 500];
%   D2 = [-10 20 1000 60];
%   D3 = [-100 30 10 7];
%   P = [D1; D2; D3];
%   spider_plot_R2019b(P,...
%       'AxesPrecision', 2,...
%       'AxesDisplay', 'one',...
%       'AxesScaling', 'log');
%   legend('D1', 'D2', 'D3', 'Location', 'northeast');
%
%   % Example 7: Spider plot with tiledlayout feature in R2019b.
%
%   D1 = [5 3 9 1 2];
%   D2 = [5 8 7 2 9];
%   D3 = [8 2 1 4 6];
%   P = [D1; D2; D3];
%   t = tiledlayout(2, 2);
%   nexttile;
%   spider_plot_R2019b(P,...
%       'AxesInterval', 1,...
%       'AxesPrecision', 0);
%   nexttile;
%   spider_plot_R2019b(P,...
%       'AxesInterval', 1,...
%       'AxesPrecision', 0);
%   nexttile(3, [1, 2]);
%   spider_plot_R2019b(P,...
%       'AxesInterval', 1,...
%       'AxesPrecision', 0);
%   t.TileSpacing = 'compact';
%   t.Padding = 'compact';
%   title(t, 'Spider Plots');
% 
% Author:
%   Moses Yoo, (jyoo at hatci dot com)
%   2020-01-27: Corrected bug where only 7 entries were allowed in legend.
%   2020-01-06: Added support for tiledlayout feature introduced in R2019b.
%   2019-11-27: Add option to change axes to logarithmic scale.
%   2019-11-15: Add feature to customize the plot rotational direction and
%               the offset position of the axis labels.
%   2019-10-28: Major revision in implementing the new function argument
%               validation feature introduced in R2019b. Replaced previous
%               method of error checking and setting of default values.
%   2019-10-23: Minor revision to set starting axes as the vertical line.
%               Add customization option for font sizes and axes display.
%   2019-10-16: Minor revision to add name-value pairs for customizing
%               color, Marker, and line settings.
%   2019-10-08: Another major revision to convert to name-value pairs and
%               add color fill option.
%   2019-09-17: Major revision to improve speed, clarity, and functionality
%
% Special Thanks:
%   Special thanks to Gabriela Andrade, Andrés Garcia, Jiro Doke,
%   Alex Grenyer, Omar Hadri & Zafar Alifor their feature recommendations
%   and suggested bug fixes.

%%% Argument Validation %%%
arguments
    P (:, :) double
    options.AxesLabels {validateAxesLabels(options.AxesLabels, P)} = cellstr("Label " + (1:size(P, 2)))
    options.AxesInterval (1, 1) double {mustBeInteger, mustBePositive} = 3
    options.AxesPrecision (1, 1) double {mustBeInteger, mustBeNonnegative} = 1
    options.AxesDisplay char {mustBeMember(options.AxesDisplay, {'all', 'none', 'one'})} = 'all'
    options.AxesLimits double {validateAxesLimits(options.AxesLimits, P)} = []
    options.FillOption char {mustBeMember(options.FillOption, {'off', 'on'})} = 'off'
    options.FillTransparency (1, 1) double {mustBeGreaterThanOrEqual(options.FillTransparency, 0), mustBeLessThanOrEqual(options.FillTransparency, 1)} = 0.1
    options.Color (:, 3) double {mustBeGreaterThanOrEqual(options.Color, 0), mustBeLessThanOrEqual(options.Color, 1)} = lines(size(P, 1))
    options.LineStyle char {mustBeMember(options.LineStyle,{'-', '--', ':', '-.', 'none'})} = '-'
    options.LineWidth (1, 1) double {mustBePositive} = 2
    options.Marker char {mustBeMember(options.Marker, {'+', 'o', '*', '.', 'x', 'square', 's', 'diamond', 'd', 'v', '^', '>', '<', 'pentagram', 'p', 'hexagram', 'h', 'none'})} = 'o'
    options.MarkerSize (1, 1) double {mustBePositive} = 8
    options.AxesFontSize (1, 1) double {mustBePositive} = 10
    options.LabelFontSize (1, 1) double {mustBePositive} = 10
    options.Direction char {mustBeMember(options.Direction, {'counterclockwise', 'clockwise'})} = 'counterclockwise'
    options.AxesLabelsOffset (1, 1) double {mustBeNonnegative} = 0.1
    options.AxesScaling char {mustBeMember(options.AxesScaling, {'linear', 'log'})} = 'linear'
end

%%% Data Properties %%%
% Point properties
[num_data_groups, num_data_points] = size(P);

%%% Axes Scaling Properties %%%
% Check axes scaling option
if strcmp(options.AxesScaling, 'log')
    % Common logarithm of base 10
    P = sign(P) .* log10(abs(P));
    
    % Minimum and maximun log limits
    min_limit = min(min(fix(P)));
    max_limit = max(max(ceil(P)));
    
    % Update axes interval
    options.AxesInterval = max_limit - min_limit;
    
    % Update axes limits
    options.AxesLimits = zeros(2, num_data_points);
    options.AxesLimits(1, :) = min_limit;
    options.AxesLimits(2, :) = max_limit;
end

%%% Figure Properties %%%
% Grab current figure
fig = gcf;

% Set figure background
fig.Color = 'white';

% Reset axes
cla reset;

% Current axes handle
ax = gca;

% Axis limits
hold on;
axis square;
axis([-1, 1, -1, 1] * 1.3);

% Axis properties
ax.XTickLabel = [];
ax.YTickLabel = [];
ax.XColor = 'none';
ax.YColor = 'none';

% Plot color
grey = [0.5, 0.5, 0.5];

% Repeat colors as necessary
repeat_colors = fix(num_data_points/size(options.Color, 1))+1;
options.Color = repmat(options.Color, repeat_colors, 1);

% Polar increments
theta_increment = 2*pi/num_data_points;
rho_increment = 1/(options.AxesInterval+1);

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
    
    % Check if options.AxesLimits is empty
    if isempty(options.AxesLimits)
        % Scale points to range from [rho_increment, 1]
        P_scaled(:, ii) = ((group_points - min_value) / range) * (1 - rho_increment) + rho_increment;
    else
        % Manually set the range of each group
        min_value = options.AxesLimits(1, ii);
        max_value = options.AxesLimits(2, ii);
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

% Check specified direction of rotation
switch options.Direction
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
switch options.AxesDisplay
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
        axes_value = min_value + (range/options.AxesInterval) * (jj-2);
        
        % Check axes scaling option
        if strcmp(options.AxesScaling, 'log')
            % Exponent to the tenth power
            axes_value = 10^axes_value;
        end
        
        % Display axes text
        text_str = sprintf(sprintf('%%.%if', options.AxesPrecision), axes_value);
        text(x_axes(jj), y_axes(jj), text_str,...
            'Units', 'Data',...
            'Color', 'k',...
            'FontSize', options.AxesFontSize,...
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
        'LineStyle', options.LineStyle,...
        'Marker', options.Marker,...
        'Color', options.Color(ii, :),...
        'LineWidth', options.LineWidth,...
        'MarkerSize', options.MarkerSize,...
        'MarkerFaceColor', options.Color(ii, :));
    
    % Check if fill option is toggled on
    if strcmp(options.FillOption, 'on')
        % Fill area within polygon
        h = patch(x_circular, y_circular, options.Color(ii, :),...
            'EdgeColor', 'none',...
            'FaceAlpha', options.FillTransparency);
        
        % Turn off legend annotation
        h.Annotation.LegendInformation.IconDisplayStyle = 'off';
    end
end

% Get object type of children
children_type = get(fig.Children, 'Type');

% Check if children is titled layout
if strcmp(children_type, 'titledlayout')
    % Set handle to axes children
    obj = ax.Children;
else
    % Set handle to axes
    obj = ax;
end

% Find object handles
text_handles = findobj(obj.Children,...
    'Type', 'Text');
patch_handles = findobj(obj.Children,...
    'Type', 'Patch');
isocurve_handles = findobj(obj.Children,...
    'Color', grey,...
    '-and', 'Type', 'Line');
plot_handles = findobj(obj.Children, '-not',...
    'Color', grey,...
    '-and', 'Type', 'Line');

% Manually set the stack order
uistack(text_handles, 'bottom');
uistack(plot_handles, 'bottom');
uistack(patch_handles, 'bottom');
uistack(isocurve_handles, 'bottom');

%%% Labels %%%
% Check labels argument
if ~strcmp(options.AxesLabels, 'none')
    % Convert polar to cartesian coordinates
    [x_axes, y_axes] = pol2cart(theta, rho(end));
    
    % Iterate through number of data points
    for ii = 1:length(options.AxesLabels)
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
                x_pos = options.AxesLabelsOffset;
                y_pos = 0;
            case 1
                horz_align = 'left';
                vert_align = 'bottom';
                x_pos = options.AxesLabelsOffset;
                y_pos = options.AxesLabelsOffset;
            case 1.5
                horz_align = 'center';
                vert_align = 'bottom';
                x_pos = 0;
                y_pos = options.AxesLabelsOffset;
            case 2
                horz_align = 'right';
                vert_align = 'bottom';
                x_pos = -options.AxesLabelsOffset;
                y_pos = options.AxesLabelsOffset;
            case 2.5
                horz_align = 'right';
                vert_align = 'middle';
                x_pos = -options.AxesLabelsOffset;
                y_pos = 0;
            case 3
                horz_align = 'right';
                vert_align = 'top';
                x_pos = -options.AxesLabelsOffset;
                y_pos = -options.AxesLabelsOffset;
            case 3.5
                horz_align = 'center';
                vert_align = 'top';
                x_pos = 0;
                y_pos = -options.AxesLabelsOffset;
            case 4
                horz_align = 'left';
                vert_align = 'top';
                x_pos = options.AxesLabelsOffset;
                y_pos = -options.AxesLabelsOffset;
        end
        
        % Display text label
        text(x_axes(ii)+x_pos, y_axes(ii)+y_pos, options.AxesLabels{ii},...
            'Units', 'Data',...
            'HorizontalAlignment', horz_align,...
            'VerticalAlignment', vert_align,...
            'EdgeColor', 'k',...
            'BackgroundColor', 'w',...
            'FontSize', options.LabelFontSize);
    end
end
end

%%% Custom Validation Functions %%%
% Validate axes limits
function validateAxesLimits(axLim, P)
if ~isempty(axLim)
    validateattributes(axLim, {'double'}, {'size', [2, size(P, 2)]}, mfilename, 'AxesLimits')
end
end

% Validate axes labels
function validateAxesLabels(axLabels, P)
if ~isequal(axLabels, 'none')
    validateattributes(axLabels, {'cell'}, {'size', [1, size(P, 2)]}, mfilename, 'AxesLabels')
end
end
