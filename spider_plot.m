function varargout = spider_plot(P, varargin)
%spider_plot Create a spider or radar plot with individual axes.
%
% Syntax:
%   spider_plot(P)
%   spider_plot(P, Name, Value, ...)
%   h = spider_plot(_)
%
% Input Arguments:
%   (Required)
%   P                - The data points used to plot the spider chart. The
%                      rows are the groups of data and the columns are the
%                      data points. The axes labels and axes limits are
%                      automatically generated if not specified.
%                      [vector | matrix]
%
% Output Arguments:
%   (Optional)
%   h                - Figure handle of spider plot.
%                      [figure object]
%
% Name-Value Pair Arguments:
%   (Optional)
%   AxesLabels       - Used to specify the label each of the axes.
%                      [auto-generated (default) | cell array of character vectors | 'none']
%
%   AxesInterval     - Used to change the number of intervals displayed
%                      between the webs.
%                      [3 (default) | integer]
%
%   AxesPrecision    - Used to change the precision level on the value
%                      displayed on the axes.
%                      [1 (default) | integer | vector]
%
%   AxesDisplay      - Used to change the number of axes in which the
%                      axes text are displayed. 'None' or 'one' can be used
%                      to simplify the plot appearance for normalized data.
%                      ['all' (default) | 'none' | 'one' | 'data']
%
%   AxesLimits       - Used to manually set the axes limits. A matrix of
%                      2 x size(P, 2). The top row is the minimum axes
%                      limits and the bottow row is the maximum axes limits.
%                      [auto-scaled (default) | matrix]
%
%   FillOption       - Used to toggle fill color option.
%                      ['off' (default) | 'on' | cell array of character vectors]
%
%   FillTransparency - Used to set fill color transparency.
%                      [0.1 (default) | scalar in range (0, 1) | vector]
%
%   Color            - Used to specify the line color, specified as an RGB
%                      triplet. The intensities must be in the range (0, 1).
%                      [MATLAB colors (default) | RGB triplet]
%
%   LineStyle        - Used to change the line style of the plots.
%                      ['-' (default) | '--' | ':' | '-.' | 'none' | cell array of character vectors]
%
%   LineWidth        - Used to change the line width, where 1 point is
%                      1/72 of an inch.
%                      [0.5 (default) | positive value | vector]
%
%   LineTransparency - Used to set the line color transparency.
%                      [1 (default) | scalar in range (0, 1) | vector]
%
%   Marker           - Used to change the marker symbol of the plots.
%                      ['o' (default) | 'none' | '*' | 's' | 'd' | ... | cell array of character vectors]
%
%   MarkerSize       - Used to change the marker size, where 1 point is
%                      1/72 of an inch.
%                      [36 (default) | positive value | vector | vector]
%
%   MarkerTransparency-Used to set the marker color transparency.
%                      [1 (default) | scalar in range (0, 1)]
%
%   AxesFont         - Used to change the font type of the values
%                      displayed on the axes.
%                      [Helvetica (default) | supported font name]
%
%   LabelFont        - Used to change the font type of the labels.
%                      [Helvetica (default) | supported font name]
%
%   AxesFontSize     - Used to change the font size of the values
%                      displayed on the axes.
%                      [10 (default) | scalar value greater than zero]
%
%   AxesFontColor    - Used to change the font color of the values
%                      displayed on the axes.
%                      [black (default) | RGB triplet]
%
%   LabelFontSize    - Used to change the font size of the labels.
%                      [10 (default) | scalar value greater than zero]
%
%   Direction        - Used to change the direction of rotation of the
%                      plotted data and axis labels.
%                      ['clockwise' (default) | 'counterclockwise']
%
%   AxesDirection    - Used to change the direction of axes.
%                      ['normal' (default) | 'reverse' | cell array of character vectors]
%
%   AxesLabelsOffset - Used to adjust the position offset of the axes
%                      labels.
%                      [0.2 (default) | positive value]
%
%   AxesDataOffset   - Used to adjust the position offset of the data labels
%                      when AxesDisplay is set to 'data'.
%                      [0.1 (default) | positive value]
%
%   AxesScaling      - Used to change the scaling of the axes.
%                      ['linear' (default) | 'log' | cell array of character vectors]
%
%   AxesColor        - Used to change the color of the spider axes.
%                      [grey (default) | RGB triplet | hexadecimal color code]
%
%   AxesLabelsEdge   - Used to change the edge color of the axes labels.
%                      [black (default) | RGB triplet | hexadecimal color code | 'none']
%
%   AxesOffset       - Used to change to axes offset from the origin.
%                      [1 (default) | any integer less than the axes interval]
%
%   AxesZoom         - Used to change zoom of axes.
%                      [0.7 (default) | scalar in range (0, 1)]
%
%   AxesHorzAlign    - Used to change the horizontal alignment of axes tick labels.
%                      ['center' (default) | 'left' | 'right' | 'quadrant']
%
%   AxesVertAlign    - Used to change the vertical aligment of axes tick labels.
%                      ['middle' (default) | 'top' | 'cap' | 'bottom' | 'baseline' | 'quadrant']
%
%   PlotVisible      - Used to change the visibility of the plotted lines and markers.
%                      ['on' (default) | 'off']
%
%   AxesTickLabels   - Used to change the axes tick labels.
%                      ['data' (default) | cell array of character vectors]
%
%   AxesInterpreter  - Used to change the text interpreter of axes labels and axes tick labels.
%                      ['tex' (default) | 'latex' | 'none' | cell array of character vectors]
%
%   BackgroundColor  - Used to change the color of the background.
%                      ['white' (default) | RGB triplet | hexadecimal color code | 'r' | 'g' | 'b' | ...]
%
%   MinorGrid        - Used to toggle the minor grid.
%                      ['off' (default) | 'on']
%
%   MinorGridInterval- Used to change number of minor grid lines in between the major grid lines.
%                      [2 (default) | integer value greater than zero]
%
%   AxesZero         - Used to add a reference axes at value zero.
%                      ['off' (default) | 'on']
%
%   AxesZeroColor    - Used to change the color of the zero reference axes.
%                      ['black' (default) | RGB triplet | hexadecimal color code | 'r' | 'g' | 'b' | ...]
%
%   AxesZeroWidth    - Used to change the line width of the zero reference axes.
%                      [2 (default) | positive value]
%
%   AxesRadial       - Used to toggle radial axes.
%                      ['on' (default) | 'off']
%
%   AxesAngular      - Used to toggle angular axes.
%                      ['on' (default) | 'off']
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
%   spider_plot(P);
%   legend('D1', 'D2', 'D3', 'Location', 'southoutside');
%
%   % Example 2: Manually setting the axes limits and axes precision.
%                All non-specified, optional arguments are set to their
%                default values.
%
%   D1 = [5 3 9 1 2];
%   D2 = [5 8 7 2 9];
%   D3 = [8 2 1 4 6];
%   P = [D1; D2; D3];
%   spider_plot(P,...
%       'AxesLimits', [1, 2, 1, 1, 1; 10, 8, 9, 5, 10],... % [min axes limits; max axes limits]
%       'AxesPrecision', [0, 1, 1, 1, 1]);
%
%   % Example 3: Set fill option on. The fill transparency can be adjusted.
%
%   D1 = [5 3 9 1 2];
%   D2 = [5 8 7 2 9];
%   D3 = [8 2 1 4 6];
%   P = [D1; D2; D3];
%   spider_plot(P,...
%       'AxesLabels', {'S1', 'S2', 'S3', 'S4', 'S5'},...
%       'AxesInterval', 2,...
%       'FillOption', {'on', 'on', 'off'},...
%       'FillTransparency', [0.2, 0.1, 0.1]);
%
%   % Example 4: Maximum number of arguments.
%
%   D1 = [5 3 9 1 2];
%   D2 = [5 8 7 2 9];
%   D3 = [8 2 1 4 6];
%   P = [D1; D2; D3];
%   spider_plot(P,...
%       'AxesLabels', {'S1', 'S2', 'S3', 'S4', 'S5'},...
%       'AxesInterval', 4,...
%       'AxesPrecision', 0,...
%       'AxesDisplay', 'one',...
%       'AxesLimits', [1, 2, 1, 1, 1; 10, 8, 9, 5, 10],...
%       'FillOption', 'on',...
%       'FillTransparency', 0.2,...
%       'Color', [1, 0, 0; 0, 1, 0; 0, 0, 1],...
%       'LineStyle', {'--', '-', '--'},...
%       'LineWidth', [1, 2, 3],...
%       'LineTransparency', 1,...
%       'Marker', {'o', 'd', 's'},...
%       'MarkerSize', [8, 10, 12],...
%       'MarkerTransparency', 1,...
%       'AxesFont', 'Times New Roman',...
%       'LabelFont', 'Times New Roman',...
%       'AxesFontColor', 'k',...
%       'AxesFontSize', 12,...
%       'LabelFontSize', 10,...
%       'Direction', 'clockwise',...
%       'AxesDirection', {'reverse', 'normal', 'normal', 'normal', 'normal'},...
%       'AxesLabelsOffset', 0.2,...
%       'AxesDataOffset', 0.1,...
%       'AxesScaling', 'linear',...
%       'AxesColor', [0.6, 0.6, 0.6],...
%       'AxesLabelsEdge', 'none',...
%       'AxesOffset', 1,...
%       'AxesZoom', 1,...
%       'AxesHorzAlign', 'quadrant',...
%       'AxesVertAlign', 'quadrant',...
%       'PlotVisible', 'on',...
%       'AxesTickLabels', 'data',...
%       'AxesInterpreter', 'tex',...
%       'BackgroundColor' , 'w',...
%       'MinorGrid', 'off',...
%       'MinorGridInterval', 2,...
%       'AxesZero', 'off',...
%       'AxesZeroColor', 'k',...
%       'AxesZeroWidth', 2,...
%       'AxesRadial', 'on',...
%       'AxesAngular', 'on');
%
%   % Example 5: Excel-like radar charts.
%
%   D1 = [5 0 3 4 4];
%   D2 = [2 1 5 5 4];
%   P = [D1; D2];
%   spider_plot(P,...
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
%       'LabelFontSize', 10,...
%       'AxesColor', [0.8, 0.8, 0.8],...
%       'AxesLabelsEdge', 'none',...
%       'AxesRadial', 'off');
%   title('Excel-like Radar Chart',...
%       'FontSize', 14);
%   legend_str = {'D1', 'D2'};
%   legend(legend_str, 'Location', 'southoutside');
%
%   % Example 6: Logarithimic scale on specified axes. Axes limits and axes
%                intervals can be individually set as well.
%
%   D1 = [5 3 9 1 1];
%   D2 = [5 8 7 2 10];
%   D3 = [8 2 1 4 100];
%   P = [D1; D2; D3];
%   spider_plot(P,...
%       'AxesInterval', 2,...
%       'AxesPrecision', 0,...
%       'AxesFontSize', 10,...
%       'AxesLabels', {'Linear Scale', 'Linear Scale', 'Linear Scale', 'Linear Scale', 'Logarithimic Scale'},...
%       'AxesScaling', {'linear', 'linear', 'linear', 'linear', 'log'},...
%       'AxesLimits', [1, 1, 1, 1, 1; 10, 10, 10, 10, 100]);
%   legend('D1', 'D2', 'D3', 'Location', 'northeast');
%
%   % Example 7: Spider plot with subplot feature.
%
%   D1 = [5 3 9 1 2];
%   D2 = [5 8 7 2 9];
%   D3 = [8 2 1 4 6];
%   P = [D1; D2; D3];
%   subplot(1, 2, 1)
%   spider_plot(P,...
%       'AxesInterval', 1,...
%       'AxesPrecision', 0);
%   subplot(1, 2, 2)
%   spider_plot(P,...
%       'AxesInterval', 1,...
%       'AxesPrecision', 0);
%
%   % Example 8: Spider plot with values only on data points.
%   
%   D1 = [1 3 4 1 2];
%   D2 = [5 8 7 5 9];
%   P = [D1; D2];
%   spider_plot(P,...
%       'AxesLimits', [1, 1, 1, 1, 1; 10, 10, 10, 10, 10],...
%       'AxesDisplay', 'data',...
%       'AxesLabelsOffset', 0.2,...
%       'AxesDataOffset', 0.1,...
%       'AxesFontColor', [0, 0, 1; 1, 0, 0]);
%   legend('D1', 'D2', 'Location', 'southoutside');
%
% Author:
%   Moses Yoo, (juyoung.m.yoo at gmail dot com)
%   2022-02-14: -Add support for reference axes at value zero.
%               -Allow for toggling radial and angular axes on or off.
%   2022-01-23: -Add ability to change figure/axes background color.
%               -Allow for toggling minor grid lines.
%   2022-01-03: Fix legend to include line and marker attributes.
%   2021-11-24: Fix axes labels misalignment. Add option to set offset for
%               data display values.
%   2021-11-09: Add option to change the text interpreter of axes labels
%               and axes tick labels.
%   2021-11-01: -Allow for plot lines and markers to be hidden.
%               -Allow for custom text of axes tick labels.
%   2021-04-17: Fix data display values when log scale is set.
%   2021-04-13: Add option to adjust line and marker transparency.
%   2021-04-08: -Add option for data values to be displayed on axes.
%               -Add support to adjust axes font colors.
%   2021-03-19: -Allow axes values to be shifted.
%               -Allow axes zoom level to be adjusted.
%   2020-12-09: Allow fill option and fill transparency for each data group.
%   2020-12-01: Added support for adjust the axes offset from origin.
%   2020-11-30: Allow for one data group without specified axes limits.
%   2020-11-30: Added support for changing axes and label font type.
%   2020-11-06: Fix bug in reverse axes direction feature.
%   2020-10-08: Adjust axes precision to be set to one or more axis.
%   2020-09-30: Updated examples and added ability to reverse axes direction.
%   2020-07-05: Added feature to change spider axes and axes labels edge color.
%   2020-06-17: Allow logarithmic scale to be set to one or more axis.
%   2020-03-26: Added feature to allow different line styles, line width,
%               marker type, and marker sizes for the data groups.
%   2020-02-12: Fixed condition and added error checking for when only one
%               data group is plotted.
%   2020-01-27: Corrected bug where only 7 entries were allowed in legend.
%   2020-01-06: Added support for subplot feature.
%   2019-11-27: Add option to change axes to logarithmic scale.
%   2019-11-15: Add feature to customize the plot rotational direction and
%               the offset position of the axis labels.
%   2019-10-23: Minor revision to set starting axes as the vertical line.
%               Add customization option for font sizes and axes display.
%   2019-10-16: Minor revision to add name-value pairs for customizing
%               color, marker, and line settings.
%   2019-10-08: Another major revision to convert to name-value pairs and
%               add color fill option.
%   2019-09-17: Major revision to improve speed, clarity, and functionality
%
% Special Thanks:
%   Special thanks to Gabriela Andrade, Andrés Garcia, Alex Grenyer,
%   Tobias Kern, Zafar Ali, Christophe Hurlin, Roman, Mariusz Sepczuk,
%   Mohamed Abubakr, Nicolai, Jingwei Too, Cedric Jamet, Richard Ruff,
%   Marie-Kristin Schreiber, Juan Carlos Vargas Rubio, Anthony Wang,
%   Pauline Oeuvray, Oliver Nicholls, Yu-Chi Chen, Fabrizio De Caro,
%   Waqas Ahmad & Mario Di Siena for their feature recommendations and bug
%   finds.

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
colors = lines(num_data_groups);
line_style = '-';
line_width = 2;
line_transparency = 1;
marker_type = 'o';
marker_size = 36;
marker_transparency = 1;
axes_font = 'Helvetica';
label_font = 'Helvetica';
axes_font_size = 10;
axes_font_color = [0, 0, 0];
label_font_size = 10;
direction = 'clockwise';
axes_direction = 'normal';
axes_labels_offset = 0.2;
axes_data_offset = 0.1;
axes_scaling = 'linear';
axes_color = [0.6, 0.6, 0.6];
axes_labels_edge = 'k';
axes_offset = 1;
axes_zoom = 0.7;
axes_horz_align = 'center';
axes_vert_align = 'middle';
plot_visible = 'on';
axes_tick_labels = 'data';
axes_interpreter = 'tex';
background_color = 'w';
minor_grid = 'off';
minor_grid_interval = 2;
axes_zero = 'off';
axes_zero_color = [0.6, 0.6, 0.6];
axes_zero_width = 2;
axes_radial = 'on';
axes_angular = 'on';

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
            case 'linetransparency'
                line_transparency = value_arguments{ii};
            case 'marker'
                marker_type = value_arguments{ii};
            case 'markersize'
                marker_size = value_arguments{ii};
            case 'markertransparency'
                marker_transparency = value_arguments{ii};
            case 'axesfont'
                axes_font = value_arguments{ii};
            case 'labelfont'
                label_font = value_arguments{ii};
            case 'axesfontsize'
                axes_font_size = value_arguments{ii};
            case 'axesfontcolor'
                axes_font_color = value_arguments{ii};
            case 'labelfontsize'
                label_font_size = value_arguments{ii};
            case 'direction'
                direction = value_arguments{ii};
            case 'axesdirection'
                axes_direction = value_arguments{ii};
            case 'axeslabelsoffset'
                axes_labels_offset = value_arguments{ii};
            case 'axesdataoffset'
                axes_data_offset = value_arguments{ii};
            case 'axesscaling'
                axes_scaling = value_arguments{ii};
            case 'axescolor'
                axes_color = value_arguments{ii};
            case 'axeslabelsedge'
                axes_labels_edge = value_arguments{ii};
            case 'axesoffset'
                axes_offset = value_arguments{ii};
            case 'axeszoom'
                axes_zoom = value_arguments{ii};
            case 'axeshorzalign'
                axes_horz_align = value_arguments{ii};
            case 'axesvertalign'
                axes_vert_align = value_arguments{ii};
            case 'plotvisible'
                plot_visible = value_arguments{ii};
            case 'axesticklabels'
                axes_tick_labels = value_arguments{ii};
            case 'axesinterpreter'
                axes_interpreter = value_arguments{ii};
            case 'backgroundcolor'
                background_color = value_arguments{ii};
            case 'minorgrid'
                minor_grid = value_arguments{ii};
            case 'minorgridinterval'
                minor_grid_interval = value_arguments{ii};
            case 'axeszero'
                axes_zero = value_arguments{ii};
            case 'axeszerowidth'
                axes_zero_width = value_arguments{ii};
            case 'axeszerocolor'
                axes_zero_color = value_arguments{ii};
            case 'axesradial'
                axes_radial = value_arguments{ii};
            case 'axesangular'
                axes_angular = value_arguments{ii};
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
    % Check if valid char entry
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
    
    % Lower and upper limits
    lower_limits = axes_limits(1, :);
    upper_limits = axes_limits(2, :);
    
    % Difference in upper and lower limits
    diff_limits = upper_limits - lower_limits;
    
    % Check to make sure upper limit is greater than lower limit
    if any(diff_limits < 0)
        error('Error: Please make sure max axes limits are greater than the min axes limits.');
    end
    
    % Check the range of axes limits
    if any(diff_limits == 0)
        error('Error: Please make sure the min and max axes limits are different.');
    end
end

% Check if axes precision is numeric
if isnumeric(axes_precision)
    % Check is length is one
    if length(axes_precision) == 1
        % Repeat array to number of data points
        axes_precision = repmat(axes_precision, num_data_points, 1);
    elseif length(axes_precision) ~= num_data_points
        error('Error: Please specify the same number of axes precision as number of data points.');
    end
else
    error('Error: Please make sure the axes precision is a numeric value.');
end

% Check if axes properties are an integer
if floor(axes_interval) ~= axes_interval || any(floor(axes_precision) ~= axes_precision)
    error('Error: Please enter in an integer for the axes properties.');
end

% Check if axes properties are positive
if axes_interval < 1 || any(axes_precision < 0)
    error('Error: Please enter a positive value for the axes properties.');
end

% Check if axes display is valid char entry
if ~ismember(axes_display, {'all', 'none', 'one', 'data'})
    error('Error: Invalid axes display entry. Please enter in "all", "none", or "one" to set axes text.');
end

% Check if fill option is valid
if any(~ismember(fill_option, {'off', 'on'}))
    error('Error: Please enter either "off" or "on" for fill option.');
end

% Check if fill transparency is valid
if any(fill_transparency < 0) || any(fill_transparency > 1)
    error('Error: Please enter a transparency value between [0, 1].');
end

% Check if line transparency is valid
if any(line_transparency < 0) || any(line_transparency > 1)
    error('Error: Please enter a transparency value between [0, 1].');
end

% Check if marker transparency is valid
if any(marker_transparency < 0) || any(marker_transparency > 1)
    error('Error: Please enter a transparency value between [0, 1].');
end

% Check if font size is greater than zero
if axes_font_size <= 0 || label_font_size <= 0
    error('Error: Please enter a font size greater than zero.');
end

% Check if direction is valid char entry
if ~ismember(direction, {'counterclockwise', 'clockwise'})
    error('Error: Invalid direction entry. Please enter in "counterclockwise" or "clockwise" to set direction of rotation.');
end

% Check if axes direction is valid char entry
if ~ismember(axes_direction, {'normal', 'reverse'})
    error('Error: Invalid axes direction entry. Please enter in "normal" or "reverse" to set axes direction.');
end

% Check if axes labels offset is positive
if axes_labels_offset < 0
    error('Error: Please enter a positive for the axes labels offset.');
end

% Check if axes data offset is positive
if axes_data_offset < 0
    error('Error: Please enter a positive for the axes data offset.');
end

% Check if axes scaling is valid
if any(~ismember(axes_scaling, {'linear', 'log'}))
    error('Error: Invalid axes scaling entry. Please enter in "linear" or "log" to set axes scaling.');
end

% Check if axes offset is valid
if floor(axes_offset)~=axes_offset || axes_offset < 0 || axes_offset > axes_interval
    error('Error: Invalid axes offset entry. Please enter in an integer value that is between [0, axes_interval].');
end

% Check if axes zoom value is valid
if ~isnumeric(axes_zoom) || length(axes_zoom) ~= 1 || axes_zoom < 0 || axes_zoom > 1
    error('Error: Please enter an axes zoom value between [0, 1].');
end

% Check if axes horizontal alignment is valid
if any(~ismember(axes_horz_align, {'center', 'left', 'right', 'quadrant'}))
    error('Error: Invalid axes horizontal alignment entry.');
end

% Check if axes vertical alignment is valid
if any(~ismember(axes_vert_align, {'middle', 'top', 'cap', 'bottom', 'baseline', 'quadrant'}))
    error('Error: Invalid axes vertical alignment entry.');
end

% Check if plot visible is valid
if ~ismember(plot_visible, {'on', 'off'})
    error('Error: Invalid plot visible entry. Please enter in "on" or "off" to set plot visiblity.');
end

% Check if axes interpreter is valid
if any(~ismember(axes_interpreter, {'tex', 'latex', 'none'}))
    error('Error: Please enter either "tex", "latex", or "none" for axes interpreter option.');
end

% Check if minor grid is valid
if ~ismember(minor_grid, {'on', 'off'})
    error('Error: Invalid minor grid entry. Please enter in "on" or "off" to toggle minor grid.');
end

% Check if axes zero is valid
if ~ismember(axes_zero, {'on', 'off'})
    error('Error: Invalid axes zero entry. Please enter in "on" or "off" to set axes visiblity.');
end

% Check if axes radial is valid
if ~ismember(axes_radial, {'on', 'off'})
    error('Error: Invalid axes radial entry. Please enter in "on" or "off" to set axes visiblity.');
end

% Check if axes angular is valid
if ~ismember(axes_angular, {'on', 'off'})
    error('Error: Invalid axes angular entry. Please enter in "on" or "off" to set axes visiblity.');
end

% Check if axes zero line width is numeric
if ~isnumeric(axes_zero_width)
    error('Error: Please make sure the axes zero width is a numeric value.');
end

% Check if minor grid interval is valid
if floor(minor_grid_interval)~=minor_grid_interval || minor_grid_interval < 0
    error('Error: Invalid minor grid interval entry. Please enter in an integer value that is positive.');
end

% Check if axes interpreter is a char
if ischar(axes_interpreter)
    % Convert to cell array of char
    axes_interpreter = cellstr(axes_interpreter);
    
    % Repeat cell to number of data groups
    axes_interpreter = repmat(axes_interpreter, length(axes_labels), 1);
elseif iscellstr(axes_interpreter)
    % Check is length is one
    if length(axes_interpreter) == 1
        % Repeat cell to number of data groups
        axes_interpreter = repmat(axes_interpreter, length(axes_labels), 1);
    elseif length(axes_interpreter) ~= length(axes_labels)
        error('Error: Please specify the same number of axes interpreters as axes labels.');
    end
else
    error('Error: Please make sure the axes interpreter is a char or a cell array of char.');
end

% Check if axes tick labels is valid
if iscell(axes_tick_labels)
    if length(axes_tick_labels) ~= axes_interval+1
        error('Error: Invalid axes tick labels entry. Please enter in a cell array with the same length of axes interval + 1.');
    end
else
    if ~strcmp(axes_tick_labels, 'data')
        error('Error: Invalid axes tick labels entry. Please enter in "data" or a cell array of desired tick labels.');
    end
end

% Check if axes scaling is a cell
if iscell(axes_scaling)
    % Check is length is one
    if length(axes_scaling) == 1
        % Repeat array to number of data groups
        axes_scaling = repmat(axes_scaling, num_data_points, 1);
    elseif length(axes_scaling) ~= num_data_points
        error('Error: Please specify the same number of axes scaling as number of data points.');
    end
else
    % Repeat array to number of data groups
    axes_scaling = repmat({axes_scaling}, num_data_points, 1);
end

% Check if line style is a char
if ischar(line_style)
    % Convert to cell array of char
    line_style = cellstr(line_style);
    
    % Repeat cell to number of data groups
    line_style = repmat(line_style, num_data_groups, 1);
elseif iscellstr(line_style)
    % Check is length is one
    if length(line_style) == 1
        % Repeat cell to number of data groups
        line_style = repmat(line_style, num_data_groups, 1);
    elseif length(line_style) ~= num_data_groups
        error('Error: Please specify the same number of line styles as number of data groups.');
    end
else
    error('Error: Please make sure the line style is a char or a cell array of char.');
end

% Check if line width is numeric
if isnumeric(line_width)
    % Check is length is one
    if length(line_width) == 1
        % Repeat array to number of data groups
        line_width = repmat(line_width, num_data_groups, 1);
    elseif length(line_width) ~= num_data_groups
        error('Error: Please specify the same number of line width as number of data groups.');
    end
else
    error('Error: Please make sure the line width is a numeric value.');
end

% Check if marker type is a char
if ischar(marker_type)
    % Convert to cell array of char
    marker_type = cellstr(marker_type);
    
    % Repeat cell to number of data groups
    marker_type = repmat(marker_type, num_data_groups, 1);
elseif iscellstr(marker_type)
    % Check is length is one
    if length(marker_type) == 1
        % Repeat cell to number of data groups
        marker_type = repmat(marker_type, num_data_groups, 1);
    elseif length(marker_type) ~= num_data_groups
        error('Error: Please specify the same number of line styles as number of data groups.');
    end
else
    error('Error: Please make sure the line style is a char or a cell array of char.');
end

% Check if line width is numeric
if isnumeric(marker_size)
    if length(marker_size) == 1
        % Repeat array to number of data groups
        marker_size = repmat(marker_size, num_data_groups, 1);
    elseif length(marker_size) ~= num_data_groups
        error('Error: Please specify the same number of line width as number of data groups.');
    end
else
    error('Error: Please make sure the line width is numeric.');
end

% Check if axes direction is a cell
if iscell(axes_direction)
    % Check is length is one
    if length(axes_direction) == 1
        % Repeat array to number of data points
        axes_direction = repmat(axes_direction, num_data_points, 1);
    elseif length(axes_direction) ~= num_data_points
        error('Error: Please specify the same number of axes direction as number of data points.');
    end
else
    % Repeat array to number of data points
    axes_direction = repmat({axes_direction}, num_data_points, 1);
end

% Check if fill option is a cell
if iscell(fill_option)
    % Check is length is one
    if length(fill_option) == 1
        % Repeat array to number of data groups
        fill_option = repmat(fill_option, num_data_groups, 1);
    elseif length(fill_option) ~= num_data_groups
        error('Error: Please specify the same number of fill option as number of data groups.');
    end
else
    % Repeat array to number of data groups
    fill_option = repmat({fill_option}, num_data_groups, 1);
end

% Check if fill transparency is numeric
if isnumeric(fill_transparency)
    % Check is length is one
    if length(fill_transparency) == 1
        % Repeat array to number of data groups
        fill_transparency = repmat(fill_transparency, num_data_groups, 1);
    elseif length(fill_transparency) ~= num_data_groups
        error('Error: Please specify the same number of fill transparency as number of data groups.');
    end
else
    error('Error: Please make sure the transparency is a numeric value.');
end

% Check if line transparency is numeric
if isnumeric(line_transparency)
    % Check is length is one
    if length(line_transparency) == 1
        % Repeat array to number of data groups
        line_transparency = repmat(line_transparency, num_data_groups, 1);
    elseif length(line_transparency) ~= num_data_groups
        error('Error: Please specify the same number of line transparency as number of data groups.');
    end
else
    error('Error: Please make sure the transparency is a numeric value.');
end

% Check if marker transparency is numeric
if isnumeric(marker_transparency)
    % Check is length is one
    if length(marker_transparency) == 1
        % Repeat array to number of data groups
        marker_transparency = repmat(marker_transparency, num_data_groups, 1);
    elseif length(marker_transparency) ~= num_data_groups
        error('Error: Please specify the same number of marker transparency as number of data groups.');
    end
else
    error('Error: Please make sure the transparency is a numeric value.');
end

% Check if axes display is data
if strcmp(axes_display, 'data')
    if size(axes_font_color, 1) ~= num_data_groups
        % Check axes font color dimensions
        if size(axes_font_color, 1) == 1 && size(axes_font_color, 2) == 3
            axes_font_color = repmat(axes_font_color, num_data_groups, 1);
        else
            error('Error: Please specify axes font color as a RGB triplet normalized to 1.');
        end
    end
end

%%% Axes Scaling Properties %%%
% Selected data
P_selected = P;
            
% Check axes scaling option
log_index = strcmp(axes_scaling, 'log');

% If any log scaling is specified
if any(log_index)
    % Initialize copy
    P_log = P_selected(:, log_index);
    
    % Logarithm of base 10, account for numbers less than 1
    P_log = sign(P_log) .* log10(abs(P_log));
    
    % Minimum and maximun log limits
    min_limit = min(min(fix(P_log)));
    max_limit = max(max(ceil(P_log)));
    recommended_axes_interval = max_limit - min_limit;
    
    % Warning message
    warning('For the log scale values, recommended axes limit is [%i, %i] with an axes interval of %i.',...
        10^min_limit, 10^max_limit, recommended_axes_interval);
    
    % Replace original
    P_selected(:, log_index) = P_log;
end

%%% Figure Properties %%%
% Grab current figure
fig = gcf;
if nargout > 1
    error('Error: Too many output arguments assigned.');
end
varargout{1} = fig;

% Set figure background
fig.Color = background_color;

% Reset axes
cla reset;

% Current axes handle
ax = gca;
ax.Color = background_color;

% Axis limits
hold on;
axis square;
scaling_factor = 1 + (1 - axes_zoom);
axis([-1, 1, -1, 1] * scaling_factor);

% Axis properties
ax.XTickLabel = [];
ax.YTickLabel = [];
ax.XColor = 'none';
ax.YColor = 'none';

% Polar increments
theta_increment = 2*pi/num_data_points;
full_interval = axes_interval + 1;
rho_offset = axes_offset/full_interval;

%%% Scale Data %%%
% Pre-allocation
P_scaled = zeros(size(P_selected));
axes_range = zeros(3, num_data_points);

% Check axes scaling option
axes_direction_index = strcmp(axes_direction, 'reverse');

% Iterate through number of data points
for ii = 1:num_data_points
    % Check for one data group and no axes limits
    if num_data_groups == 1 && isempty(axes_limits)
        % Group of points
        group_points = P_selected(:, :);
    else
        % Group of points
        group_points = P_selected(:, ii);
    end
    
    % Check for log axes scaling option
    if log_index(ii)
        % Minimum and maximun log limits
        min_value = min(fix(group_points));
        max_value = max(ceil(group_points));
    else
        % Automatically the range of each group
        min_value = min(group_points);
        max_value = max(group_points);
    end
    
    % Range of min and max values
    range = max_value - min_value;
    
    % Check if axes_limits is not empty
    if ~isempty(axes_limits)
        % Check for log axes scaling option
        if log_index(ii)
            % Logarithm of base 10, account for numbers less than 1
            axes_limits(:, ii) = sign(axes_limits(:, ii)) .* log10(abs(axes_limits(:, ii))); %#ok<AGROW>
        end
        
        % Manually set the range of each group
        min_value = axes_limits(1, ii);
        max_value = axes_limits(2, ii);
        range = max_value - min_value;
        
        % Check if the axes limits are within range of points
        if min_value > min(group_points) || max_value < max(group_points)
            error('Error: Please make sure the manually specified axes limits are within range of the data points.');
        end
    end
    
    % Check if range is valid
    if range == 0
        error('Error: Range of data values is not valid. Please specify the axes limits.');
    end
    
    % Scale points to range from [0, 1]
    P_scaled(:, ii) = ((P_selected(:, ii) - min_value) / range);
    
    % If reverse axes direction is specified
    if axes_direction_index(ii)
        % Store to array
        axes_range(:, ii) = [max_value; min_value; range];
        P_scaled(:, ii) = -(P_scaled(:, ii) - 1);
    else
        % Store to array
        axes_range(:, ii) = [min_value; max_value; range];
    end
    
    % Add offset of [rho_offset] and scaling factor of [1 - rho_offset]
    P_scaled(:, ii) = P_scaled(:, ii) * (1 - rho_offset) + rho_offset;
end

%%% Polar Axes %%%
% Polar coordinates
rho_increment = 1/full_interval;
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

% Check if axes radial is toggled on
if strcmp(axes_radial, 'on')
    % Iterate through each theta
    for ii = 1:length(theta)-1
        % Convert polar to cartesian coordinates
        [x_axes, y_axes] = pol2cart(theta(ii), rho);

        % Plot webs
        h = plot(x_axes, y_axes,...
            'LineWidth', 1.5,...
            'Color', axes_color);

        % Turn off legend annotation
        h.Annotation.LegendInformation.IconDisplayStyle = 'off';
    end
end

% Check if axes angular is toggled on
if strcmp(axes_angular, 'on')
    % Iterate through each rho
    for ii = 2:length(rho)
        % Convert polar to cartesian coordinates
        [x_axes, y_axes] = pol2cart(theta, rho(ii));

        % Plot axes
        h = plot(x_axes, y_axes,...
            'Color', axes_color);

        % Turn off legend annotation
        h.Annotation.LegendInformation.IconDisplayStyle = 'off';
    end
end

% Check if minor grid is toggled on
if strcmp(minor_grid, 'on')
    % Polar coordinates
    rho_minor_increment = 1/(full_interval*minor_grid_interval);
    rho_minor = rho(2):rho_minor_increment:1;
    rho_minor = setdiff(rho_minor, rho(2:end));

    % Iterate through each rho minor
    for ii = 1:length(rho_minor)
        % Convert polar to cartesian coordinates
        [x_axes, y_axes] = pol2cart(theta, rho_minor(ii));

        % Plot axes
        h = plot(x_axes, y_axes, '--',...
            'Color', axes_color,...
            'LineWidth', 0.5);

        % Turn off legend annotation
        h.Annotation.LegendInformation.IconDisplayStyle = 'off';
    end
end

% Check if axes zero is toggled on
if strcmp(axes_zero, 'on') && strcmp(axes_display, 'one')
     % Scale points to range from [0, 1]
    zero_scaled = (0 - min_value) / range;
    
    % If reverse axes direction is specified
    if strcmp(axes_direction, 'reverse')
        zero_scaled = -zero_scaled - 1;
    end

    % Add offset of [rho_offset] and scaling factor of [1 - rho_offset]
    zero_scaled = zero_scaled * (1 - rho_offset) + rho_offset;

    % Convert polar to cartesian coordinates
    [x_axes, y_axes] = pol2cart(theta, zero_scaled);

    % Plot webs
    h = plot(x_axes, y_axes,...
        'LineWidth', axes_zero_width,...
        'Color', axes_zero_color);

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
    case 'data'
        theta_end_index = 0;
end

% Rho start index and offset interval
rho_start_index = axes_offset+1;
offset_interval = full_interval - axes_offset;

% Alignment for axes labels
horz_align = axes_horz_align;
vert_align = axes_vert_align;

% Iterate through each theta
for ii = 1:theta_end_index
    % Convert polar to cartesian coordinates
    [x_axes, y_axes] = pol2cart(theta(ii), rho);
    
    % Check if horizontal alignment is quadrant based
    if strcmp(axes_horz_align, 'quadrant')
        % Alignment based on quadrant
        [horz_align, ~] = quadrant_position(theta(ii));
    end
    
    % Check if vertical alignment is quadrant based
    if strcmp(axes_vert_align, 'quadrant')
        % Alignment based on quadrant
        [~, vert_align] = quadrant_position(theta(ii));
    end
    
    % Iterate through points on isocurve
    for jj = rho_start_index:length(rho)
        % Axes increment range
        min_value = axes_range(1, ii);
        range = axes_range(3, ii);
        
        % If reverse axes direction is specified
        if axes_direction_index(ii)
            % Axes increment value
            axes_value = min_value - (range/offset_interval) * (jj-rho_start_index);
        else
            % Axes increment value
            axes_value = min_value + (range/offset_interval) * (jj-rho_start_index);
        end
        
        % Check for log axes scaling option
        if log_index(ii)
            % Exponent to the tenth power
            axes_value = 10^axes_value;
        end
        
        % Display axes text
        if strcmp(axes_tick_labels, 'data')
            text_str = sprintf(sprintf('%%.%if', axes_precision(ii)), axes_value);
        else
            text_str = axes_tick_labels{jj-axes_offset};
        end

        t = text(x_axes(jj), y_axes(jj), text_str,...
            'Units', 'Data',...
            'Color', axes_font_color,...
            'FontName', axes_font,...
            'FontSize', axes_font_size,...
            'HorizontalAlignment', horz_align,...
            'VerticalAlignment', vert_align);

        % Apply to axes tick labels only when not data
        if iscellstr(axes_tick_labels)
            t.Interpreter = axes_interpreter{1};
        end
    end
end

%%% Plot %%%
% Fill option index
fill_option_index = strcmp(fill_option, 'on');

% Iterate through number of data groups
for ii = 1:num_data_groups
    % Convert polar to cartesian coordinates
    [x_points, y_points] = pol2cart(theta(1:end-1), P_scaled(ii, :));
    
    % Make points circular
    x_circular = [x_points, x_points(1)];
    y_circular = [y_points, y_points(1)];
    
    % Plot data points
    h = plot(x_circular, y_circular,...
        'LineStyle', line_style{ii},...
        'Color', colors(ii, :),...
        'LineWidth', line_width(ii),...
        'Visible', plot_visible);
    h.Color(4) = line_transparency(ii);
    
    % Turn off legend annotation
    h.Annotation.LegendInformation.IconDisplayStyle = 'off';

    h = scatter(x_circular, y_circular,...
        'Marker', marker_type{ii},...
        'SizeData', marker_size(ii),...
        'MarkerFaceColor', colors(ii, :),...
        'MarkerEdgeColor', colors(ii, :),...
        'MarkerFaceAlpha', marker_transparency(ii),...
        'MarkerEdgeAlpha', marker_transparency(ii),...
        'Visible', plot_visible);
    
    % Turn off legend annotation
    h.Annotation.LegendInformation.IconDisplayStyle = 'off';

    % Plot empty line with combined attributes for legend
    plot(nan, nan,...
        'Marker', marker_type{ii},...
        'MarkerSize', marker_size(ii)/6,...
        'MarkerFaceColor', colors(ii, :),...
        'MarkerEdgeColor', colors(ii, :),...
        'LineStyle', line_style{ii},...
        'Color', colors(ii, :),...
        'LineWidth', line_width(ii),...
        'Visible', plot_visible);
    
    % Iterate through number of data points
    if strcmp(axes_display, 'data')
        for jj = 1:num_data_points
            % Convert polar to cartesian coordinates
            [current_theta, current_rho] = cart2pol(x_points(jj), y_points(jj));
            [x_pos, y_pos] = pol2cart(current_theta, current_rho+axes_data_offset);
            
            % Display axes text
            data_value = P(ii, jj);
            text_str = sprintf(sprintf('%%.%if', axes_precision(jj)), data_value);
            text(x_pos, y_pos, text_str,...
                'Units', 'Data',...
                'Color', axes_font_color(ii, :),...
                'FontName', axes_font,...
                'FontSize', axes_font_size,...
                'HorizontalAlignment', 'center',...
                'VerticalAlignment', 'middle');
        end
    end
    
    % Check if fill option is toggled on
    if fill_option_index(ii)
        % Fill area within polygon
        h = patch(x_circular, y_circular, colors(ii, :),...
            'EdgeColor', 'none',...
            'FaceAlpha', fill_transparency(ii));
        
        % Turn off legend annotation
        h.Annotation.LegendInformation.IconDisplayStyle = 'off';
    end
end

% Find object handles
text_handles = findobj(ax.Children,...
    'Type', 'Text');
patch_handles = findobj(ax.Children,...
    'Type', 'Patch');
isocurve_handles = findobj(ax.Children,...
    'Color', axes_color,...
    '-and', 'Type', 'Line');
plot_handles = findobj(ax.Children, '-not',...
    'Color', axes_color,...
    '-and', 'Type', 'Line');

% Manually set the stack order
uistack(plot_handles, 'bottom');
uistack(patch_handles, 'bottom');
uistack(isocurve_handles, 'bottom');
uistack(text_handles, 'top');

%%% Labels %%%
% Check labels argument
if ~strcmp(axes_labels, 'none')
    % Iterate through number of data points
    for ii = 1:length(axes_labels)
        % Convert polar to cartesian coordinates
        [x_pos, y_pos] = pol2cart(theta(ii), rho(end)+axes_labels_offset);

        % Horizontal text alignment by quadrant
        [horz_align, ~] = quadrant_position(theta(ii));

        % Display text label
        text(x_pos, y_pos, axes_labels{ii},...
            'Units', 'Data',...
            'HorizontalAlignment', horz_align,...
            'VerticalAlignment', 'middle',...
            'EdgeColor', axes_labels_edge,...
            'BackgroundColor', background_color,...
            'FontName', label_font,...
            'FontSize', label_font_size,...
            'Interpreter', axes_interpreter{ii});
    end
end

    function [horz_align, vert_align] = quadrant_position(theta_point)
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
            case 1
                horz_align = 'left';
                vert_align = 'bottom';
            case 1.5
                horz_align = 'center';
                vert_align = 'bottom';
            case 2
                horz_align = 'right';
                vert_align = 'bottom';
            case 2.5
                horz_align = 'right';
                vert_align = 'middle';
            case 3
                horz_align = 'right';
                vert_align = 'top';
            case 3.5
                horz_align = 'center';
                vert_align = 'top';
            case 4
                horz_align = 'left';
                vert_align = 'top';
        end
    end
end