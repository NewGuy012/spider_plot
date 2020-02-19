classdef spider_plot_R2019b_class < matlab.graphics.chartcontainer.ChartContainer & ...
        matlab.graphics.chartcontainer.mixin.Legend
    %spider_plot_R2019b_class Create a spider or radar plot with individual axes.
    %
    % Syntax:
    %   spider_plot_R2019b_class(P)
    %   spider_plot_R2019b_class(P, Name, Value, ...)
    %   spider_plot_R2019b_class(parent, ___)
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
    %                      [MATLAB Color (default) | RGB triplet]
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
    %   if exist('s', 'var')
    %       delete(s);
    %   end
    %   s = spider_plot_R2019b_class(P);
    %
    %   % Example 2: Manually setting the axes limits. All non-specified,
    %                optional arguments are set to their default values.
    %
    %   D1 = [5 3 9 1 2];
    %   D2 = [5 8 7 2 9];
    %   D3 = [8 2 1 4 6];
    %   P = [D1; D2; D3];
    %   if exist('s', 'var')
    %       delete(s);
    %   end
    %   s = spider_plot_R2019b_class(P,...
    %       'AxesLimits', [1, 2, 1, 1, 1; 10, 8, 9, 5, 10]); % [min axes limits; max axes limits]
    %
    %   % Example 3: Set fill option on. The fill transparency can be adjusted.
    %
    %   D1 = [5 3 9 1 2];
    %   D2 = [5 8 7 2 9];
    %   D3 = [8 2 1 4 6];
    %   P = [D1; D2; D3];
    %   if exist('s', 'var')
    %       delete(s);
    %   end
    %   s = spider_plot_R2019b_class(P,...
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
    %   if exist('s', 'var')
    %       delete(s);
    %   end
    %   s = spider_plot_R2019b_class(P,...
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
    %   if exist('s', 'var')
    %       delete(s);
    %   end
    %   s = spider_plot_R2019b_class(P,...
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
    %   s.LegendLabels = ["D1", "D2"];
    %
    %   % Example 6: Logarithimic scale on all axes. Axes limits and axes
    %                intervals are automatically set to factors of 10.
    %
    %   D1 = [-1 10 1 500];
    %   D2 = [-10 20 1000 60];
    %   D3 = [-100 30 10 7];
    %   P = [D1; D2; D3];
    %   if exist('s', 'var')
    %       delete(s);
    %   end
    %   s = spider_plot_R2019b_class(P,...
    %       'AxesPrecision', 2,...
    %       'AxesDisplay', 'one',...
    %       'AxesScaling', 'log');
    %   s.LegendLabels = ["D1", "D2", "D3"];
    %
    % Author:
    %   Moses Yoo, (jyoo at hatci dot com)
    %   2020-02-17: Major revision in converting the function into a custom
    %               chart class. New feature introduced in R2019b.
    %	2020-02-12: Fixed condition and added error checking for when only one
    %			    data group is plotted.
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
    %   Special thanks to Gabriela Andrade, Andrés Garcia, Alex Grenyer,
    %   Omar Hadri, Zafar Ali & Christophe Hurlin for their feature
    %   recommendations and bug finds. A huge thanks to Jiro Doke and
    %   Sean de Wolski for demonstrating the implementation of argument
    %   validation and custom chart class introduced in R2019b.
    
    %%% Public, SetObservable Properties %%%
    properties(Access = public, SetObservable)
        % Property validation and defaults
        P (:, :) double
        AxesLabels string % Axes labels
        LegendLabels string % Data labels
        AxesInterval (1, 1) double {mustBeInteger, mustBePositive} = 3 % Number of axes grid lines
        AxesPrecision (1, 1) double {mustBeInteger, mustBeNonnegative} = 1 % Tick precision
        AxesDisplay char {mustBeMember(AxesDisplay, {'all', 'none', 'one'})} = 'all'  % Number of tick label groups shown on axes
        AxesLimits double = [] % Axes limits
        FillOption matlab.lang.OnOffSwitchState = 'off' % Whether to shade data
        FillTransparency (1, 1) double {mustBeGreaterThanOrEqual(FillTransparency, 0), mustBeLessThanOrEqual(FillTransparency, 1)} % Shading alpha
        Color (:, 3) double {mustBeGreaterThanOrEqual(Color, 0), mustBeLessThanOrEqual(Color, 1)} = get(groot,'defaultAxesColorOrder') % Color order
        LineStyle {mustBeMember(LineStyle, {'-', '--', ':', '-.', 'none'})} = '-' % Data line style
        LineWidth (1, 1) double {mustBePositive} = 2 % Data line width
        Marker {mustBeMember(Marker, {'+', 'o', '*', '.', 'x', 'square', 's', 'diamond', 'd', 'v', '^', '>', '<', 'pentagram', 'p', 'hexagram', 'h', 'none'})} = 'o' % Data marker
        MarkerSize (1, 1) double {mustBePositive} = 8 % Data marker size
        AxesFontSize (1, 1) double {mustBePositive} = 10 % Axes tick font size
        LabelFontSize (1, 1) double {mustBePositive} = 10 % Label font size
        Direction char {mustBeMember(Direction, {'counterclockwise', 'clockwise'})} = 'clockwise'
        AxesLabelsOffset (1, 1) double {mustBeNonnegative} = 0.1 % Offset position of axes labels
        AxesScaling char {mustBeMember(AxesScaling, {'linear', 'log'})} = 'linear' % Scaling of axes
    end
    
    %%% Protected, Dependent, Hidden Properties %%%
    properties(Access = private, NonCopyable, Transient)
        % Data line object
        DataLines = gobjects(0)
        
        % Background web object
        ThetaAxesLines = gobjects(0)
        RhoAxesLines = gobjects(0)
        
        % Fill shade object
        FillPatches = gobjects(0)
        
        % Web axes tick values
        AxesValues = [];
        
        % Axes label object
        AxesTextLabels = gobjects(0)
        AxesTickLabels = gobjects(0)
        
        % Initialize toggle state
        InitializeToggle = true;
    end
    
    %%% Private, Transient, NonCopyable Properties %%%
    properties(Access = protected, Dependent, Hidden)
        NumDataGroups
        NumDataPoints
    end
    
    methods
        %%% Constructor Methods %%%
        function obj = spider_plot_R2019b_class(parentOrP, varargin)            
            % Validate number of input arguments
            narginchk(1, inf);
            
            % Check if first argument is a graphic object or data
            if isa(parentOrP, 'matlab.graphics.Graphics')
                % spider_plot_R2019b_class(parent, P, Name, Value, ...)
                args = [{parentOrP, 'P'}, varargin];
            else
                % spider_plot_R2019b_class(P, Name, Value, ...)
                args = [{'P', parentOrP}, varargin];
            end
            
            % Call superclass constructor method
            obj@matlab.graphics.chartcontainer.ChartContainer(args{:});
        end
        
        %%% Set Methods %%%
        function set.P(obj, value)
            % Set property
            obj.P = value;
            
            % Toggle re-initialize to true if P was changed
            obj.InitializeToggle = true; %#ok<*MCSUP>
        end
        
        function set.AxesInterval(obj, value)
            % Set property
            obj.AxesInterval = value;
            
            % Toggle re-initialize to true if AxesInterval was changed
            obj.InitializeToggle = true;
        end
        
        function set.AxesDisplay(obj, value)
            % Set property
            obj.AxesDisplay = value;
            
            % Toggle re-initialize to true if AxesInterval was changed
            obj.InitializeToggle = true;
        end
        
        %%% Get Methods %%%
        function num_data_points = get.NumDataPoints(obj)
            % Get number of data points
            num_data_points = size(obj.P, 2);
        end
        
        function num_data_groups = get.NumDataGroups(obj)
            % Get number of data groups
            num_data_groups = size(obj.P, 1);
        end
        
        function axes_labels = get.AxesLabels(obj)
            % Check if value is empty
            if isempty(obj.AxesLabels)
                % Set axes labels
                axes_labels = "Label " + (1:obj.NumDataPoints);
            else
                % Keep axes labels
                axes_labels = obj.AxesLabels;
            end
        end
        
        function legend_labels = get.LegendLabels(obj)
            % Check if value is empty
            if isempty(obj.LegendLabels)
                % Set legend labels
                legend_labels = "Data " + (1:obj.NumDataGroups);
            else
                % Keep legend labels
                legend_labels = obj.LegendLabels;
            end
        end
        
        function color = get.Color(obj)
            % Check if value is empty
            if isempty(obj.Color)
                % Set color order
                color = lines(obj.NumDataGroups);
            else
                % Keep color order
                color = obj.Color;
            end
        end
        
        function axes_limits = get.AxesLimits(obj)
            % Validate axes limits
            validateAxesLimits(obj.AxesLimits, obj.P);
            
            % Keep axes limits
            axes_limits = obj.AxesLimits;
        end
    end
    
    methods (Access = public)
        function title(obj, title_text, varargin)
            % Get axes and title handles
            ax = getAxes(obj);
            tlt = ax.Title;
            
            % Set title string
            tlt.String = title_text;
            
            % Initialze name-value arguments
            name_arguments = varargin(1:2:end);
            value_arguments = varargin(2:2:end);
            
            % Iterate through name-value arguments
            for ii = 1:length(name_arguments)
                % Set name value pair
                name = name_arguments{ii};
                value = value_arguments{ii};
                tlt.(name) = value;
            end
        end
    end
    
    methods (Access = protected)
        %%% Setup Methods %%%
        function setup(obj)
            % Figure properties
            fig = gcf;
            fig.Color = 'w';
            
            % Axis properties
            ax = getAxes(obj);
            hold(ax, 'on');
            axis(ax, 'square');
            axis(ax, 'off');
            axis(ax, [-1, 1, -1, 1] * 1.3);
        end
        
        %%% Update Methods %%%
        function update(obj)
            % Check re-initialize toggle
            if obj.InitializeToggle
                % Reset graphic objects
                reset_objects(obj);
                initialize(obj);
                
                % Set initialize toggle to false
                obj.InitializeToggle = false;
            end
            
            % Update plot appearance
            update_plot(obj);
        end
        
        function reset_objects(obj)
            % Delete old objects
            delete(obj.DataLines)
            delete(obj.ThetaAxesLines)
            delete(obj.RhoAxesLines)
            delete(obj.FillPatches)
            delete(obj.AxesTextLabels)
            delete(obj.AxesTickLabels)
            
            % Reset object with empty objects
            obj.DataLines = gobjects(0);
            obj.ThetaAxesLines = gobjects(0);
            obj.RhoAxesLines = gobjects(0);
            obj.FillPatches = gobjects(0);
            obj.AxesValues = [];
            obj.AxesTextLabels = gobjects(0);
            obj.AxesTickLabels = gobjects(0);
        end
        
        function initialize(obj)
            % Axes handles
            ax = getAxes(obj);
            
            % Plot color
            grey = [0.5, 0.5, 0.5];
            
            % Polar increments
            theta_increment = 2*pi/obj.NumDataPoints;
            rho_increment = 1/(obj.AxesInterval+1);
            
            %%% Scale Data %%%
            % Pre-allocation
            P_scaled = zeros(size(obj.P));
            axes_range = zeros(3, obj.NumDataPoints);
            
            % Iterate through number of data points
            for ii = 1:obj.NumDataPoints
                % Group of points
                group_points = obj.P(:, ii);
                
                % Automatically the range of each group
                min_value = min(group_points);
                max_value = max(group_points);
                range = max_value - min_value;
                
                % Check if axes_limits is empty
                if isempty(obj.AxesLimits)
                    % Scale points to range from [rho_increment, 1]
                    P_scaled(:, ii) = ((group_points - min_value) / range) * (1 - rho_increment) + rho_increment;
                else
                    % Manually set the range of each group
                    min_value = obj.AxesLimits(1, ii);
                    max_value = obj.AxesLimits(2, ii);
                    range = max_value - min_value;
                    
                    % Check if the axes limits are within range of points
                    if min_value > min(group_points) || max_value < max(group_points)
                        error('Error: Please ensure the manually specified axes limits are within range of the data points.');
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
            switch obj.Direction
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
                
                % Plot
                obj.ThetaAxesLines(ii) = line(ax, x_axes, y_axes,...
                    'LineWidth', 1.5, ...
                    'Color', grey,...
                    'HandleVisibility', 'off');
            end
            
            % Iterate through each rho
            for ii = 2:length(rho)
                % Convert polar to cartesian coordinates
                [x_axes, y_axes] = pol2cart(theta, rho(ii));
                
                % Plot
                obj.RhoAxesLines(ii-1) = line(ax, x_axes, y_axes,...
                    'Color', grey,...
                    'HandleVisibility', 'off');
            end
            
            % Set end index depending on axes display argument
            switch obj.AxesDisplay
                case 'all'
                    theta_end_index = length(theta)-1;
                case 'one'
                    theta_end_index = 1;
                case 'none'
                    theta_end_index = 0;
            end
            
            %%% Plot %%%
            % Initialize data children
            for ii = 1:obj.NumDataGroups
                obj.FillPatches(ii) = patch(nan, nan, nan,...
                    'Parent', ax,...
                    'EdgeColor', 'none',...
                    'HandleVisibility', 'off');
                obj.DataLines(ii) = line(nan, nan,...
                    'Parent', ax);
            end
            
            % Iterate through number of data groups
            for ii = 1:obj.NumDataGroups
                % Convert polar to cartesian coordinates
                [x_points, y_points] = pol2cart(theta(1:end-1), P_scaled(ii, :));
                
                % Make points circular
                x_circular = [x_points, x_points(1)];
                y_circular = [y_points, y_points(1)];
                
                % Plot data points
                obj.DataLines(ii).XData = x_circular;
                obj.DataLines(ii).YData = y_circular;
                
                % Check if fill option is toggled on
                obj.FillPatches(ii).XData = x_circular;
                obj.FillPatches(ii).YData = y_circular;
            end
            
            %%% Labels %%%
            % Iterate through number of data points
            for ii = 1:obj.NumDataPoints
                % Convert polar to cartesian coordinates
                [x_axes, y_axes] = pol2cart(theta, rho(end));
                
                % Angle of point in radians
                [horz_align, vert_align, x_pos, y_pos] = obj.quadrant_position(theta(ii));
                
                % Display text label
                obj.AxesTextLabels(ii) = text(ax, x_axes(ii)+x_pos, y_axes(ii)+y_pos, '', ...
                    'Units', 'Data', ...
                    'HorizontalAlignment', horz_align, ...
                    'VerticalAlignment', vert_align, ...
                    'EdgeColor', 'k', ...
                    'BackgroundColor', 'w', ...
                    'Visible', 'off');
            end
            
            % Iterate through each theta
            for ii = 1:theta_end_index
                % Convert polar to cartesian coordinates
                [x_axes, y_axes] = pol2cart(theta(ii), rho);
                
                % Axes increment value
                min_value = axes_range(1, ii);
                range = axes_range(3, ii);
                
                % Iterate through points on isocurve
                for jj = length(rho):-1:2
                    % Axes increment value
                    axes_value = min_value + (range/obj.AxesInterval) * (jj-2);
                    
                    % Check axes scaling option
                    if strcmp(obj.AxesScaling, 'log')
                        % Exponent to the tenth power
                        axes_value = 10^axes_value;
                    end
                    
                    % Display axes text
                    obj.AxesValues(ii, jj-1) = axes_value;
                    obj.AxesTickLabels(ii, jj-1) = text(ax, x_axes(jj), y_axes(jj), '', ...
                        'Units', 'Data', ...
                        'Color', 'k', ...
                        'HorizontalAlignment', 'center', ...
                        'VerticalAlignment', 'middle', ...
                        'Visible', 'off');
                end
            end
        end
        
        function update_plot(obj)
            % Iterate through patch objects
            for ii = 1:numel(obj.FillPatches)
                % Check fill option argument
                if obj.FillOption
                    % Fill in patch with specified color and transparency
                    obj.FillPatches(ii).FaceColor = obj.Color(ii, :);
                    obj.FillPatches(ii).FaceAlpha = obj.FillTransparency;
                else
                    % Set no patch color
                    obj.FillPatches(ii).FaceColor = 'none';
                end
            end
            
            % Iterate through data line objects
            for ii = 1:numel(obj.DataLines)
                % Set line settings
                obj.DataLines(ii).LineStyle = obj.LineStyle;
                obj.DataLines(ii).Marker =  obj.Marker;
                obj.DataLines(ii).Color = obj.Color(ii, :);
                obj.DataLines(ii).LineWidth = obj.LineWidth;
                obj.DataLines(ii).MarkerSize = obj.MarkerSize;
                obj.DataLines(ii).MarkerFaceColor = obj.Color(ii, :);
                obj.DataLines(ii).DisplayName = obj.LegendLabels(ii);
            end
            
            % Check axes display argument
            if isequal(obj.AxesLabels, 'none')
                % Set axes text labels to invisible
                set(obj.AxesTextLabels, 'Visible', 'off')
            else
                % Set axes text labels to visible
                set(obj.AxesTextLabels, 'Visible', 'on')
                
                % Iterate through number of data points
                for ii = 1:obj.NumDataPoints
                    % Display text label
                    obj.AxesTextLabels(ii).String = obj.AxesLabels{ii};
                    obj.AxesTextLabels(ii).FontSize = obj.LabelFontSize;
                end                
            end
            
            % Check axes precision argument
            if isequal(obj.AxesPrecision, 'none')
                % Set axes tick label invisible
                set(obj.AxesTickLabels, 'Visible', 'off')
            else
                % Set axes tick label visible
                set(obj.AxesTickLabels, 'Visible', 'on')
                
                % Iterate through axes values
                for ii = 1:numel(obj.AxesValues)
                    % Display and set axes tick label settings
                    text_str = sprintf(sprintf('%%.%if', obj.AxesPrecision), obj.AxesValues(ii));
                    obj.AxesTickLabels(ii).String = text_str;
                    obj.AxesTickLabels(ii).FontSize = obj.AxesFontSize;
                end
            end
        end
        
        function [horz_align, vert_align, x_pos, y_pos] = quadrant_position(obj, theta_point)
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
                    x_pos = obj.AxesLabelsOffset;
                    y_pos = 0;
                case 1
                    horz_align = 'left';
                    vert_align = 'bottom';
                    x_pos = obj.AxesLabelsOffset;
                    y_pos = obj.AxesLabelsOffset;
                case 1.5
                    horz_align = 'center';
                    vert_align = 'bottom';
                    x_pos = 0;
                    y_pos = obj.AxesLabelsOffset;
                case 2
                    horz_align = 'right';
                    vert_align = 'bottom';
                    x_pos = -obj.AxesLabelsOffset;
                    y_pos = obj.AxesLabelsOffset;
                case 2.5
                    horz_align = 'right';
                    vert_align = 'middle';
                    x_pos = -obj.AxesLabelsOffset;
                    y_pos = 0;
                case 3
                    horz_align = 'right';
                    vert_align = 'top';
                    x_pos = -obj.AxesLabelsOffset;
                    y_pos = -obj.AxesLabelsOffset;
                case 3.5
                    horz_align = 'center';
                    vert_align = 'top';
                    x_pos = 0;
                    y_pos = -obj.AxesLabelsOffset;
                case 4
                    horz_align = 'left';
                    vert_align = 'top';
                    x_pos = obj.AxesLabelsOffset;
                    y_pos = -obj.AxesLabelsOffset;
            end
        end
        
    end
    
end

%%% Custom Validation Functions %%%
% Validate axes limits
function validateAxesLimits(axLim, P)
if ~isempty(axLim)
    validateattributes(axLim, {'double'}, {'size', [2, size(P, 2)]}, mfilename, 'AxesLimits')
    
    % Lower and upper limits
    lower_limits = axLim(1, :);
    upper_limits = axLim(2, :);
    
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