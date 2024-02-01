function varargout = spider_plot(P, varargin)
%spider_plot Create a spider or radar plot with individual axes.
%
% Syntax:
%   spider_plot(P)
%   spider_plot(P, Name, Value, ...)
%   h = spider_plot(_)
%
% Documentation:
%   Please refer to the MathWorks File Exchange or GitHub page for the
%   detailed documentation and examples.

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

% Replace Inf with NaN
P_limits = P;
inf_index = isinf(P_limits);
P_limits(inf_index) = nan;

% Default arguments
axes_interval = 3;
axes_precision = 1;
axes_display = 'all';
axes_limits = [min(P_limits, [], 1); max(P_limits, [], 1)];
fill_option = 'off';
fill_transparency = 0.2;
fill_cdata = [];
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
axes_tick_interpreter = 'tex';
background_color = 'w';
minor_grid = 'off';
minor_grid_interval = 2;
axes_zero = 'off';
axes_zero_color = [0.6, 0.6, 0.6];
axes_zero_width = 2;
axes_radial = 'on';
axes_web = 'on';
axes_shaded = 'off';
axes_shaded_limits = {axes_limits};
axes_shaded_color = 'g';
axes_shaded_transparency = 0.2;
axes_labels_rotate = 'off';
axes_handle = gobjects;
error_bars = 'off';
error_positive = [];
error_negative = [];
axes_web_type = 'web';
axes_tick_format = 'default';
axes_start = pi/2;
axes_radial_line_width = 1.5;
axes_radial_line_style = '-';
axes_web_line_width = 1;
axes_web_line_style = '-';

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
            case 'fillcdata'
                fill_cdata = value_arguments{ii};
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
            case 'axestickinterpreter'
                axes_tick_interpreter = value_arguments{ii};
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
            case 'axesweb'
                axes_web = value_arguments{ii};
            case 'axesshaded'
                axes_shaded = value_arguments{ii};
            case 'axesshadedlimits'
                axes_shaded_limits = value_arguments{ii};
            case 'axesshadedcolor'
                axes_shaded_color = value_arguments{ii};
            case 'axesshadedtransparency'
                axes_shaded_transparency = value_arguments{ii};
            case 'axeslabelsrotate'
                axes_labels_rotate = value_arguments{ii};
            case 'axeshandle'
                axes_handle = value_arguments{ii};
            case 'errorbars'
                error_bars = value_arguments{ii};
            case 'errorpositive'
                error_positive = value_arguments{ii};
            case 'errornegative'
                error_negative = value_arguments{ii};
            case 'axeswebtype'
                axes_web_type = value_arguments{ii};
            case 'axestickformat'
                axes_tick_format = value_arguments{ii};
            case 'axesstart'
                axes_start = value_arguments{ii};
            case 'axesradiallinewidth'
                axes_radial_line_width = value_arguments{ii};
            case 'axesradiallinestyle'
                axes_radial_line_style = value_arguments{ii};
            case 'axesweblinewidth'
                axes_web_line_width = value_arguments{ii};
            case 'axesweblinestyle'
                axes_web_line_style = value_arguments{ii};
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
    error('Error: Please set the axes limits and make sure the min and max axes limits are different.');
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
if ~ismember(axes_display, {'all', 'none', 'one', 'data', 'data-percent'})
    error('Error: Invalid axes display entry. Please enter in "all", "none", "one", "data", or "data-percent" to set axes text.');
end

% Check if fill option is valid
if any(~ismember(fill_option, {'off', 'on', 'interp'}))
    error('Error: Please enter either "off", "on" or "interp" for fill option.');
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

% Check if axes tick interpreter is valid
if any(~ismember(axes_tick_interpreter, {'tex', 'latex', 'none'}))
    error('Error: Please enter either "tex", "latex", or "none" for axes tick interpreter option.');
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

% Check if axes web is valid
if ~ismember(axes_web, {'on', 'off'})
    error('Error: Invalid axes web entry. Please enter in "on" or "off" to set axes visiblity.');
end

% Check if axes zero line width is numeric
if ~isnumeric(axes_zero_width)
    error('Error: Please make sure the axes zero width is a numeric value.');
end

% Check if minor grid interval is valid
if floor(minor_grid_interval)~=minor_grid_interval || minor_grid_interval < 0
    error('Error: Invalid minor grid interval entry. Please enter in an integer value that is positive.');
end

% Check if axes shaded is valid
if any(~ismember(axes_shaded, {'off', 'on'}))
    error('Error: Please enter either "off" or "on" for axes shaded option.');
end

% Check if axes shaded transparency is valid
if any(axes_shaded_transparency < 0) || any(axes_shaded_transparency > 1)
    error('Error: Please enter a transparency value between [0, 1].');
end

% Check if error bars is valid
if any(~ismember(error_bars, {'off', 'on'}))
    error('Error: Please enter either "off" or "on" for error bars option.');
end

% Check if error positive and error negative are valid
if strcmp(error_bars, 'on') &&...
        ~isempty(error_positive) &&...
        ~isempty(error_negative)
    % Check that the length match the data points
    if length(error_positive) ~= num_data_points
        error('Error: Please make sure the number of error positive elements equal the data points');
    end

    % Check that the length match the data points
    if length(error_negative) ~= num_data_points
        error('Error: Please make sure the number of error negative elements equal the data points');
    end
end

% Check if axes web type is valid
if any(~ismember(axes_web_type, {'web', 'circular'}))
    error('Error: Please enter either "web" or "circular" for axes web type option.');
end

% Check if axes start is valid
if ~(axes_start >= 0 && axes_start <= 2*pi)
    error('Error: Please select an axes start value between [0, 2pi].')
end

% Check if axes shaded limits is empty
if isempty(axes_shaded_limits)
    axes_shaded_limits = {axes_limits};
elseif iscell(axes_shaded_limits)
    % Iterate through axes shaded limits
    for ii = 1:length(axes_shaded_limits)
        % Initialize
        axes_shaded_limit = axes_shaded_limits{ii};

        % Check if the axes shaded limits same length as the number of points
        if size(axes_shaded_limit, 1) ~= 2 || size(axes_shaded_limit, 2) ~= num_data_points
            error('Error: Please make sure the min and max axes shaded limits match the number of data points.');
        end

        % Check if within min and max axes limits
        if any(axes_shaded_limit(1, :) < axes_limits(1, :)) ||...
                any(axes_shaded_limit(2, :) > axes_limits(2, :))
            error('Error: Please make sure the axes shaded limits are within the min and max axes limits.');
        end
    end
else
    error('Error: Please make sure the axes shaded limits are in a cell array.');
end

% Check if axes shaded color is a char
if ischar(axes_shaded_color)
    % Convert to cell array of char
    axes_shaded_color = cellstr(axes_shaded_color);

    % Repeat cell to number of axes shaded limits groups
    axes_shaded_color = repmat(axes_shaded_color, length(axes_shaded_limits), 1);
elseif iscellstr(axes_shaded_color)
    % Check is length is one
    if length(axes_shaded_color) == 1
        % Repeat cell to number of axes shaded limits groups
        axes_shaded_color = repmat(axes_shaded_color, length(axes_shaded_limits), 1);
    end
end

% Check if axes shaded color is valid
if length(axes_shaded_color) ~= length(axes_shaded_limits)
    error('Error: Please specify the same number of axes shaded color as number of axes shaded limits groups.');
end

% Check if axes shaded transparency is numeric
if isnumeric(axes_shaded_transparency)
    % Check is length is one
    if length(axes_shaded_transparency) == 1
        % Repeat array to number of axes shaded limits groups
        axes_shaded_transparency = repmat(axes_shaded_transparency, length(axes_shaded_limits), 1);
    elseif length(axes_shaded_transparency) ~= length(axes_shaded_limits)
        error('Error: Please specify the same number of axes shaded transparency as number axes shaded limits groups.');
    end
else
    error('Error: Please make sure the axes shaded transparency is a numeric value.');
end

% Check if axes labels rotate is valid
if any(~ismember(axes_labels_rotate, {'off', 'on'}))
    error('Error: Please enter either "off" or "on" for axes labels rotate option.');
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

% Check if axes tick interpreter is a char
if ischar(axes_tick_interpreter)
    % Convert to cell array of char
    axes_tick_interpreter = cellstr(axes_tick_interpreter);

    % Repeat cell to number of data groups
    axes_tick_interpreter = repmat(axes_tick_interpreter, length(axes_labels), 1);
elseif iscellstr(axes_tick_interpreter)
    % Check is length is one
    if length(axes_tick_interpreter) == 1
        % Repeat cell to number of data groups
        axes_tick_interpreter = repmat(axes_tick_interpreter, length(axes_labels), 1);
    elseif length(axes_tick_interpreter) ~= length(axes_labels)
        error('Error: Please specify the same number of axes tick interpreters as axes labels.');
    end
else
    error('Error: Please make sure the axes tick interpreter is a char or a cell array of char.');
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

% Check fill data
if all(strcmp(fill_option, 'interp'))
    if isempty(fill_cdata)
        error('Error: Please enter in a valid fill cdata.');
    else
        if length(fill_cdata) ~= num_data_points
            error('Error: Please make sure that fill cdata matches the number of data points.');
        end
    end
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
if ismember(axes_display, {'data', 'data-percent'})
    if size(axes_font_color, 1) ~= num_data_groups
        % Check axes font color dimensions
        if size(axes_font_color, 1) == 1 && size(axes_font_color, 2) == 3
            axes_font_color = repmat(axes_font_color, num_data_groups, 1);
        else
            error('Error: Please specify axes font color as a RGB triplet normalized to 1.');
        end
    end
end

% Check if axes tick format is a char
if ischar(axes_tick_format)
    % Convert to cell array of char
    axes_tick_format = cellstr(axes_tick_format);

    % Repeat cell to number of axes shaded limits groups
    axes_tick_format = repmat(axes_tick_format, num_data_points, 1);
elseif iscellstr(axes_tick_format)
    % Check is length is one
    if length(axes_tick_format) == 1
        % Repeat cell to number of axes shaded limits groups
        axes_tick_format = repmat(axes_tick_format, num_data_points, 1);
    end
else
    error('Error: Please a character array or cell of character array for axes tick format.');
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
% Check if axes handle is specified
if isempty(properties(axes_handle))
    % Grab current figure
    fig = gcf;

    % Reset axes
    cla reset;

    % Current axes handle
    ax = gca;
else
    % Use specified axes handle
    ax = axes_handle;
    axes(ax);

    % Grab figure handle of specified axes handle
    fig = ax.Parent;
end

% Check for output arguments
if nargout > 1
    error('Error: Too many output arguments assigned.');
end
varargout{1} = fig;

% Set figure and axes background
if isprop(fig, "Color")
    fig.Color = background_color;
end

ax.Color = background_color;

% Axis limits
hold(ax, 'on');
axis(ax, 'square');
scaling_factor = 1 + (1 - axes_zoom);
axis(ax, [-1, 1, -1, 1] * scaling_factor);

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
% Number of shaded rows
num_shaded = length(axes_shaded_limits);
shaded_rows = num_shaded * 2;

% Check if axes shaded is on
if strcmp(axes_shaded, 'on')
    % Concatenate
    all_shaded_limits = vertcat(axes_shaded_limits{:});

    % If any log scaling is specified
    if any(log_index)
        % Initialize copy
        A_log = all_shaded_limits(:, log_index);

        % Logarithm of base 10, account for numbers less than 1
        A_log = sign(A_log) .* log10(abs(A_log));

        % Update
        all_shaded_limits(:, log_index) = A_log;
    end

    % Append
    P_selected = [P_selected; all_shaded_limits];
end

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

    % Replace Inf with NaN
    inf_index = isinf(group_points);
    group_points(inf_index) = nan;

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
            axes_limits(:, ii) = sign(axes_limits(:, ii)) .* log10(abs(axes_limits(:, ii)));
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

% Check if axes shaded is on
if strcmp(axes_shaded, 'on')
    P_shaded = P_scaled(end-shaded_rows+1:end, :);
    P_scaled = P_scaled(1:end-shaded_rows, :);
end

%%% Polar Axes %%%
% Polar coordinates
rho_increment = 1/full_interval;
rho = 0:rho_increment:1;

% Check rotational direction
switch direction
    case 'counterclockwise'
        % Shift the starting axis
        theta = (0:theta_increment:2*pi) + axes_start;
    case 'clockwise'
        % Shift the starting axes
        theta = (0:-theta_increment:-2*pi) + axes_start;
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
        h = plot(ax, x_axes, y_axes,...
            'LineStyle', axes_radial_line_style,...
            'LineWidth', axes_radial_line_width,...
            'Color', axes_color);

        % Turn off legend annotation
        h.Annotation.LegendInformation.IconDisplayStyle = 'off';
    end
end

% Check axes web type
if strcmp(axes_web_type, 'web')
    theta_web = theta;
elseif strcmp(axes_web_type, 'circular')
    theta_web = 0:((2*pi)/(2^7)):2*pi;
end

% Check if axes web is toggled on
if strcmp(axes_web, 'on')
    % Iterate through each rho
    for ii = 2:length(rho)
        % Convert polar to cartesian coordinates
        [x_axes, y_axes] = pol2cart(theta_web, rho(ii));

        % Plot axes
        h = plot(ax, x_axes, y_axes,...
            'LineStyle', axes_web_line_style,...
            'LineWidth', axes_web_line_width,...
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
        h = plot(ax, x_axes, y_axes, '--',...
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
    h = plot(ax, x_axes, y_axes,...
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
    case 'data-percent'
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
            % Check axes tick format option
            if strcmp(axes_tick_format{ii}, 'default')
                text_format = sprintf('%%.%if', axes_precision(ii));
            else
                text_format = axes_tick_format{ii};
            end

            % Formatted axes tick text
            text_str = sprintf(text_format, axes_value);
        else
            text_str = axes_tick_labels{jj-axes_offset};
        end

        t = text(ax, x_axes(jj), y_axes(jj), text_str,...
            'Units', 'Data',...
            'Color', axes_font_color,...
            'FontName', axes_font,...
            'FontSize', axes_font_size,...
            'HorizontalAlignment', horz_align,...
            'VerticalAlignment', vert_align,...
            'Interpreter', axes_tick_interpreter{ii});
    end
end

%%% Plot %%%
% Check if any NaNs detected
if any(isnan(P_scaled), 'all')
    % Set value to zero
    nan_index = isnan(P_scaled);
    P_scaled(nan_index) = 0;
end

% Check if error bars are desired
if strcmp(error_bars, 'on')
    % Calculate mean and standard deviation
    P_mean = mean(P, 1);
    P_std = std(P, 0, 1);

    % Check if plus or minus error is specified
    if isempty(error_positive) ||...
            isempty(error_negative)
        % Default values
        error_positive = P_std;
        error_negative = P_std;
    end

    % Display to command window
    fprintf("Error Bar Properties\n");
    fprintf("--------------------\n")
    format_str = repmat('%.2f ', 1, length(P_mean));
    fprintf("    Average values: " + format_str + "\n", P_mean);
    fprintf("Standard deviation: " + format_str + "\n", P_std);

    % Mean +/- standard deviation
    P_mean = [P_mean; P_mean + error_positive; P_mean - error_negative];

    % Scale points to range from [0, 1] and apply offset
    P_mean = (P_mean - axes_range(1, :)) ./ axes_range(3, :);
    P_mean = P_mean * (1 - rho_offset) + rho_offset;

    % Convert from polar to cartesian
    A_theta = theta(1:end-1);
    A_scaled = P_mean;
    [x_points, y_points] = pol2cart(A_theta, A_scaled);

    % Scatter plot mean values
    scatter(ax, x_points(1, :), y_points(1, :),...
        'Marker', marker_type{1},...
        'SizeData', marker_size(1),...
        'MarkerFaceColor', colors(1, :),...
        'MarkerEdgeColor', colors(1, :),...
        'MarkerFaceAlpha', marker_transparency(1),...
        'MarkerEdgeAlpha', marker_transparency(1),...
        'Visible', plot_visible);

    % Iterate through each group
    for ii = 1:size(x_points, 2)
        % Mean +- standard deviation
        X = x_points(2:3, ii)';
        Y = y_points(2:3, ii)';

        % Plot error bar
        h = plot(ax, X, Y,...
            'LineStyle', line_style{1},...
            'Color', colors(1, :),...
            'LineWidth', line_width(1),...
            'Visible', plot_visible);

        % Turn off legend annotation
        h.Annotation.LegendInformation.IconDisplayStyle = 'off';

        % Perpendicular line
        v = [diff(X); diff(Y)];
        v = 0.05 * v / vecnorm(v);

        % Top and bottom
        for jj = 1:length(X)
            % Plot end tip
            x_endtip = [X(jj)+v(2), X(jj)-v(2)];
            y_endtip = [Y(jj)-v(1), Y(jj)+v(1)];
            h = plot(x_endtip, y_endtip,...
                'LineStyle', line_style{1},...
                'Color', colors(1, :),...
                'LineWidth', line_width(1),...
                'Visible', plot_visible);

            % Turn off legend annotation
            h.Annotation.LegendInformation.IconDisplayStyle = 'off';
        end
    end

    % Plot empty line with combined attributes for legend
    plot(ax, nan, nan,...
        'Marker', marker_type{1},...
        'MarkerSize', marker_size(1)/6,...
        'MarkerFaceColor', colors(1, :),...
        'MarkerEdgeColor', colors(1, :),...
        'LineStyle', line_style{1},...
        'Color', colors(1, :),...
        'LineWidth', line_width(1),...
        'Visible', plot_visible);
end

% Pre-allocation
S_info = struct(...
    'data_group_num', nan(num_data_groups, 1),...
    'perimeter', nan(num_data_groups, 1),...
    'area', nan(num_data_groups, 1));

% Iterate through number of data groups
for ii = 1:num_data_groups
    % Check if error bars are desired
    if strcmp(error_bars, 'off')
        % Initialize
        A_scaled = P_scaled(ii, :);
        A_theta = theta(1:end-1);

        % Find the index of Inf values
        inf_index = isinf(A_scaled);
        noninf_index = find(~inf_index);

        % Check if any Inf values detected
        if any(inf_index)
            % Do not plot Inf values
            A_scaled(inf_index) = nan;
            A_theta(inf_index) = nan;
        end

        % Convert polar to cartesian coordinates
        [x_points, y_points] = pol2cart(A_theta, A_scaled);

        % Calculate the perimeter and area
        pgon = polyshape(x_points, y_points);
        S_info(ii).data_group_num = "D" + ii;
        S_info(ii).perimeter = perimeter(pgon);
        S_info(ii).area = area(pgon);

        % Make points circular
        x_circular = [x_points, x_points(1)];
        y_circular = [y_points, y_points(1)];

        % Plot data points
        h = plot(ax, x_circular, y_circular,...
            'LineStyle', line_style{ii},...
            'Color', colors(ii, :),...
            'LineWidth', line_width(ii),...
            'Visible', plot_visible);
        h.Color(4) = line_transparency(ii);

        % Turn off legend annotation
        h.Annotation.LegendInformation.IconDisplayStyle = 'off';

        h = scatter(ax, x_points, y_points,...
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
        plot(ax, nan, nan,...
            'Marker', marker_type{ii},...
            'MarkerSize', marker_size(ii)/6,...
            'MarkerFaceColor', colors(ii, :),...
            'MarkerEdgeColor', colors(ii, :),...
            'LineStyle', line_style{ii},...
            'Color', colors(ii, :),...
            'LineWidth', line_width(ii),...
            'Visible', plot_visible);
    end

    % Iterate through number of data points
    if ismember(axes_display, {'data', 'data-percent'})
        for jj = noninf_index
            % Convert polar to cartesian coordinates
            [current_theta, current_rho] = cart2pol(x_points(jj), y_points(jj));
            [x_pos, y_pos] = pol2cart(current_theta, current_rho+axes_data_offset);

            % Data value
            data_value = P(ii, jj);

            % Format data value
            if strcmp(axes_display, 'data-percent')
                text_str = sprintf(sprintf('%%.%if%%%%', axes_precision(jj)), data_value*100);
            else
                text_str = sprintf(sprintf('%%.%if', axes_precision(jj)), data_value);
            end

            % Display axes text
            text(ax, x_pos, y_pos, text_str,...
                'Units', 'Data',...
                'Color', axes_font_color(ii, :),...
                'FontName', axes_font,...
                'FontSize', axes_font_size,...
                'HorizontalAlignment', 'center',...
                'VerticalAlignment', 'middle');
        end
    end

    switch fill_option{ii}
        case 'on'
            % Fill area within polygon
            h = patch(ax, x_points, y_points, colors(ii, :),...
                'EdgeColor', 'none',...
                'FaceAlpha', fill_transparency(ii));

            % Turn off legend annotation
            h.Annotation.LegendInformation.IconDisplayStyle = 'off';

        case 'interp'
            % Fill area within polygon
            c_data = reshape(fill_cdata, [], 1);
            h = patch(ax, x_points, y_points, c_data,...
                'EdgeColor', 'none',...
                'FaceAlpha', fill_transparency(ii));

            % Turn off legend annotation
            h.Annotation.LegendInformation.IconDisplayStyle = 'off';
    end
end

% Save to figure handle
fig.UserData = S_info;

% Check if axes shaded is on
if strcmp(axes_shaded, 'on')
    % Iterate through number of shaded groups
    for ii = 1:num_shaded
        % Initialize
        P_shaded_lower = P_shaded(2*ii-1, :);
        P_shaded_upper = P_shaded(2*ii, :);
        P_temp = [P_shaded_lower; P_shaded_upper];

        % Polar verticies of patch
        P_temp = [P_temp, P_temp(:, 1)];
        P_temp = [P_temp(1, :), P_temp(2, :)];
        patch_rho = reshape(P_temp, 1, []);
        patch_theta = [theta, theta];

        % Convert polar to cartesian coordinates
        [x_points, y_points] = pol2cart(patch_theta, patch_rho);

        % Interweave lower and upper limits
        x_points = reshape(x_points, [], 2)';
        y_points = reshape(y_points, [], 2)';

        x_points = x_points(:);
        y_points = y_points(:);

        % Increment through groups of four vertices at a time
        for jj = 1:2:length(x_points)-2
            % Verticies and face points
            v = [x_points(jj:jj+3), y_points(jj:jj+3)];
            f = [1 2 4 3];

            % Patch polygon
            h = patch(ax, 'Faces', f, 'Vertices', v,...
                'FaceColor', axes_shaded_color{ii},...
                'EdgeColor', 'none',...
                'FaceAlpha', axes_shaded_transparency(ii));

            h.Annotation.LegendInformation.IconDisplayStyle = 'off';
        end
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
% Check if axes labels rotate is on
if strcmp(axes_labels_rotate, 'on')
    % Find number of degrees to rotate text by
    rotate_deg = rad2deg(text_rotation(theta));

    % Find the horizontal alignments to align closer to axes
    horz_aligns = text_alignment(theta);
else
    % No rotation
    rotate_deg = zeros(1, length(theta));
end

% Check labels argument
if ~strcmp(axes_labels, 'none')
    % Iterate through number of data points
    for ii = 1:length(axes_labels)
        % Horizontal text alignment by quadrant
        [horz_align, ~] = quadrant_position(theta(ii));

        % Check if axes labels rotate is on
        if strcmp(axes_labels_rotate, 'on')
            % Adjust horizontal text alignment
            horz_align = horz_aligns{ii};
        end

        % Convert polar to cartesian coordinates
        [x_pos, y_pos] = pol2cart(theta(ii), rho(end)+axes_labels_offset);

        % Display text label
        text(ax, x_pos, y_pos, axes_labels{ii},...
            'Units', 'Data',...
            'HorizontalAlignment', horz_align,...
            'VerticalAlignment', 'middle',...
            'EdgeColor', axes_labels_edge,...
            'BackgroundColor', background_color,...
            'FontName', label_font,...
            'FontSize', label_font_size,...
            'Interpreter', axes_interpreter{ii},...
            'Rotation', rotate_deg(ii));
    end
end

    function horz_aligns = text_alignment(theta)
        % Pre-allocate cell
        horz_aligns = cell(length(theta), 1);
        horz_aligns(:) = {'center'};

        % Iterate through each theta
        for kk = 1:length(theta)
            % Adjust horizontal alignment accordingly
            if theta(kk) <= pi/2
                horz_aligns{kk} = 'left';
            elseif theta(kk) < 3*pi/2
                horz_aligns{kk} = 'right';
            elseif theta(kk) <= 2*pi
                horz_aligns{kk} = 'left';
            end
        end
    end

    function rotate_deg = text_rotation(theta)
        % Find how much to rotate text
        rotate_deg = theta;

        % Iterate through each theta
        for kk = 1:length(theta)
            % Adjust sign and rotation accordingly
            if theta(kk) == 0
                rotate_deg(kk) = 0;
            elseif theta(kk) > 0 && theta(kk) <= pi/2
                rotate_deg(kk) = theta(kk);
            elseif theta(kk) > pi/2 && theta(kk) < pi
                rotate_deg(kk) = -(pi - theta(kk));
            elseif theta(kk) == pi
                rotate_deg(kk) = 0;
            elseif theta(kk) > pi && theta(kk) < 3*pi/2
                rotate_deg(kk) = -(pi - theta(kk));
            elseif theta(kk) >= 3*pi/2
                rotate_deg(kk) = -(2*pi - theta(kk));
            end
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