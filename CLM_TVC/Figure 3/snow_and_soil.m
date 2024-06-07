%% Load SWE for RCP 4.5
% This section loads snow water equivalent (SWE) data for the RCP 4.5 scenario,
% processes the data to assign Julian days, calculates median SWE values for two periods
% (2016-2046 and 2066-2096), and plots these medians.

close all % Close all figures
clearvars % Clear all variables
load("SWE_45.mat") % Load SWE data

% Assign each month/day a Julian day
juliandays = [];
for i = 1:length(SWE2100)
    d = datetime(SWE2100(i,1), SWE2100(i,2), SWE2100(i,3)); % Create datetime object
    doy = day(d, 'dayofyear'); % Get day of the year
    juliandays = vertcat(juliandays, doy); % Append to list of Julian days
end
% Append the Julian days to the end of the SWE2100 variable
SWE2100 = [SWE2100, juliandays];

% 2. SWE 45 plot: Plot SWE data for two periods with a subplot layout
SWEplot = figure(); % Create a new figure
SWEplot.Position = [120 20 900 1500]; % Set figure position and size
T = tiledlayout(3,2, "TileSpacing", "compact"); % Create a tiled layout with 3x2 grid
nexttile
% Process SWE data for the period 2016-2046
SWE20162046_Daily = nan(30 * (width(SWE2100) - 4), 366); % Initialize matrix for daily SWE data
for d = 1:366 % Loop through each day of the year
    indicestoget = find(SWE2100(:,1) >= 2016 & SWE2100(:,1) <= 2046 - 1 & SWE2100(:,end) == d); % Find indices for the current day
    presentday = SWE2100(indicestoget, 4:end-1); % Extract relevant rows
    dimens = size(presentday(:,1:end)); % Get the dimensions of the extracted data
    dataout = reshape(presentday(:,1:end), dimens(1,1) * dimens(1,2), 1); % Reshape data into a single column
    SWE20162046_Daily(1:length(dataout), d) = dataout; % Store reshaped data
end

% Process SWE data for the period 2066-2096
SWE20662096_Daily = nan(30 * (width(SWE2100) - 4), 366); % Initialize matrix for daily SWE data
for d = 1:366 % Loop through each day of the year
    indicestoget = find(SWE2100(:,1) >= 2066 & SWE2100(:,1) <= 2096 - 1 & SWE2100(:,end) == d); % Find indices for the current day
    presentday = SWE2100(indicestoget, 4:end-1); % Extract relevant rows
    dimens = size(presentday(:,1:end)); % Get the dimensions of the extracted data
    dataout = reshape(presentday(:,1:end), dimens(1,1) * dimens(1,2), 1); % Reshape data into a single column
    SWE20662096_Daily(1:length(dataout), d) = dataout; % Store reshaped data
end

% Calculate medians for both periods
clear SWEmedian1 SWEmedian2
SWEmedian1 = median(SWE20162046_Daily); % Median SWE for 2016-2046
SWEmedian2 = median(SWE20662096_Daily); % Median SWE for 2066-2096

% Optional: Calculate percentiles (commented out)
% SWE1perc25 = prctile(SWE20162046_Daily(:,1:end),25);
% SWE1perc75 = prctile(SWE20162046_Daily(:,1:end),75);
% SWE2perc25 = prctile(SWE20662096_Daily(:,1:end),25);
% SWE2perc75 = prctile(SWE20662096_Daily(:,1:end),75);

% Define x-axis (Julian days)
m12 = 1:366;
SWEi_2046 = SWEmedian1;
SWEi_2096 = SWEmedian2;
% SWEi_2046_25 = SWE1perc25;
% SWEi_2046_75 = SWE1perc75;
% SWEi_2096_25  = SWE2perc25;
% SWEi_2096_75 = SWE2perc75;

% Plot median SWE values
SWE_plot_2046 = plot(m12, SWEi_2046, 'black', "LineWidth", 1.5);
hold on
SWE_plot_2096 = plot(m12, SWEi_2096, 'red', "LineWidth", 1.5);

% Optional: Fill area between percentiles (commented out)
% SWE_Y_fill_2046 = [SWEi_2046_25, fliplr(SWEi_2046_75)];
% SWE_X_fill_2046 = [m12, fliplr(m12(1:end))];
% f = fill(SWE_X_fill_2046, SWE_Y_fill_2046, 'black', "FaceAlpha", 0.2, "LineStyle", "none");
% hold on
% SWE_Y_fill_2096 = [SWEi_2096_25, fliplr(SWEi_2096_75)];
% SWE_X_fill_2096 = [m12, fliplr(m12(1:end))];
% f = fill(SWE_X_fill_2096, SWE_Y_fill_2096, 'red', "FaceAlpha", 0.2, "LineStyle", "none");

% Plot options and customization
legend([SWE_plot_2046 SWE_plot_2096], {'2016-2046', '2066-2096'}, Location = "southwest", FontSize = 7)
set(gca, 'XTickLabel', []); % Remove x-axis tick labels
set(gca, 'xtick', [1,32,60,91,121,152,182,213,244,274,305,335], 'xticklabel', {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
xtickangle(45); % Rotate x-axis labels
xlim([1 366]); % Set x-axis limits
ylim([1 250]); % Set y-axis limits
ylabel("mm w.e."); % Label y-axis
title('RCP 4.5', 'Snow Water Equivalent (SWE)'); % Set plot title

%% Load SWE for RCP 8.5
% The above section is repeated for RCP 8.5
clearvars
load("SWE_85.mat")

juliandays = [];
for i = 1:length(SWE2100)
    d = datetime(SWE2100(i, 1), SWE2100(i, 2), SWE2100(i, 3));
    doy = day(d, 'dayofyear');
    juliandays = vertcat(juliandays, doy);
end
SWE2100 = [SWE2100, juliandays];

nexttile
SWE20162046_Daily = nan(30 * (width(SWE2100) - 4), 366);
for d = 1:366
    indicestoget = find(SWE2100(:, 1) >= 2016 & SWE2100(:, 1) <= 2045 & SWE2100(:, end) == d);
    presentday = SWE2100(indicestoget, 4:end-1);
    dimens = size(presentday);
    dataout = reshape(presentday, dimens(1) * dimens(2), 1);
    SWE20162046_Daily(1:length(dataout), d) = dataout;
end

SWE20662096_Daily = nan(30 * (width(SWE2100) - 4), 366);
for d = 1:366
    indicestoget = find(SWE2100(:, 1) >= 2066 & SWE2100(:, 1) <= 2095 & SWE2100(:, end) == d);
    presentday = SWE2100(indicestoget, 4:end-1);
    dimens = size(presentday);
    dataout = reshape(presentday, dimens(1) * dimens(2), 1);
    SWE20662096_Daily(1:length(dataout), d) = dataout;
end

clear SWEmedian1 SWEmedian2
SWEmedian1 = median(SWE20162046_Daily);
SWEmedian2 = median(SWE20662096_Daily);
% SWE1perc25 = prctile(SWE20162046_Daily, 25);
% SWE1perc75 = prctile(SWE20162046_Daily, 75);
% SWE2perc25 = prctile(SWE20662096_Daily, 25);
% SWE2perc75 = prctile(SWE20662096_Daily, 75);

m12 = 1:366;
SWEi_2046 = SWEmedian1;
SWEi_2096 = SWEmedian2;
% SWEi_2046_25 = SWE1perc25;
% SWEi_2046_75 = SWE1perc75;
% SWEi_2096_25 = SWE2perc25;
% SWEi_2096_75 = SWE2perc75;

SWE_plot_2046 = plot(m12, SWEi_2046, 'black', "LineWidth", 1.5);
hold on
SWE_plot_2096 = plot(m12, SWEi_2096, 'red', "LineWidth", 1.5);

set(gca, 'XTickLabel', []);
set(gca, 'YTickLabel', []);
set(gca, 'xtick', [1, 32, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335], 'xticklabel', {'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'});
xtickangle(45);
title('RCP 8.5', 'Snow Water Equivalent (SWE)');
fontsize(13, "points")
xlim([1 366])
ylim([1 250])

%% Load 10cm soil temp for RCP 4.5
% The above sections are then repeated for 10cm soil temperature
load("GT_45.mat")

% Assign each month/day a julian day
juliandays = [];
for i = 1:length(GT102100)
    d = datetime(GT102100(i, 1), GT102100(i, 2), GT102100(i, 3));
    doy = day(d, 'dayofyear');
    juliandays = vertcat(juliandays, doy);
end
GT102100 = [GT102100, juliandays];

nexttile
GT20162046_Daily = nan(30 * (width(GT102100) - 4), 366);
for d = 1:366
    indicestoget = find(GT102100(:, 1) >= 2016 & GT102100(:, 1) <= 2045 & GT102100(:, end) == d);
    presentday = GT102100(indicestoget, 4:end-1);
    dimens = size(presentday);
    dataout = reshape(presentday, dimens(1) * dimens(2), 1);
    GT20162046_Daily(1:length(dataout), d) = dataout;
end

GT20662096_Daily = nan(30 * (width(GT102100) - 4), 366);
for d = 1:366
    indicestoget = find(GT102100(:, 1) >= 2066 & GT102100(:, 1) <= 2095 & GT102100(:, end) == d);
    presentday = GT102100(indicestoget, 4:end-1);
    dimens = size(presentday);
    dataout = reshape(presentday, dimens(1) * dimens(2), 1);
    GT20662096_Daily(1:length(dataout), d) = dataout;
end

GTmedian1 = median(GT20162046_Daily);
GTmedian2 = median(GT20662096_Daily);
GTi_2046 = GTmedian1;
GTi_2096 = GTmedian2;
m12 = 1:366;

GT_plot_2046 = plot(m12, GTi_2046, 'black', "LineWidth", 1.5);
hold on
GT_plot_2096 = plot(m12, GTi_2096, 'red', "LineWidth", 1.5);

yline(0, "--")
set(gca, 'xtick', [1, 32, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335], 'xticklabel', {'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'});
ylabel("^{o}C")
title('10cm Soil Temperature', "FontWeight", "normal")
xlim([1 366])
ylim([-20 15])

%% Load Sturm 10cm soil temp for RCP 4.5
clearvars -except GT10_plot_20461 GT10_plot_20961
load("GT_sturm_45.mat")

juliandays = [];
for i = 1:length(GT102100)
    d = datetime(GT102100(i, 1), GT102100(i, 2), GT102100(i, 3));
    doy = day(d, 'dayofyear');
    juliandays = vertcat(juliandays, doy);
end
GT102100 = [GT102100, juliandays];

hold on
GT20162046_Daily = nan(30 * (width(GT102100) - 4), 366);
for d = 1:366
    indicestoget = find(GT102100(:, 1) >= 2016 & GT102100(:, 1) <= 2045 & GT102100(:, end) == d);
    presentday = GT102100(indicestoget, 4:end-1);
    dimens = size(presentday);
    dataout = reshape(presentday, dimens(1) * dimens(2), 1);
    GT20162046_Daily(1:length(dataout), d) = dataout;
end

GT20662096_Daily = nan(30 * (width(GT102100) - 4), 366);
for d = 1:366
    indicestoget = find(GT102100(:, 1) >= 2066 & GT102100(:, 1) <= 2095 & GT102100(:, end) == d);
    presentday = GT102100(indicestoget, 4:end-1);
    dimens = size(presentday);
    dataout = reshape(presentday, dimens(1) * dimens(2), 1);
    GT20662096_Daily(1:length(dataout), d) = dataout;
end

GTmedian1 = median(GT20162046_Daily);
GTmedian2 = median(GT20662096_Daily);
GTi_2046 = GTmedian1;
GTi_2096 = GTmedian2;
m12 = 1:366;

GT_plot_2046 = plot(m12, GTi_2046, 'k--', "LineWidth", 1.5);
hold on
GT_plot_2096 = plot(m12, GTi_2096, 'r--', "LineWidth", 1.5);

% Plot options
yline(0, "--")
set(gca, 'xtick', [1, 32, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335], 'xticklabel', {'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'});
title('10cm Soil Temperature', "FontWeight", "normal")

%% Load 10cm Soil temp for rcp85
clearvars
load("GT_85.mat")
% Assign each month/day a julian day
juliandays = [];
for i = 1:length(GT102100)
    d = datetime(GT102100(i, 1), GT102100(i, 2), GT102100(i, 3));
    doy = day(d, 'dayofyear');
    juliandays = vertcat(juliandays, doy);
end
GT102100 = [GT102100, juliandays];

% Plot GT 85 with daily data
nexttile
GT20162046_Daily = nan(30 * (width(GT102100) - 4), 366);
for d = 1:366
    indicestoget = find(GT102100(:, 1) >= 2016 & GT102100(:, 1) <= 2045 & GT102100(:, end) == d);
    presentday = GT102100(indicestoget, 4:end-1);
    dimens = size(presentday);
    dataout = reshape(presentday, dimens(1) * dimens(2), 1);
    GT20162046_Daily(1:length(dataout), d) = dataout;
end

GT20662096_Daily = nan(30 * (width(GT102100) - 4), 366);
for d = 1:366
    indicestoget = find(GT102100(:, 1) >= 2066 & GT102100(:, 1) <= 2095 & GT102100(:, end) == d);
    presentday = GT102100(indicestoget, 4:end-1);
    dimens = size(presentday);
    dataout = reshape(presentday, dimens(1) * dimens(2), 1);
    GT20662096_Daily(1:length(dataout), d) = dataout;
end

GTmedian1 = median(GT20162046_Daily);
GTmedian2 = median(GT20662096_Daily);
GTi_2046 = GTmedian1;
GTi_2096 = GTmedian2;
m12 = 1:366;

GT_plot_2046 = plot(m12, GTi_2046, 'black', "LineWidth", 1.5);
hold on
GT_plot_2096 = plot(m12, GTi_2096, 'red', "LineWidth", 1.5);

% Plot options
yline(0, "--")
set(gca, 'xtick', [1, 32, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335], 'xticklabel', {'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'});
title('10cm Soil Temperature', "FontWeight", "normal")
xlim([1 366])

%% Load Sturm 10cm soil temp for RCP 8.5
clearvars -except GT10_plot_20461 GT10_plot_20961
load("GT_sturm_85.mat")

juliandays = [];
for i = 1:length(GT102100)
    d = datetime(GT102100(i, 1), GT102100(i, 2), GT102100(i, 3));
    doy = day(d, 'dayofyear');
    juliandays = vertcat(juliandays, doy);
end
GT102100 = [GT102100, juliandays];

hold on
GT20162046_Daily = nan(30 * (width(GT102100) - 4), 366);
for d = 1:366
    indicestoget = find(GT102100(:, 1) >= 2016 & GT102100(:, 1) <= 2045 & GT102100(:, end) == d);
    presentday = GT102100(indicestoget, 4:end-1);
    dimens = size(presentday);
    dataout = reshape(presentday, dimens(1) * dimens(2), 1);
    GT20162046_Daily(1:length(dataout), d) = dataout;
end

GT20662096_Daily = nan(30 * (width(GT102100) - 4), 366);
for d = 1:366
    indicestoget = find(GT102100(:, 1) >= 2066 & GT102100(:, 1) <= 2095 & GT102100(:, end) == d);
    presentday = GT102100(indicestoget, 4:end-1);
    dimens = size(presentday);
    dataout = reshape(presentday, dimens(1) * dimens(2), 1);
    GT20662096_Daily(1:length(dataout), d) = dataout;
end

GTmedian1 = median(GT20162046_Daily);
GTmedian2 = median(GT20662096_Daily);
GTi_2046 = GTmedian1;
GTi_2096 = GTmedian2;
m12 = 1:366;

GT_plot_2046 = plot(m12, GTi_2046, 'k--', "LineWidth", 1.5);
hold on
GT_plot_2096 = plot(m12, GTi_2096, 'r--', "LineWidth", 1.5);

% Plot options
yline(0, "--")
set(gca, 'xtick', [1, 32, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335], 'xticklabel', {'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'});
title('10cm Soil Temperature', "FontWeight", "normal")
ylim([-20 15])
yticklabels([])
%% Load SOIl moisture RCP 45
clearvars
load("SM_45.mat")

juliandays = [];
for i = 1:length(SL2100)
    d = datetime(SL2100(i, 1), SL2100(i, 2), SL2100(i, 3));
    doy = day(d, 'dayofyear');
    juliandays = vertcat(juliandays, doy);
end
SL2100 = [SL2100, juliandays];

SL20162046_Daily = nan(30 * (width(SL2100) - 4), 366);
for d = 1:366
    indicestoget = find(SL2100(:, 1) >= 2016 & SL2100(:, 1) <= 2045 & SL2100(:, end) == d);
    presentday = SL2100(indicestoget, 4:end-1);
    dimens = size(presentday(:, 1:end));
    dataout = reshape(presentday(:, 1:end), dimens(1) * dimens(2), 1);
    SL20162046_Daily(1:length(dataout), d) = dataout;
end

SL20662096_Daily = nan(30 * (width(SL2100) - 4), 366);
for d = 1:366
    indicestoget = find(SL2100(:, 1) >= 2066 & SL2100(:, 1) <= 2095 & SL2100(:, end) == d);
    presentday = SL2100(indicestoget, 4:end-1);
    dimens = size(presentday(:, 1:end));
    dataout = reshape(presentday(:, 1:end), dimens(1) * dimens(2), 1);
    SL20662096_Daily(1:length(dataout), d) = dataout;
end

nexttile
SLmedian1 = median(SL20162046_Daily);
SLmedian2 = median(SL20662096_Daily);
SLi_2046 = SLmedian1;
SLi_2096 = SLmedian2;
m12 = 1:366;

SL_plot_2046 = plot(m12, SLi_2046, 'k', "LineWidth", 1.5);
hold on
SL_plot_2096 = plot(m12, SLi_2096, 'r', "LineWidth", 1.5);

set(gca, 'xtick', [1, 32, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335], 'xticklabel', {'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'});
ylabel("Kg/m^2")
title('Soil Moisture', "FontWeight", "normal")
xlim([1 366])
ylim([0 40])
hold off
%% Load SOIl moisture for RCP 85
clearvars
load("SM_85.mat")

juliandays = [];
for i = 1:length(SL2100)
    d = datetime(SL2100(i, 1), SL2100(i, 2), SL2100(i, 3));
    doy = day(d, 'dayofyear');
    juliandays = vertcat(juliandays, doy);
end
SL2100 = [SL2100, juliandays];

SL20162046_Daily = nan(30 * (width(SL2100) - 4), 366);
for d = 1:366
    indicestoget = find(SL2100(:, 1) >= 2016 & SL2100(:, 1) <= 2045 & SL2100(:, end) == d);
    presentday = SL2100(indicestoget, 4:end-1);
    dimens = size(presentday(:, 1:end));
    dataout = reshape(presentday(:, 1:end), dimens(1) * dimens(2), 1);
    SL20162046_Daily(1:length(dataout), d) = dataout;
end

SL20662096_Daily = nan(30 * (width(SL2100) - 4), 366);
for d = 1:366
    indicestoget = find(SL2100(:, 1) >= 2066 & SL2100(:, 1) <= 2095 & SL2100(:, end) == d);
    presentday = SL2100(indicestoget, 4:end-1);
    dimens = size(presentday(:, 1:end));
    dataout = reshape(presentday(:, 1:end), dimens(1) * dimens(2), 1);
    SL20662096_Daily(1:length(dataout), d) = dataout;
end

nexttile
SLmedian1 = median(SL20162046_Daily);
SLmedian2 = median(SL20662096_Daily);
SLi_2046 = SLmedian1;
SLi_2096 = SLmedian2;
m12 = 1:366;

SL_plot_2046 = plot(m12, SLi_2046, 'k', "LineWidth", 1.5);
hold on
SL_plot_2096 = plot(m12, SLi_2096, 'r', "LineWidth", 1.5);

set(gca, 'xtick', [1, 32, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335], 'xticklabel', {'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'});
title('Soil Moisture', "FontWeight", "normal")
xlim([1 366])
ylim([0 40])
yticklabels([])
hold off
%% Set fontsizes
fontsize(12, "points")
fig = gcf;
leg = findobj(fig,'Type', 'legend');
set(leg, "FontSize",8);
%% letters
annotation('textbox', [0.44 0.821244008502731 0.1 0.1], 'String', '(a)', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'normal')
annotation('textbox', [0.44 0.527681231451366, 0.1, 0.1], 'String', '(c)', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'normal')
annotation('textbox', [0.44, 0.235, 0.1, 0.1], 'String', '(e)', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'normal')

annotation('textbox',  [0.866979166666667 0.821244008502731 0.1 0.1], 'String', '(b)', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'normal')
annotation('textbox', [0.866979166666667 0.527681231451366, 0.1, 0.1], 'String', '(d)', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'normal')
annotation('textbox', [0.866979166666667, 0.235, 0.1, 0.1], 'String', '(f)', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'normal')
%% Optional figure export
% exportgraphics(gcf, "SWE_GT_SL.jpg", "Resolution",300)
