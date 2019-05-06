# spider_plot
spider_plot(P, P_labels, axes_interval, axes_precision, varargin)
creates a spider web or radar plot with an axes specified for each column

spider_plot(P, P_labels, axes_interval, axes_precision) creates a spider
web plot using the points specified in the array P. The column of P
contains the data points and the rows of P contain the multiple sets of
data points. Each point must be accompanied by a label specified in the
cell P_labels. The number of intervals that separate the axes is
specified by axes_interval. The number of decimal precision points is
specified by axes_precision.

P - [vector | matrix]
P_labels - [cell of string]
axes_interval - [integer]
axes_precision - [integer]

spider_plot(P, P_labels, axes_interval, axes_precision, line_spec) works
the same as the function above. Additional line properties can be added
in the same format as the default "plot" function in MATLAB.

line_spec - [character vector]
