clear all
cd /Users/johnnyrutherford/Library/CloudStorage/OneDrive-NorthumbriaUniversity-ProductionAzureAD/Documents/MATLAB/'AlexBodata TVC'/Adjusted_daily/
% addpath('mbcn-na-cordex_daily-CA-HPC/'); % adds the directory with all the files in
FilesList=dir('mbcn.CA-TVC.NAM-*rcp45*.csv'); % makes a list of all ensemble member files

for j=1:6 %length(FilesList)  % cycles through each  file in the filelist
Output=readtable(FilesList(j).name); % read the csv file into MATLAB
datestamp=datenum(num2str(table2array([Output(:,1),Output(:,2),Output(:,3)])));   % Get the time for the x axis
[UniqueCombos UniqueRowStart RowsofEachUniqueCombo]=unique(Output(:,1:2),'rows');
for i=1:max(RowsofEachUniqueCombo)
rowsneeded=find(RowsofEachUniqueCombo==i);
HPCmonthlyprecip(i,j)=mean(Output.pr(rowsneeded));
HPCmonthlyTime(i,1)=mean(Output.year(rowsneeded));
HPCmonthlyTime(i,2)=mean(Output.month(rowsneeded));
HPCmonthlyTmin(i,j)=mean(Output.tn(rowsneeded));
HPCmonthlyTmax(i,j)=mean(Output.tx(rowsneeded));
HPCmonthlyTmean(i,j)=0.5*(HPCmonthlyTmin(i,j)+HPCmonthlyTmax(i,j));
HPCmonthlyPtot(i,j)=sum(Output.pr(rowsneeded));
end
end
HPCmonthlyprecip=HPCmonthlyprecip*60*60*24;
HPCmonthlyPtot=HPCmonthlyPtot*60*60*24;
HPCmonthlytotprecip=[HPCmonthlyTime HPCmonthlyPtot];
HPCMonthlyP2090=[HPCmonthlyTime HPCmonthlyprecip];
HPCMonthlyT2090=[HPCmonthlyTime HPCmonthlyTmean];
%% create temps subsets
for m=1:12 % cycle through each of the months 
indicestoget=find(HPCMonthlyT2090(:,1) >= 2016 & HPCMonthlyT2090(:,1) <= 2046 & HPCMonthlyT2090(:,2)==m); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=HPCMonthlyT2090(indicestoget,:); % extract specific rows
dimens=size(presentday(:,3:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,3:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
Temps20162046(:,m)=dataout; % store in new variable
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

%% create precip subsets
clear Precip20162046
clearvars indicestoget presentday dimens dataout
for m=1:12 
indicestoget=find(HPCmonthlytotprecip(:,1) >= 2016 & HPCmonthlytotprecip(:,1) <= 2046 & HPCmonthlytotprecip(:,2)==m); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=HPCmonthlytotprecip(indicestoget,:); % extract specific rows
dimens=size(presentday(:,3:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,3:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
Precip20162046(:,m)=dataout; % store in new variable
end

% for 2070-2100
clear Precip20662096
for m=1:12
indicestoget=find(HPCmonthlytotprecip(:,1) >= 2066 & HPCmonthlytotprecip(:,1) <= 2096 & HPCmonthlytotprecip(:,2)==m);
presentday=HPCmonthlytotprecip(indicestoget,:);
dimens=size(presentday(:,3:end));
dataout=reshape(presentday(:,3:end),dimens(1,1)*dimens(1,2),1);
Precip20662096(:,m)=dataout;
end

%% rcp45 precip plot
medians1990 = median(Precip20162046(:,1:12));
medians2060 = median(Precip20662096(:,1:12));
perc751990 = prctile(Precip20162046(:,1:12),75);
perc251990 = prctile(Precip20162046(:,1:12),25);
perc752060 = prctile(Precip20662096(:,1:12),75);
perc252060 = prctile(Precip20662096(:,1:12),25);
hold on
figure(Position=[500 500 750 600])
tiledlayout(2,2, "TileSpacing","compact")
nexttile(3)
% create more increments between 1-12
m12=[1:0.2:12];
% m121=[1:0.4:12]
p12_1990=interp1([1:12],medians1990,m12,'cubic');
p12_2060=interp1([1:12],medians2060,m12,'cubic');
int_P_75_1990 = interp1([1:12], perc751990,m12,'cubic');
int_P_25_1990 = interp1([1:12], perc251990,m12,'cubic');
int_P_75_2060  = interp1([1:12], perc752060,m12,'cubic');
int_P_25_2060 = interp1([1:12], perc252060,m12,'cubic');
int1990 = plot(m12, p12_1990, 'black');
hold on
int2060 = plot(m12, p12_2060, 'r');
% 
int_meanX1990 = [1:length(int_P_25_1990), length(int_P_75_1990):-1:1];
int_meanY1990 = [int_P_25_1990, fliplr(int_P_75_1990)];
int_meanX1990 = [m12, fliplr(m12(1:end))];
f = fill(int_meanX1990, int_meanY1990, 'black', "FaceAlpha", 0.2, "LineStyle", "none");
hold on
int_meanY2060 = [int_P_25_2060, fliplr(int_P_75_2060)];
int_meanX2060 = [m12, fliplr(m12(1:end))];
f = fill(int_meanX2060, int_meanY2060, 'red', "FaceAlpha", 0.2, "LineStyle", "none");
xlim([1 12])
ylim([0 80])
xtickangle(0)
set(gca, 'XTickLabel', []);
set(gca, 'xtick',1:1:24, 'XTickLabels',{'Jan', 'Feb', 'Mar', 'Apr ', 'May ', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'})
ylabel("Precipitation (mm w.e.)")
set(gca, "FontSize",10);
rcp45precip = gcf;
%% rcp45 temp plot
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
set(leg, "box", "off")
set(gca, "FontSize",10);
set(gca, 'xtick',1:1:24, 'XTickLabels',[])
ylabel("Air Temperature (^{o}C)")
xtickangle(0)
title("RCP 4.5")
% set(leg, "box", "off")
rcp45temp=gcf;
%% Precip Ks test
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

%% Temperature Ks test
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
%%
clearvars -except rcp45temp rcp45precip tempresults45 precipresults45 Tmedian1990
%% isolate 8.5
% addpath('mbcn-na-cordex_daily-CA-HPC/'); % adds the directory with all the files in
% Tmedian1990rcp45=Tmedian1990;
FilesList=dir('mbcn.CA-TVC.NAM-*rcp85*.csv'); % makes a list of all ensemble member files

for j=1:27 %length(FilesList)  % cycles through each  file in the filelist
Output=readtable(FilesList(j).name); % read the csv file into MATLAB
datestamp=datenum(num2str(table2array([Output(:,1),Output(:,2),Output(:,3)])));   % Get the time for the x axis
[UniqueCombos UniqueRowStart RowsofEachUniqueCombo]=unique(Output(:,1:2),'rows');
for i=1:max(RowsofEachUniqueCombo)
rowsneeded=find(RowsofEachUniqueCombo==i);
HPCmonthlyprecip(i,j)=mean(Output.pr(rowsneeded));
HPCmonthlyTime(i,1)=mean(Output.year(rowsneeded));
HPCmonthlyTime(i,2)=mean(Output.month(rowsneeded));
HPCmonthlyTmin(i,j)=mean(Output.tn(rowsneeded));
HPCmonthlyTmax(i,j)=mean(Output.tx(rowsneeded));
HPCmonthlyTmean(i,j)=0.5*(HPCmonthlyTmin(i,j)+HPCmonthlyTmax(i,j));
HPCmonthlyPtot(i,j)=sum(Output.pr(rowsneeded));
end
end
HPCmonthlyprecip=HPCmonthlyprecip*60*60*24;
HPCmonthlyPtot=HPCmonthlyPtot*60*60*24;
HPCmonthlytotprecip=[HPCmonthlyTime HPCmonthlyPtot];
HPCMonthlyP2090=[HPCmonthlyTime HPCmonthlyprecip];
HPCMonthlyT2090=[HPCmonthlyTime HPCmonthlyTmean];
%% create temps subsets
for m=1:12 % cycle through each of the months 
indicestoget=find(HPCMonthlyT2090(:,1) >= 2016 & HPCMonthlyT2090(:,1) <= 2046 & HPCMonthlyT2090(:,2)==m); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=HPCMonthlyT2090(indicestoget,:); % extract specific rows
dimens=size(presentday(:,3:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,3:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
Temps20162046(:,m)=dataout; % store in new variable
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

%% create precip subsets
for m=1:12 % cycle through each of the months 
indicestoget=find(HPCmonthlytotprecip(:,1) >= 2016 & HPCmonthlytotprecip(:,1) <= 2046 & HPCmonthlytotprecip(:,2)==m); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=HPCmonthlytotprecip(indicestoget,:); % extract specific rows
dimens=size(presentday(:,3:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,3:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
Precip20162046(:,m)=dataout; % store in new variable
end

% for 2070-2100
clear Precip20662096
for m=1:12
indicestoget=find(HPCmonthlytotprecip(:,1) >= 2066 & HPCmonthlytotprecip(:,1) <= 2096 & HPCmonthlytotprecip(:,2)==m);
presentday=HPCmonthlytotprecip(indicestoget,:);
dimens=size(presentday(:,3:end));
dataout=reshape(presentday(:,3:end),dimens(1,1)*dimens(1,2),1);
Precip20662096(:,m)=dataout;
end


%% rcp85 precip plot

medians1990 = median(Precip20162046(:,1:12));
medians2060 = median(Precip20662096(:,1:12));
perc751990 = prctile(Precip20162046(:,1:12),75);
perc251990 = prctile(Precip20162046(:,1:12),25);
perc752060 = prctile(Precip20662096(:,1:12),75);
perc252060 = prctile(Precip20662096(:,1:12),25);

nexttile(4)
% create more increments between 1-12
m12=[1:0.2:12];
% m121=[1:0.4:12]
p12_1990=interp1([1:12],medians1990,m12,'cubic');
p12_2060=interp1([1:12],medians2060,m12,'cubic');
int_P_75_1990 = interp1([1:12], perc751990,m12,'cubic');
int_P_25_1990 = interp1([1:12], perc251990,m12,'cubic');
int_P_75_2060  = interp1([1:12], perc752060,m12,'cubic');
int_P_25_2060 = interp1([1:12], perc252060,m12,'cubic');
int1990 = plot(m12, p12_1990, 'black');
hold on
int2060 = plot(m12, p12_2060, 'r');

% int_meanX1990 = [1:length(int_T_25_1990), length(int_T_75_1990):-1:1];
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
%% rcp85 temp plot
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
%% Annotations
annotation('textbox', [0.45, 0.81, 0.1, 0.1], 'String', 'a', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'bold')
annotation('textbox', [0.87, 0.81, 0.1, 0.1], 'String', 'b', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'bold')
annotation('textbox', [0.45, 0.37, 0.1, 0.1], 'String', 'c', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'bold')
annotation('textbox', [0.87, 0.37, 0.1, 0.1], 'String', 'd', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'bold')
%% Save figure
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/Figures/'Alex and bo forcing data'/TVC/
% cd C:/Users/jadru/'OneDrive - Northumbria University - Production Azure AD'/Documents/Figures/'Alex and bo forcing data'/TVC/
exportgraphics(gcf, "rcps_tiled.jpg", "Resolution",300)
%% Precip Ks test
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

%% Temperature Ks test
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