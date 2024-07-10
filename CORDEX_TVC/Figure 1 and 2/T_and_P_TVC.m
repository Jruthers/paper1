%% Load in data for RCP 4.5
close all
clearvars
load("T_P_45.mat"); 
%% Create temp subsets for 2016-2046 and 2066-2096
% Loop through each month from January (1) to December (12)
for m = 1:12
    % Find rows where the year is between 2016 and 2046 and the month matches the current loop month
    indicestoget = find(HPCMonthlyT2090(:,1) >= 2016 & HPCMonthlyT2090(:,1) <= 2046 & HPCMonthlyT2090(:,2) == m);
    
    % Extract the rows that match the criteria
    presentday = HPCMonthlyT2090(indicestoget, :);
    
    % Get the dimensions of the temperature data (excluding the first two columns for year and month)
    dimens = size(presentday(:, 3:end));
    
    % Reshape the temperature data into a single column
    dataout = reshape(presentday(:, 3:end), dimens(1) * dimens(2), 1);
    
    % Store the reshaped temperature data in the output variable for the current month
    Temps20162046(:, m) = dataout;
end

% Loop through each month again for the years 2066 to 2096
for m = 1:12
    % Find rows where the year is between 2066 and 2096 and the month matches the current loop month
    indicestoget = find(HPCMonthlyT2090(:,1) >= 2066 & HPCMonthlyT2090(:,1) <= 2096 & HPCMonthlyT2090(:,2) == m);
    
    % Extract the rows that match the criteria
    presentday = HPCMonthlyT2090(indicestoget, :);
    
    % Get the dimensions of the temperature data (excluding the first two columns for year and month)
    dimens = size(presentday(:, 3:end));
    
    % Reshape the temperature data into a single column
    dataout = reshape(presentday(:, 3:end), dimens(1) * dimens(2), 1);
    
    % Store the reshaped temperature data in the output variable for the current month
    Temps20662096(:, m) = dataout;
end

%% Create precip subsets for 2016-2046 and 2066-2096
% The above section is then repeated for the precipitation data.
clear Precip20162046
clearvars indicestoget presentday dimens dataout
for m=1:12 
indicestoget=find(HPCMonthlyPtot2090(:,1) >= 2016 &  HPCMonthlyPtot2090(:,1) <= 2046 &  HPCMonthlyPtot2090(:,2)==m);
presentday= HPCMonthlyPtot2090(indicestoget,:);
dimens=size(presentday(:,3:end));
dataout=reshape(presentday(:,3:end),dimens(1,1)*dimens(1,2),1);
Precip20162046(:,m)=dataout; 
end

% for 2070-2100
clear Precip20662096
for m=1:12
indicestoget=find(HPCMonthlyPtot2090(:,1) >= 2066 &  HPCMonthlyPtot2090(:,1) <= 2096 &  HPCMonthlyPtot2090(:,2)==m);
presentday= HPCMonthlyPtot2090(indicestoget,:);
dimens=size(presentday(:,3:end));
dataout=reshape(presentday(:,3:end),dimens(1,1)*dimens(1,2),1);
Precip20662096(:,m)=dataout;
end

%% RCP 4.5 precip plot
% Calculate median precipitation for 2016-2046 and 2066-2096
medians1990 = median(Precip20162046(:,1:12));
medians2060 = median(Precip20662096(:,1:12));

% Calculate 25th and 75th percentiles for 2016-2046 and 2066-2096
perc751990 = prctile(Precip20162046(:,1:12),75);
perc251990 = prctile(Precip20162046(:,1:12),25);
perc752060 = prctile(Precip20662096(:,1:12),75);
perc252060 = prctile(Precip20662096(:,1:12),25);

% Create a tiled layout for plotting
tiledlayout(2,2, "TileSpacing","compact")
nexttile(3)

% Interpolate data to create finer resolution for plotting
m12=[1:0.2:12];
p12_1990=interp1([1:12],medians1990,m12,'cubic');
p12_2060=interp1([1:12],medians2060,m12,'cubic');
int_P_75_1990 = interp1([1:12], perc751990,m12,'cubic');
int_P_25_1990 = interp1([1:12], perc251990,m12,'cubic');
int_P_75_2060  = interp1([1:12], perc752060,m12,'cubic');
int_P_25_2060 = interp1([1:12], perc252060,m12,'cubic');

% Plot interpolated median precipitation
int1990 = plot(m12, p12_1990, 'black');
hold on
int2060 = plot(m12, p12_2060, 'r');

% Create x and y data for filling between percentiles
int_meanX1990 = [1:length(int_P_25_1990), length(int_P_75_1990):-1:1];
int_meanY1990 = [int_P_25_1990, fliplr(int_P_75_1990)];
int_meanX1990 = [m12, fliplr(m12(1:end))];
int_meanY2060 = [int_P_25_2060, fliplr(int_P_75_2060)];
int_meanX2060 = [m12, fliplr(m12(1:end))];

% Fill between percentiles
f = fill(int_meanX1990, int_meanY1990, 'black', "FaceAlpha", 0.2, "LineStyle", "none");
hold on
f = fill(int_meanX2060, int_meanY2060, 'red', "FaceAlpha", 0.2, "LineStyle", "none");

% Customize plot axes and labels
xlim([1 12])
ylim([0 80])
xtickangle(0)
set(gca, 'XTickLabel', []);
set(gca, 'xtick',1:1:24, 'XTickLabels',{'Jan', 'Feb', 'Mar', 'Apr ', 'May ', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'})
ylabel("Precipitation (mm w.e.)")
set(gca, "FontSize",10);

% Save the figure handle for reference
rcp45precip = gcf;
%% RCP 4.5 temp plot
% The above section is then repeated using the temperature data
Tmedian1990 = median(Temps20162046(:,1:12));
Tmedian2060 = median(Temps20662096(:,1:12));
Tperc751990 = prctile(Temps20162046(:,1:12),75);
Tperc251990 = prctile(Temps20162046(:,1:12),25);
Tperc752060 = prctile(Temps20662096(:,1:12),75);
Tperc252060 = prctile(Temps20662096(:,1:12),25);

nexttile(1)
% create more increments between 1-12
m12=[1:.2:12];
% m121=[1:0.4:12]
y12_1990=interp1([1:12],Tmedian1990,m12,'cubic');
y12_2060=interp1([1:12],Tmedian2060,m12,'cubic');
int_T_75_1990 = interp1([1:12], Tperc751990,m12,'cubic');
int_T_25_1990 = interp1([1:12], Tperc251990,m12,'cubic');
int_T_75_2060  = interp1([1:12], Tperc752060,m12,'cubic');
int_T_25_2060 = interp1([1:12], Tperc252060,m12,'cubic');
int1990 = plot(m12, y12_1990, 'black');
hold on
int2060 = plot(m12, y12_2060, 'r');

% int_meanX1990 = [1:length(int_T_25_1990), length(int_T_75_1990):-1:1];
int_meanY1990 = [int_T_25_1990, fliplr(int_T_75_1990)];
int_meanX1990 = [m12, fliplr(m12(1:end))];
f = fill(int_meanX1990, int_meanY1990, 'black', "FaceAlpha", 0.2, "LineStyle", "none");

hold on

int_meanY2060 = [int_T_25_2060, fliplr(int_T_75_2060)];
int_meanX2060 = [m12, fliplr(m12(1:end))];
f = fill(int_meanX2060, int_meanY2060, 'red', "FaceAlpha", 0.2, "LineStyle", "none");
xlim([1 12])
ylim([-30 30])
yline(0, '--')
leg = legend([int1990 int2060], {'2016-2046', '2066-2096'}, Location="northwest");
% set(leg, "box", "off")
set(gca, "FontSize",10);
set(gca, 'xtick',1:1:24, 'XTickLabels',[])
ylabel("Air Temperature (^{o}C)")
xtickangle(0)
title("RCP 4.5")
% set(leg, "box", "off")
rcp45temp=gcf;
%% RCP 4.5 Statistics
%Precipitation
years1990 = Precip20162046;
years2060 = Precip20662096;

precipresults45 = table('Size', [12, 4], 'VariableTypes', {'string', 'logical', 'double', 'double'}, ...
    'VariableNames', {'Month', 'h', 'p', 'D'});

for month = 1:12
    data1990 = years1990(:, month);
    data2060 = years2060(:, month);
    
    [h, p, ksstat] = kstest2(data1990, data2060);
    
    precipresults45(month, :) = {num2str(month), h, p, ksstat};
end

disp(precipresults45);

%Temperature
years1990 = Temps20162046;
years2060 = Temps20662096;

tempresults45 = table('Size', [12, 4], 'VariableTypes', {'string', 'logical', 'double', 'double'}, ...
    'VariableNames', {'Month', 'h', 'p', 'D'});

for month = 1:12
    data1990 = years1990(:, month);
    data2060 = years2060(:, month);
    
    [h, p, ksstat] = kstest2(data1990, data2060);
    
    tempresults45(month, :) = {month, h, p, ksstat};
end

disp(tempresults45);

clearvars -except rcp45temp rcp45precip tempresults45 precipresults45 Tmedian1990
%% Load in data for RCP 8.5
load("T_P_85.mat");
%% Create temp subsets for 2016-2046 and 2066-2096
for m=1:12
indicestoget=find(HPCMonthlyT2090(:,1) >= 2016 & HPCMonthlyT2090(:,1) <= 2046 & HPCMonthlyT2090(:,2)==m);
presentday=HPCMonthlyT2090(indicestoget,:); 
dimens=size(presentday(:,3:end));
dataout=reshape(presentday(:,3:end),dimens(1,1)*dimens(1,2),1);
Temps20162046(:,m)=dataout;
end

% for 2060-2100
clear Temps20662096
for m=1:12
indicestoget=find(HPCMonthlyT2090(:,1) >= 2066 & HPCMonthlyT2090(:,1) <= 2096 & HPCMonthlyT2090(:,2)==m);
presentday=HPCMonthlyT2090(indicestoget,:);
dimens=size(presentday(:,3:end));
dataout=reshape(presentday(:,3:end),dimens(1,1)*dimens(1,2),1);
Temps20662096(:,m)=dataout;
end

%% Create precip subsets for 2016-2046 and 2066-2096
for m=1:12
indicestoget=find(HPCMonthlyPtot2090(:,1) >= 2016 &  HPCMonthlyPtot2090(:,1) <= 2046 &  HPCMonthlyPtot2090(:,2)==m); 
presentday= HPCMonthlyPtot2090(indicestoget,:);
dimens=size(presentday(:,3:end)); 
dataout=reshape(presentday(:,3:end),dimens(1,1)*dimens(1,2),1);
Precip20162046(:,m)=dataout; % store in new variable
end

% for 2070-2100
clear Precip20662096
for m=1:12
indicestoget=find(HPCMonthlyPtot2090(:,1) >= 2066 &  HPCMonthlyPtot2090(:,1) <= 2096 &  HPCMonthlyPtot2090(:,2)==m);
presentday= HPCMonthlyPtot2090(indicestoget,:);
dimens=size(presentday(:,3:end));
dataout=reshape(presentday(:,3:end),dimens(1,1)*dimens(1,2),1);
Precip20662096(:,m)=dataout;
end


%% RCP 8.5 precip plot

medians1990 = median(Precip20162046(:,1:12));
medians2060 = median(Precip20662096(:,1:12));
perc751990 = prctile(Precip20162046(:,1:12),75);
perc251990 = prctile(Precip20162046(:,1:12),25);
perc752060 = prctile(Precip20662096(:,1:12),75);
perc252060 = prctile(Precip20662096(:,1:12),25);

nexttile(4)

m12=[1:0.2:12];
p12_1990=interp1([1:12],medians1990,m12,'cubic');
p12_2060=interp1([1:12],medians2060,m12,'cubic');
int_P_75_1990 = interp1([1:12], perc751990,m12,'cubic');
int_P_25_1990 = interp1([1:12], perc251990,m12,'cubic');
int_P_75_2060  = interp1([1:12], perc752060,m12,'cubic');
int_P_25_2060 = interp1([1:12], perc252060,m12,'cubic');
int1990 = plot(m12, p12_1990, 'black');
hold on
int2060 = plot(m12, p12_2060, 'r');

int_meanY1990 = [int_P_25_1990, fliplr(int_P_75_1990)];
int_meanX1990 = [m12, fliplr(m12(1:end))];
f = fill(int_meanX1990, int_meanY1990, 'black', "FaceAlpha", 0.2, "LineStyle", "none");
hold on
int_meanY2060 = [int_P_25_2060, fliplr(int_P_75_2060)];
int_meanX2060 = [m12, fliplr(m12(1:end))];
f = fill(int_meanX2060, int_meanY2060, 'red', "FaceAlpha", 0.2, "LineStyle", "none");
xlim([1 12])
xtickangle(0)
% leg = legend([int1990 int2060], {'median 2016-2046', 'median 2066-2096'}, Location="northwest")
set(gca, 'xtick',1:1:24, 'XTickLabels',{'Jan', 'Feb', 'Mar', 'Apr ', 'May ', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'})
% ylabel("Precipitation (mm w.e.)")
set(gca, "FontSize",10);
% set(leg, "box", "off")
rcp85precip = gcf;
%% RCP 8.5 temp plot
Tmedian1990 = median(Temps20162046(:,1:12));
Tmedian2060 = median(Temps20662096(:,1:12));
Tperc751990 = prctile(Temps20162046(:,1:12),75);
Tperc251990 = prctile(Temps20162046(:,1:12),25);
Tperc752060 = prctile(Temps20662096(:,1:12),75);
Tperc252060 = prctile(Temps20662096(:,1:12),25);
nexttile(2)
% create more increments between 1-12
m12=[1:.2:12];
% m121=[1:0.4:12]
y12_1990=interp1([1:12],Tmedian1990,m12,'cubic');
y12_2060=interp1([1:12],Tmedian2060,m12,'cubic');
int_T_75_1990 = interp1([1:12], Tperc751990,m12,'cubic');
int_T_25_1990 = interp1([1:12], Tperc251990,m12,'cubic');
int_T_75_2060  = interp1([1:12], Tperc752060,m12,'cubic');
int_T_25_2060 = interp1([1:12], Tperc252060,m12,'cubic');
int1990 = plot(m12, y12_1990, 'black');
hold on
int2060 = plot(m12, y12_2060, 'r');

% int_meanX1990 = [1:length(int_T_25_1990), length(int_T_75_1990):-1:1];
int_meanY1990 = [int_T_25_1990, fliplr(int_T_75_1990)];
int_meanX1990 = [m12, fliplr(m12(1:end))];
f = fill(int_meanX1990, int_meanY1990, 'black', "FaceAlpha", 0.2, "LineStyle", "none");

hold on

int_meanY2060 = [int_T_25_2060, fliplr(int_T_75_2060)];
int_meanX2060 = [m12, fliplr(m12(1:end))];
f = fill(int_meanX2060, int_meanY2060, 'red', "FaceAlpha", 0.2, "LineStyle", "none");
xlim([1 12])
ylim([-30 30])
% title("RCP8.5")
yline(0, '--')
% leg = legend([int1990 int2060], {'median 2016 - 2046', 'median 2066 - 2096'}, Location="northwest")
set(gca, "FontSize",10);
set(gca, 'xtick',1:1:24, 'XTickLabels',[])
% ylabel("Air Temperature (^{o}C)")
title("RCP 8.5")
xtickangle(0)
% set(leg, "box", "off")
rcp85temp=gcf;
%% RCP 8.5 statistics
% Precipitation
years1990 = Precip20162046;
years2060 = Precip20662096;

precipresults85 = table('Size', [12, 4], 'VariableTypes', {'string', 'logical', 'double', 'double'}, ...
    'VariableNames', {'Month', 'h', 'p', 'D'});

for month = 1:12
    data1990 = years1990(:, month);
    data2060 = years2060(:, month);
    
    [h, p, ksstat] = kstest2(data1990, data2060);
    
    precipresults85(month, :) = {month, h, p, ksstat};
end

disp(precipresults85);

 % Temperature
years1990 = Temps20162046;
years2060 = Temps20662096;

tempresults85 = table('Size', [12, 4], 'VariableTypes', {'string', 'logical', 'double', 'double'}, ...
    'VariableNames', {'Month', 'h', 'p', 'D'});

for month = 1:12
    data1990 = years1990(:, month);
    data2060 = years2060(:, month);
    
    [h, p, ksstat] = kstest2(data1990, data2060);
    
    tempresults85(month, :) = {month, h, p, ksstat};
end

disp(tempresults85);
%% Annotations
set(gcf, 'Position', [271 310 800 608]);
annotation('textbox', [0.44, 0.82, 0.1, 0.1], 'String', '(a)', 'EdgeColor', 'none', 'FontSize', 11, 'FontWeight', 'normal')
annotation('textbox', [0.86, 0.82, 0.1, 0.1], 'String', '(b)', 'EdgeColor', 'none', 'FontSize', 11, 'FontWeight', 'normal')
annotation('textbox', [0.44, 0.38, 0.1, 0.1], 'String', '(c)', 'EdgeColor', 'none', 'FontSize', 11, 'FontWeight', 'normal')
annotation('textbox', [0.86, 0.38, 0.1, 0.1], 'String', '(d)', 'EdgeColor', 'none', 'FontSize', 11, 'FontWeight', 'normal')
%% Optional figure export
exportgraphics(gcf, "T_and_P_TVC.pdf", "Resolution",300)
