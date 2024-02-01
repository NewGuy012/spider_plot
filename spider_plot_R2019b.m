function varargout = spider_plot_R2019b(P, options)
%spider_plot_R2019b Create a spider or radar plot with individual axes.
%
% Syntax:
%   spider_plot_R2019b(P)
%   spider_plot_R2019b(P, Name, Value, ...)
%   h = spider_plot_R2019b(_)
%
% Documentation:
%   Please refer to the MathWorks File Exchange or GitHub page for the
%   detailed documentation and examples.

%%% Argument Validation %%%
arguments
    P (:, :) double
    options.AxesLabels {validateAxesLabels(options.AxesLabels, P)} = cellstr("Label " + (1:size(P, 2)))
    options.AxesInterval (1, 1) double {mustBeInteger, mustBePositive} = 3
    options.AxesPrecision (:, :) double {mustBeInteger, mustBeNonnegative} = 1
    options.AxesDisplay char {mustBeMember(options.AxesDisplay, {'all', 'none', 'one', 'data', 'data-percent'})} = 'all'
    options.AxesLimits double {validateAxesLimits(options.AxesLimits, P)} = [];
    options.FillOption {mustBeMember(options.FillOption, {'off', 'on', 'interp'})} = 'off'
    options.FillTransparency double {mustBeGreaterThanOrEqual(options.FillTransparency, 0), mustBeLessThanOrEqual(options.FillTransparency, 1)} = 0.2
    options.Color = get(groot,'defaultAxesColorOrder')
    options.LineStyle = '-'
    options.LineWidth (:, :) double {mustBePositive} = 2
    options.LineTransparency double {mustBeGreaterThanOrEqual(options.LineTransparency, 0), mustBeLessThanOrEqual(options.LineTransparency, 1)} = 1
    options.Marker = 'o'
    options.MarkerSize (:, :) double {mustBePositive} = 36
    options.MarkerTransparency double {mustBeGreaterThanOrEqual(options.MarkerTransparency, 0), mustBeLessThanOrEqual(options.MarkerTransparency, 1)} = 1
    options.AxesFont char = 'Helvetica'
    options.LabelFont char = 'Helvetica'
    options.AxesFontSize (1, 1) double {mustBePositive} = 10
    options.AxesFontColor = [0, 0, 0]
    options.LabelFontSize (1, 1) double {mustBePositive} = 10
    options.Direction char {mustBeMember(options.Direction, {'counterclockwise', 'clockwise'})} = 'clockwise'
    options.AxesDirection = 'normal'
    options.AxesLabelsOffset (1, 1) double {mustBeNonnegative} = 0.2
    options.AxesDataOffset (1, 1) double {mustBeNonnegative} = 0.1
    options.AxesScaling = 'linear'
    options.AxesColor = [0.6, 0.6, 0.6]
    options.AxesLabelsEdge = 'k'
    options.AxesOffset (1, 1) double {mustBeNonnegative, mustBeInteger} = 1
    options.AxesZoom double {mustBeGreaterThanOrEqual(options.AxesZoom, 0), mustBeLessThanOrEqual(options.AxesZoom, 1)} = 0.7 % Axes scale
    options.AxesHorzAlign char {mustBeMember(options.AxesHorzAlign, {'center', 'left', 'right', 'quadrant'})} = 'center' % Horizontal alignment of axes labels
    options.AxesVertAlign char {mustBeMember(options.AxesVertAlign, {'middle', 'top', 'cap', 'bottom', 'baseline', 'quadrant'})} = 'middle' % Vertical alignment of axes labels
    options.PlotVisible {mustBeMember(options.PlotVisible, {'off', 'on'})} = 'on'
    options.AxesTickLabels {mustBeText} = 'data'
    options.AxesInterpreter {mustBeText} = 'tex'
    options.AxesTickInterpreter {mustBeText} = 'tex'
    options.BackgroundColor = [1, 1, 1];
    options.MinorGrid {mustBeMember(options.MinorGrid, {'off', 'on'})} = 'off'
    options.MinorGridInterval (1, 1) double {mustBePositive, mustBeInteger} = 2
    options.AxesZero {mustBeMember(options.AxesZero, {'off', 'on'})} = 'off'
    options.AxesZeroColor = [0, 0, 0];
    options.AxesZeroWidth (1, 1) double {mustBePositive} = 2
    options.AxesRadial {mustBeMember(options.AxesRadial, {'off', 'on'})} = 'on'
    options.AxesWeb {mustBeMember(options.AxesWeb, {'off', 'on'})} = 'on'
    options.AxesShaded {mustBeMember(options.AxesShaded, {'off', 'on'})} = 'off'
    options.AxesShadedLimits cell = {}
    options.AxesShadedColor = 'g'
    options.AxesShadedTransparency double {mustBeGreaterThanOrEqual(options.AxesShadedTransparency, 0), mustBeLessThanOrEqual(options.AxesShadedTransparency, 1)} = 0.2 % Shading alpha
    options.AxesLabelsRotate {mustBeMember(options.AxesLabelsRotate, {'off', 'on'})} = 'off'
    options.AxesHandle = gobjects
    options.ErrorBars {mustBeMember(options.ErrorBars, {'off', 'on'})} = 'off'
    options.AxesWebType {mustBeMember(options.AxesWebType, {'web', 'circular'})} = 'web'
    options.AxesTickFormat {mustBeText} = 'default'
    options.FillCData = []
    options.ErrorPositive = []
    options.ErrorNegative = []
    options.AxesStart = pi/2
    options.AxesRadialLineStyle = '-';
    options.AxesRadialLineWidth = 1.5;
    options.AxesWebLineStyle = '-';
    options.AxesWebLineWidth = 1;
end

%%% Data Properties %%%
% Point properties
[num_data_groups, num_data_points] = size(P);

%%% Validate Axes Limits
if isempty(options.AxesLimits)
    % Replace Inf with NaN
    P_limits = P;
    inf_index = isinf(P_limits);
    P_limits(inf_index) = nan;

    % Default arguments
    options.AxesLimits = [min(P_limits, [], 1); max(P_limits, [], 1)];
end

%%% Validate Colors
% Check if there is enough colors
if size(options.Color, 1) < num_data_groups
    warning('Warning: Default colors have been applied to match the number of data group. Please enter in "Color" option if specific colors are desired.');
    options.Color = lines(num_data_groups);
end

%%% Validate Properties
% Check if axes offset is valid
if options.AxesOffset > options.AxesInterval
    error('Error: Invalid axes offset entry. Please enter in an integer value that is between [0, axes_interval].');
end

% Check if axes start is valid
if ~(options.AxesStart >= 0 && options.AxesStart <= 2*pi)
    error('Error: Please select an axes start value between [0, 2pi].')
end

% Check if axes shaded limits is empty
if isempty(options.AxesShadedLimits)
    options.AxesShadedLimits = {options.AxesLimits};
end

%%% Validate Axes Precision
% Check if axes precision is numeric
if isnumeric(options.AxesPrecision)
    % Check is length is one
    if length(options.AxesPrecision) == 1
        % Repeat array to number of data points
        options.AxesPrecision = repmat(options.AxesPrecision, num_data_points, 1);
    elseif length(options.AxesPrecision) ~= num_data_points
        error('Error: Please specify the same number of axes precision as number of data points.');
    end
else
    error('Error: Please make sure the axes precision is a numeric value.');
end

%%% Validate Line Style
% Check if line style is a char
if ischar(options.LineStyle)
    % Convert to cell array of char
    options.LineStyle = cellstr(options.LineStyle);

    % Repeat cell to number of data groups
    options.LineStyle = repmat(options.LineStyle, num_data_groups, 1);
elseif iscellstr(options.LineStyle) %#ok<*ISCLSTR>
    % Check is length is one
    if length(options.LineStyle) == 1
        % Repeat cell to number of data groups
        options.LineStyle = repmat(options.LineStyle, num_data_groups, 1);
    elseif length(options.LineStyle) ~= num_data_groups
        error('Error: Please specify the same number of line styles as number of data groups.');
    end
else
    error('Error: Please make sure the line style is a char or a cell array of char.');
end

%%% Validate Line Width
% Check if line width is numeric
if isnumeric(options.LineWidth)
    % Check is length is one
    if length(options.LineWidth) == 1
        % Repeat array to number of data groups
        options.LineWidth = repmat(options.LineWidth, num_data_groups, 1);
    elseif length(options.LineWidth) ~= num_data_groups
        error('Error: Please specify the same number of line width as number of data groups.');
    end
else
    error('Error: Please make sure the line width is a numeric value.');
end

%%% Validate Marker
% Check if marker type is a char
if ischar(options.Marker)
    % Convert to cell array of char
    options.Marker = cellstr(options.Marker);

    % Repeat cell to number of data groups
    options.Marker = repmat(options.Marker, num_data_groups, 1);
elseif iscellstr(options.Marker)
    % Check is length is one
    if length(options.Marker) == 1
        % Repeat cell to number of data groups
        options.Marker = repmat(options.Marker, num_data_groups, 1);
    elseif length(options.Marker) ~= num_data_groups
        error('Error: Please specify the same number of line styles as number of data groups.');
    end
else
    error('Error: Please make sure the line style is a char or a cell array of char.');
end

%%% Validate Marker Size
% Check if line width is numeric
if isnumeric(options.MarkerSize)
    if length(options.MarkerSize) == 1
        % Repeat array to number of data groups
        options.MarkerSize = repmat(options.MarkerSize, num_data_groups, 1);
    elseif length(options.MarkerSize) ~= num_data_groups
        error('Error: Please specify the same number of line width as number of data groups.');
    end
else
    error('Error: Please make sure the line width is numeric.');
end

%%% Validate Axes Scaling
% Check if axes scaling is valid
if any(~ismember(options.AxesScaling, {'linear', 'log'}))
    error('Error: Invalid axes scaling entry. Please enter in "linear" or "log" to set axes scaling.');
end

% Check if axes scaling is a cell
if iscell(options.AxesScaling)
    % Check is length is one
    if length(options.AxesScaling) == 1
        % Repeat array to number of data points
        options.AxesScaling = repmat(options.AxesScaling, num_data_points, 1);
    elseif length(options.AxesScaling) ~= num_data_points
        error('Error: Please specify the same number of axes scaling as number of data points.');
    end
else
    % Repeat array to number of data points
    options.AxesScaling = repmat({options.AxesScaling}, num_data_points, 1);
end

%%% Validate Axes Direction
% Check if axes direction is a cell
if iscell(options.AxesDirection)
    % Check is length is one
    if length(options.AxesDirection) == 1
        % Repeat array to number of data points
        options.AxesDirection = repmat(options.AxesDirection, num_data_points, 1);
    elseif length(options.AxesDirection) ~= num_data_points
        error('Error: Please specify the same number of axes direction as number of data points.');
    end
else
    % Repeat array to number of data points
    options.AxesDirection = repmat({options.AxesDirection}, num_data_points, 1);
end

%%% Validate Fill Option
% Check if fill option is a cell
if iscell(options.FillOption)
    % Check is length is one
    if length(options.FillOption) == 1
        % Repeat array to number of data groups
        options.FillOption = repmat(options.FillOption, num_data_groups, 1);
    elseif length(options.FillOption) ~= num_data_groups
        error('Error: Please specify the same number of fill option as number of data groups.');
    end
else
    % Repeat array to number of data groups
    options.FillOption = repmat({options.FillOption}, num_data_groups, 1);
end

% Check fill data
if all(strcmp(options.FillOption, 'interp'))
    if isempty(options.FillCData)
        error('Error: Please enter in a valid fill cdata.');
    else
        if length(options.FillCData) ~= num_data_points
            error('Error: Please make sure that fill cdata matches the number of data points.');
        end
    end
end

%%% Validate Fill Transparency
% Check if fill transparency is numeric
if isnumeric(options.FillTransparency)
    % Check is length is one
    if length(options.FillTransparency) == 1
        % Repeat array to number of data groups
        options.FillTransparency = repmat(options.FillTransparency, num_data_groups, 1);
    elseif length(options.FillTransparency) ~= num_data_groups
        error('Error: Please specify the same number of fill transparency as number of data groups.');
    end
else
    error('Error: Please make sure the transparency is a numeric value.');
end

%%% Validate Line Transparency
% Check if line transparency is numeric
if isnumeric(options.LineTransparency)
    % Check is length is one
    if length(options.LineTransparency) == 1
        % Repeat array to number of data groups
        options.LineTransparency = repmat(options.LineTransparency, num_data_groups, 1);
    elseif length(options.LineTransparency) ~= num_data_groups
        error('Error: Please specify the same number of line transparency as number of data groups.');
    end
else
    error('Error: Please make sure the transparency is a numeric value.');
end

%%% Validate Marker Transparency
% Check if marker transparency is numeric
if isnumeric(options.MarkerTransparency)
    % Check is length is one
    if length(options.MarkerTransparency) == 1
        % Repeat array to number of data groups
        options.MarkerTransparency = repmat(options.MarkerTransparency, num_data_groups, 1);
    elseif length(options.MarkerTransparency) ~= num_data_groups
        error('Error: Please specify the same number of marker transparency as number of data groups.');
    end
else
    error('Error: Please make sure the transparency is a numeric value.');
end

%%% Validate Axes Font Color
% Check if axes display is data
if ismember(options.AxesDisplay, {'data', 'data-percent'})
    if size(options.AxesFontColor, 1) ~= num_data_groups
        % Check axes font color dimensions
        if size(options.AxesFontColor, 1) == 1 && size(options.AxesFontColor, 2) == 3
            options.AxesFontColor = repmat(options.AxesFontColor, num_data_groups, 1);
        else
            error('Error: Please specify axes font color as a RGB triplet normalized to 1.');
        end
    end
end

%%% Validate Axes Tick Labels
% Check if axes tick labels is valid
if iscell(options.AxesTickLabels)
    if length(options.AxesTickLabels) ~= options.AxesInterval+1
        error('Error: Invalid axes tick labels entry. Please enter in a cell array with the same length of axes interval + 1.');
    end
else
    if ~strcmp(options.AxesTickLabels, 'data')
        error('Error: Invalid axes tick labels entry. Please enter in "data" or a cell array of desired tick labels.');
    end
end

%%% Validate Axes Interpreter
% Check if axes interpreter is valid
if any(~ismember(options.AxesInterpreter, {'tex', 'latex', 'none'}))
    error('Error: Please enter either "tex", "latex", or "none" for axes interpreter option.');
end

% Check if axes tick interpreter is valid
if any(~ismember(options.AxesTickInterpreter, {'tex', 'latex', 'none'}))
    error('Error: Please enter either "tex", "latex", or "none" for axes tick interpreter option.');
end

% Check if axes interpreter is a char
if ischar(options.AxesInterpreter)
    % Convert to cell array of char
    options.AxesInterpreter = cellstr(options.AxesInterpreter);

    % Repeat cell to number of axes labels
    options.AxesInterpreter = repmat(options.AxesInterpreter, length(options.AxesLabels), 1);
elseif iscellstr(options.AxesInterpreter)
    % Check is length is one
    if length(options.AxesInterpreter) == 1
        % Repeat cell to number of axes labels
        options.AxesInterpreter = repmat(options.AxesInterpreter, length(options.AxesLabels), 1);
    elseif length(options.AxesInterpreter) ~= length(options.AxesLabels)
        error('Error: Please specify the same number of axes interpreters as axes labels.');
    end
else
    error('Error: Please make sure the axes interpreter is a char or a cell array of char.');
end

% Check if axes tick interpreter is a char
if ischar(options.AxesTickInterpreter)
    % Convert to cell array of char
    options.AxesTickInterpreter = cellstr(options.AxesTickInterpreter);

    % Repeat cell to number of axes labels
    options.AxesTickInterpreter = repmat(options.AxesTickInterpreter, length(options.AxesLabels), 1);
elseif iscellstr(options.AxesTickInterpreter)
    % Check is length is one
    if length(options.AxesTickInterpreter) == 1
        % Repeat cell to number of axes labels
        options.AxesTickInterpreter = repmat(options.AxesTickInterpreter, length(options.AxesLabels), 1);
    elseif length(options.AxesTickInterpreter) ~= length(options.AxesLabels)
        error('Error: Please specify the same number of axes tick interpreters as axes labels.');
    end
else
    error('Error: Please make sure the axes tick interpreter is a char or a cell array of char.');
end

%%% Validate Axes Shaded Limits
% Iterate through axes shaded limits
for ii = 1:length(options.AxesShadedLimits)
    % Initialize
    axes_shaded_limit = options.AxesShadedLimits{ii};

    % Check if the axes shaded limits same length as the number of points
    if size(axes_shaded_limit, 1) ~= 2 || size(axes_shaded_limit, 2) ~= num_data_points
        error('Error: Please make sure the min and max axes shaded limits match the number of data points.');
    end

    % Check if within min and max axes limits
    if any(axes_shaded_limit(1, :) < options.AxesLimits(1, :)) ||...
            any(axes_shaded_limit(2, :) > options.AxesLimits(2, :))
        error('Error: Please make sure the axes shaded limits are within the min and max axes limits.');
    end
end

% Check if axes shaded color is a char
if ischar(options.AxesShadedColor)
    % Convert to cell array of char
    options.AxesShadedColor = cellstr(options.AxesShadedColor);

    % Repeat cell to number of axes shaded limits groups
    options.AxesShadedColor = repmat(options.AxesShadedColor, length(options.AxesShadedLimits), 1);
elseif iscellstr(options.AxesShadedColor)
    % Check is length is one
    if length(options.AxesShadedColor) == 1
        % Repeat cell to number of axes shaded limits groups
        options.AxesShadedColor = repmat(options.AxesShadedColor, length(options.AxesShadedLimits), 1);
    end
end

% Check if axes shaded color is valid
if length(options.AxesShadedColor) ~= length(options.AxesShadedLimits)
    error('Error: Please specify the same number of axes shaded color as number of axes shaded limits groups.');
end

% Check is length is one
if length(options.AxesShadedTransparency) == 1
    % Repeat array to number of axes shaded limits groups
    options.AxesShadedTransparency = repmat(options.AxesShadedTransparency, length(options.AxesShadedLimits), 1);
elseif length(options.AxesShadedTransparency) ~= length(options.AxesShadedLimits)
    error('Error: Please specify the same number of axes shaded transparency as number axes shaded limits groups.');
end

%%% Validate Axes Tick Format
% Check if axes tick format is a char
if ischar(options.AxesTickFormat)
    % Convert to cell array of char
    options.AxesTickFormat = cellstr(options.AxesTickFormat);

    % Repeat cell to number of axes shaded limits groups
    options.AxesTickFormat = repmat(options.AxesTickFormat, num_data_points, 1);
elseif iscellstr(options.AxesTickFormat)
    % Check is length is one
    if length(options.AxesTickFormat) == 1
        % Repeat cell to number of axes shaded limits groups
        options.AxesTickFormat = repmat(options.AxesTickFormat, num_data_points, 1);
    end
else
    error('Error: Please a character array or cell of character array for axes tick format.');
end

% Check if error positive and error negative are valid
if strcmp(options.ErrorBars, 'on') &&...
        ~isempty(options.ErrorPositive) &&...
        ~isempty(options.ErrorNegative)
    % Check that the length match the data points
    if length(options.ErrorPositive) ~= num_data_points
        error('Error: Please make sure the number of error positive elements equal the data points');
    end

    % Check that the length match the data points
    if length(options.ErrorNegative) ~= num_data_points
        error('Error: Please make sure the number of error negative elements equal the data points');
    end
end

%%% Axes Scaling Properties %%%
% Selected data
P_selected = P;

% Check axes scaling option
log_index = strcmp(options.AxesScaling, 'log');

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
if isempty(properties(options.AxesHandle))
    % Grab current figure
    fig = gcf;

    % Reset axes
    cla reset;

    % Current axes handle
    ax = gca;
else
    % Use specified axes handle
    ax = options.AxesHandle;
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
    fig.Color = options.BackgroundColor;
end

ax.Color = options.BackgroundColor;

% Axis limits
scaling_factor = 1 + (1 - options.AxesZoom);
hold(ax, 'on');
axis(ax, 'square');
axis(ax, [-1, 1, -1, 1] * scaling_factor);

% Axis properties
ax.XTickLabel = [];
ax.YTickLabel = [];
ax.XColor = 'none';
ax.YColor = 'none';

% Polar increments
theta_increment = 2*pi/num_data_points;
full_interval = options.AxesInterval+1;
rho_offset = options.AxesOffset/full_interval;

%%% Scale Data %%%
% Number of shaded rows
num_shaded = length(options.AxesShadedLimits);
shaded_rows = num_shaded * 2;

% Check if axes shaded is on
if strcmp(options.AxesShaded, 'on')
    % Concatenate
    all_shaded_limits = vertcat(options.AxesShadedLimits{:});

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
axes_direction_index = strcmp(options.AxesDirection, 'reverse');

% Iterate through number of data points
for ii = 1:num_data_points
    % Check for one data group and no axes limits
    if num_data_groups == 1 && isempty(options.AxesLimits)
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

    % Check if options.AxesLimits is not empty
    if ~isempty(options.AxesLimits)
        % Check for log axes scaling option
        if log_index(ii)
            % Logarithm of base 10, account for numbers less than 1
            options.AxesLimits(:, ii) = sign(options.AxesLimits(:, ii)) .* log10(abs(options.AxesLimits(:, ii)));
        end

        % Manually set the range of each group
        min_value = options.AxesLimits(1, ii);
        max_value = options.AxesLimits(2, ii);
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
if strcmp(options.AxesShaded, 'on')
    P_shaded = P_scaled(end-shaded_rows+1:end, :);
    P_scaled = P_scaled(1:end-shaded_rows, :);
end

%%% Polar Axes %%%
% Polar coordinates
rho_increment = 1/full_interval;
rho = 0:rho_increment:1;

% Check specified direction of rotation
switch options.Direction
    case 'counterclockwise'
        % Shift the starting axis
        theta = (0:theta_increment:2*pi) + options.AxesStart;
    case 'clockwise'
        % Shift the starting axis
        theta = (0:-theta_increment:-2*pi) + options.AxesStart;
end

% Remainder after using a modulus of 2*pi
theta = mod(theta, 2*pi);

% Check if axes radial is toggled on
if strcmp(options.AxesRadial, 'on')
    % Iterate through each theta
    for ii = 1:length(theta)-1
        % Convert polar to cartesian coordinates
        [x_axes, y_axes] = pol2cart(theta(ii), rho);

        % Plot webs
        h = plot(ax, x_axes, y_axes,...
            'LineStyle', options.AxesRadialLineStyle,...
            'LineWidth', options.AxesRadialLineWidth,...
            'Color', options.AxesColor);

        % Turn off legend annotation
        h.Annotation.LegendInformation.IconDisplayStyle = 'off';
    end
end

% Check axes web type
if strcmp(options.AxesWebType, 'web')
    theta_web = theta;
elseif strcmp(options.AxesWebType, 'circular')
    theta_web = 0:((2*pi)/(2^7)):2*pi;
end

% Check if axes web is toggled on
if strcmp(options.AxesWeb, 'on')
    % Iterate through each rho
    for ii = 2:length(rho)
        % Convert polar to cartesian coordinates
        [x_axes, y_axes] = pol2cart(theta_web, rho(ii));

        % Plot axes
        h = plot(ax, x_axes, y_axes,...
            'LineStyle', options.AxesWebLineStyle,...
            'LineWidth', options.AxesWebLineWidth,...
            'Color', options.AxesColor);

        % Turn off legend annotation
        h.Annotation.LegendInformation.IconDisplayStyle = 'off';
    end
end

% Check if minor grid is toggled on
if strcmp(options.MinorGrid, 'on')
    % Polar coordinates
    rho_minor_increment = 1/(full_interval*options.MinorGridInterval);
    rho_minor = rho(2):rho_minor_increment:1;
    rho_minor = setdiff(rho_minor, rho(2:end));

    % Iterate through each rho minor
    for ii = 1:length(rho_minor)
        % Convert polar to cartesian coordinates
        [x_axes, y_axes] = pol2cart(theta, rho_minor(ii));

        % Plot axes
        h = plot(ax, x_axes, y_axes, '--',...
            'Color', options.AxesColor,...
            'LineWidth', 0.5);

        % Turn off legend annotation
        h.Annotation.LegendInformation.IconDisplayStyle = 'off';
    end
end

% Check if axes zero is toggled on
if strcmp(options.AxesZero, 'on') && strcmp(options.AxesDisplay, 'one')
    % Scale points to range from [0, 1]
    zero_scaled = (0 - min_value) / range;

    % If reverse axes direction is specified
    if strcmp(options.AxesDirection, 'reverse')
        zero_scaled = -zero_scaled - 1;
    end

    % Add offset of [rho_offset] and scaling factor of [1 - rho_offset]
    zero_scaled = zero_scaled * (1 - rho_offset) + rho_offset;

    % Convert polar to cartesian coordinates
    [x_axes, y_axes] = pol2cart(theta, zero_scaled);

    % Plot webs
    h = plot(ax, x_axes, y_axes,...
        'LineWidth', options.AxesZeroWidth,...
        'Color', options.AxesZeroColor);

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
    case 'data'
        theta_end_index = 0;
    case 'data-percent'
        theta_end_index = 0;
end

% Rho start index and offset interval
rho_start_index = options.AxesOffset+1;
offset_interval = full_interval - options.AxesOffset;

% Alignment for axes labels
horz_align = options.AxesHorzAlign;
vert_align = options.AxesVertAlign;

% Iterate through each theta
for ii = 1:theta_end_index
    % Convert polar to cartesian coordinates
    [x_axes, y_axes] = pol2cart(theta(ii), rho);

    % Check if horizontal alignment is quadrant based
    if strcmp(options.AxesHorzAlign, 'quadrant')
        % Alignment based on quadrant
        [horz_align, ~] = quadrant_position(theta(ii));
    end

    % Check if vertical alignment is quadrant based
    if strcmp(options.AxesVertAlign, 'quadrant')
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
        if strcmp(options.AxesTickLabels, 'data')
            % Check axes tick format option
            if strcmp(options.AxesTickFormat{ii}, 'default')
                text_format = sprintf('%%.%if', options.AxesPrecision(ii));
            else
                text_format = options.AxesTickFormat{ii};
            end

            % Formatted axes tick text
            text_str = sprintf(text_format, axes_value);
        else
            text_str = options.AxesTickLabels{jj-options.AxesOffset};
        end

        t = text(ax, x_axes(jj), y_axes(jj), text_str,...
            'Units', 'Data',...
            'Color', options.AxesFontColor,...
            'FontName', options.AxesFont,...
            'FontSize', options.AxesFontSize,...
            'HorizontalAlignment', horz_align,...
            'VerticalAlignment', vert_align,...
            'Interpreter', options.AxesTickInterpreter{ii});
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
if strcmp(options.ErrorBars, 'on')
    % Calculate mean and standard deviation
    P_mean = mean(P, 1);
    P_std = std(P, 0, 1);

    % Check if plus or minus error is specified
    if isempty(options.ErrorPositive) ||...
            isempty(options.ErrorNegative)
        % Default values
        options.ErrorPositive = P_std;
        options.ErrorNegative = P_std;
    end

    % Display to command window
    fprintf("Error Bar Properties\n");
    fprintf("--------------------\n")
    format_str = repmat('%.2f ', 1, length(P_mean));
    fprintf("    Average values: " + format_str + "\n", P_mean);
    fprintf("Standard deviation: " + format_str + "\n", P_std);

    % Mean +/- standard deviation
    P_mean = [P_mean; P_mean + options.ErrorPositive; P_mean - options.ErrorNegative];

    % Scale points to range from [0, 1] and apply offset
    P_mean = (P_mean - axes_range(1, :)) ./ axes_range(3, :);
    P_mean = P_mean * (1 - rho_offset) + rho_offset;

    % Convert from polar to cartesian
    A_theta = theta(1:end-1);
    A_scaled = P_mean;
    [x_points, y_points] = pol2cart(A_theta, A_scaled);

    % Scatter plot mean values
    scatter(ax, x_points(1, :), y_points(1, :),...
        'Marker', options.Marker{1},...
        'SizeData', options.MarkerSize(1),...
        'MarkerFaceColor', options.Color(1, :),...
        'MarkerEdgeColor', options.Color(1, :),...
        'MarkerFaceAlpha', options.MarkerTransparency(1),...
        'MarkerEdgeAlpha', options.MarkerTransparency(1),...
        'Visible', options.PlotVisible);

    % Iterate through each group
    for ii = 1:size(x_points, 2)
        % Mean +- standard deviation
        X = x_points(2:3, ii)';
        Y = y_points(2:3, ii)';

        % Plot error bar
        h = plot(ax, X, Y,...
            'LineStyle', options.LineStyle{1},...
            'Color', options.Color(1, :),...
            'LineWidth', options.LineWidth(1),...
            'Visible', options.PlotVisible);

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
                'LineStyle', options.LineStyle{1},...
                'Color', options.Color(1, :),...
                'LineWidth', options.LineWidth(1),...
                'Visible', options.PlotVisible);

            % Turn off legend annotation
            h.Annotation.LegendInformation.IconDisplayStyle = 'off';
        end
    end

    % Plot empty line with combined attributes for legend
    plot(ax, nan, nan,...
        'Marker', options.Marker{1},...
        'MarkerSize', options.MarkerSize(1)/6,...
        'MarkerFaceColor', options.Color(1, :),...
        'MarkerEdgeColor', options.Color(1, :),...
        'LineStyle', options.LineStyle{1},...
        'Color', options.Color(1, :),...
        'LineWidth', options.LineWidth(1),...
        'Visible', options.PlotVisible);
end

% Pre-allocation
S_info = struct(...
    'data_group_num', nan(num_data_groups, 1),...
    'perimeter', nan(num_data_groups, 1),...
    'area', nan(num_data_groups, 1));

% Iterate through number of data groups
for ii = 1:num_data_groups
    % Check if error bars are desired
    if strcmp(options.ErrorBars, 'off')
        % Initialize
        A_scaled = P_scaled(ii, :);
        A_theta = theta(1:end-1);

        % Find the index of Inf values
        inf_index = isinf(A_scaled);
        noninf_index = find(~inf_index);

        % Check if any Inf values detected
        if any(inf_index)
            % Remove Inf values
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
            'LineStyle', options.LineStyle{ii},...
            'Color', options.Color(ii, :),...
            'LineWidth', options.LineWidth(ii),...
            'Visible', options.PlotVisible);
        h.Color(4) = options.LineTransparency(ii);

        % Turn off legend annotation
        h.Annotation.LegendInformation.IconDisplayStyle = 'off';

        h = scatter(ax, x_points, y_points,...
            'Marker', options.Marker{ii},...
            'SizeData', options.MarkerSize(ii),...
            'MarkerFaceColor', options.Color(ii, :),...
            'MarkerEdgeColor', options.Color(ii, :),...
            'MarkerFaceAlpha', options.MarkerTransparency(ii),...
            'MarkerEdgeAlpha', options.MarkerTransparency(ii),...
            'Visible', options.PlotVisible);

        % Turn off legend annotation
        h.Annotation.LegendInformation.IconDisplayStyle = 'off';

        % Plot empty line with combined attributes for legend
        plot(ax, nan, nan,...
            'Marker', options.Marker{ii},...
            'MarkerSize', options.MarkerSize(ii)/6,...
            'MarkerFaceColor', options.Color(ii, :),...
            'MarkerEdgeColor', options.Color(ii, :),...
            'LineStyle', options.LineStyle{ii},...
            'Color', options.Color(ii, :),...
            'LineWidth', options.LineWidth(ii),...
            'Visible', options.PlotVisible);
    end

    % Iterate through number of data points
    if ismember(options.AxesDisplay, {'data', 'data-percent'})
        for jj = noninf_index
            % Convert polar to cartesian coordinates
            [current_theta, current_rho] = cart2pol(x_points(jj), y_points(jj));
            [x_pos, y_pos] = pol2cart(current_theta, current_rho+options.AxesDataOffset);

            % Data value
            data_value = P(ii, jj);

            % Format data value
            if strcmp(options.AxesDisplay, 'data-percent')
                text_str = sprintf(sprintf('%%.%if%%%%', options.AxesPrecision(jj)), data_value*100);
            else
                text_str = sprintf(sprintf('%%.%if', options.AxesPrecision(jj)), data_value);
            end

            % Display axes text
            text(ax, x_pos, y_pos, text_str,...
                'Units', 'Data',...
                'Color', options.AxesFontColor(ii, :),...
                'FontName', options.AxesFont,...
                'FontSize', options.AxesFontSize,...
                'HorizontalAlignment', 'center',...
                'VerticalAlignment', 'middle');
        end
    end

    % Check if fill option is toggled on
    switch options.FillOption{ii}
        case 'on'
            % Fill area within polygon
            h = patch(ax, x_circular, y_circular, options.Color(ii, :),...
                'EdgeColor', 'none',...
                'FaceAlpha', options.FillTransparency(ii));

            % Turn off legend annotation
            h.Annotation.LegendInformation.IconDisplayStyle = 'off';

        case 'interp'
            % Fill area within polygon
            c_data = reshape(options.FillCData, [], 1);
            h = patch(ax, x_points, y_points, c_data,...
                'EdgeColor', 'none',...
                'FaceAlpha', options.FillTransparency(ii));

            % Turn off legend annotation
            h.Annotation.LegendInformation.IconDisplayStyle = 'off';
    end
end

% Save to figure handle
fig.UserData = S_info;

% Check if axes shaded is on
if strcmp(options.AxesShaded, 'on')
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
                'FaceColor', options.AxesShadedColor{ii},...
                'EdgeColor', 'none',...
                'FaceAlpha', options.AxesShadedTransparency(ii));
            h.Annotation.LegendInformation.IconDisplayStyle = 'off';
        end
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
    'Color', options.AxesColor,...
    '-and', 'Type', 'Line');
plot_handles = findobj(obj.Children, '-not',...
    'Color', options.AxesColor,...
    '-and', 'Type', 'Line');

% Manually set the stack order
uistack(plot_handles, 'bottom');
uistack(patch_handles, 'bottom');
uistack(isocurve_handles, 'bottom');
uistack(text_handles, 'top');

%%% Labels %%%
% Check if axes labels rotate is on
if strcmp(options.AxesLabelsRotate, 'on')
    % Find number of degrees to rotate text by
    rotate_deg = rad2deg(text_rotation(theta));

    % Find the horizontal alignments to align closer to axes
    horz_aligns = text_alignment(theta);
else
    % No rotation
    rotate_deg = zeros(1, length(theta));
end

% Check labels argument
if ~strcmp(options.AxesLabels, 'none')
    % Iterate through number of data points
    for ii = 1:length(options.AxesLabels)
        % Horizontal text alignment by quadrant
        [horz_align, ~] = quadrant_position(theta(ii));

        % Check if axes labels rotate is on
        if strcmp(options.AxesLabelsRotate, 'on')
            % Adjust horizontal text alignment
            horz_align = horz_aligns{ii};
        end

        % Convert polar to cartesian coordinates
        [x_pos, y_pos] = pol2cart(theta(ii), rho(end)+options.AxesLabelsOffset);

        % Display text label
        text(ax, x_pos, y_pos, options.AxesLabels{ii},...
            'Units', 'Data',...
            'HorizontalAlignment', horz_align,...
            'VerticalAlignment', 'middle',...
            'EdgeColor', options.AxesLabelsEdge,...
            'BackgroundColor', options.BackgroundColor,...
            'FontName', options.LabelFont,...
            'FontSize', options.LabelFontSize,...
            'Interpreter', options.AxesInterpreter{ii},...
            'Rotation', rotate_deg(ii));
    end
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

%%% Custom Validation Functions %%%
% Validate axes labels
function validateAxesLabels(axes_labels, P)
if ~strcmp(axes_labels, 'none')
    validateattributes(axes_labels, {'cell'}, {'size', [1, size(P, 2)]}, mfilename, 'axes_labels')
end
end

% Validate axes limits
function validateAxesLimits(axes_limits, P)
if ~isempty(axes_limits)
    validateattributes(axes_limits, {'double'}, {'size', [2, size(P, 2)]}, mfilename, 'axes_limits')

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
end